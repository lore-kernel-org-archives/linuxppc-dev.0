Return-Path: <B11780@freescale.com>
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc/mpic: Add Open-PIC global timer document
Date: Fri, 10 Aug 2012 13:35:35 +0000
Message-ID: <94D8FBCC-7AA8-4F50-90A3-2A11F579AC34@freescale.com>
References: <1344578002-8057-1-git-send-email-Dongsheng.wang@freescale.com>
In-Reply-To: <1344578002-8057-1-git-send-email-Dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "devicetree-discuss@lists.ozlabs.org Discuss"
 <devicetree-discuss@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 10, 2012, at 12:53 AM, <Dongsheng.wang@freescale.com> <Dongsheng.wan=
g@freescale.com> wrote:

> From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
>=20
> Add a description of the OPEN-PIC global timer in the OPEN-PIC document.
>=20
> Moidfy mpic-timer document. 1.Add a TFRR register region. This register
> is written by software to report the clocking frequency of the PIC timers=
.
> 2.Add a device_type. The global timer in line with the OPEN-PIC specifica=
tion.
>=20
> Signed-off-by: Wang Dongsheng <Dongsheng.Wang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Documentation/devicetree/bindings/open-pic.txt     |   46 +++++++++++++++=
+++++

Let's separate out the open-pic.txt timer binding change into its own patch=
 from the FSL timer binding & dtsi updates.

> .../devicetree/bindings/powerpc/fsl/mpic-timer.txt |   21 +++++----
> arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi    |    7 ++-
> arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi            |    7 ++-
> 4 files changed, 66 insertions(+), 15 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/open-pic.txt b/Documentati=
on/devicetree/bindings/open-pic.txt
> index 909a902..045c2e9 100644
> --- a/Documentation/devicetree/bindings/open-pic.txt
> +++ b/Documentation/devicetree/bindings/open-pic.txt
> @@ -92,6 +92,52 @@ Example 2:
>=20
> * References
>=20
> +* Open PIC global timers
> +
> +Required properties:
> +- compatible: "open-pic,global-timer"
> +
> +- reg : Contains two regions.  The first is the timer frequency reportin=
g
> +  register for the group.  The second is the main timer register bank
> +  (GTCCR, GTBCR, GTVPR, GTDR).
> +
> +- available-ranges: use <start count> style section to define which
> +  timer interrupts can be used.  This property is optional; without this=
,
> +  all timers within the group can be used.
> +
> +- interrupts: one interrupt per timer in the group, in order, starting
> +  with timer zero.  If available-ranges is present, only the interrupts
> +  that correspond to available timers shall be present.
> +

If we are going to require device_type property it should be in the binding=
.

Based on the comments in ePAPR, I recommend dropping device_type from the t=
imer binding.

> +* Examples
> +
> +Example 1:
> +
> +	/* Note that this requires #interrupt-cells to be 4 */
> +	timer: timer@010f0 {
> +		compatible =3D "open-pic,global-timer";
> +		device_type =3D "open-pic";
> +		reg =3D <0x010f0 4 0x01100 0x100>;
> +
> +		/* Another AMP partition is using timer */
> +		available-ranges =3D <2 2>;
> +
> +		interrupts =3D <2 0 3 0
> +		              3 0 3 0>;
> +	};
> +
> +Example 2:
> +
> +	timer: timer@010f0 {
> +		compatible =3D "open-pic,global-timer";
> +		device_type =3D "open-pic";
> +		reg =3D <0x010f0 4 0x01100 0x100>;
> +		interrupts =3D <0 0 3 0
> +			      1 0 3 0
> +			      2 0 3 0
> +		              3 0 3 0>;
> +	};
> +
> [1] Power.org (TM) Standard for Embedded Power Architecture (TM) Platform
>     Requirements (ePAPR), Version 1.0, July 2008.
>     (http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.p=
df)
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt=
 b/Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt
> index df41958..5aafca0 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt
> @@ -1,13 +1,14 @@
> * Freescale MPIC timers
>=20
> Required properties:
> -- compatible: "fsl,mpic-global-timer"
> +- compatible: "fsl,global-timer"

Why are renaming?.. also use of fsl,global-timer is to generic of a name fo=
r the this.

>=20
> -- reg : Contains two regions.  The first is the main timer register bank
> -  (GTCCRxx, GTBCRxx, GTVPRxx, GTDRxx).  The second is the timer control
> +- reg : Contains three regions.  The first is the timer frequency report=
ing
> +  register (TFRRx) for the group.  The second is the main timer register
> +  bank (GTCCRxx, GTBCRxx, GTVPRxx, GTDRxx).  The third is the timer cont=
rol
>   register (TCRx) for the group.
>=20
> -- fsl,available-ranges: use <start count> style section to define which
> +- available-ranges: use <start count> style section to define which
>   timer interrupts can be used.  This property is optional; without this,
>   all timers within the group can be used.
>=20
> @@ -18,19 +19,21 @@ Required properties:
> Example:
> 	/* Note that this requires #interrupt-cells to be 4 */
> 	timer0: timer@41100 {
> -		compatible =3D "fsl,mpic-global-timer";
> -		reg =3D <0x41100 0x100 0x41300 4>;
> +		compatible =3D "fsl,global-timer";
> +		device_type =3D "open-pic";
> +		reg =3D <0x410f0 4 0x41100 0x100 0x41300 4>;
>=20
> 		/* Another AMP partition is using timers 0 and 1 */
> -		fsl,available-ranges =3D <2 2>;
> +		available-ranges =3D <2 2>;
>=20
> 		interrupts =3D <2 0 3 0
> 		              3 0 3 0>;
> 	};
>=20
> 	timer1: timer@42100 {
> -		compatible =3D "fsl,mpic-global-timer";
> -		reg =3D <0x42100 0x100 0x42300 4>;
> +		compatible =3D "fsl,global-timer";
> +		device_type =3D "open-pic";
> +		reg =3D <0x420f0 4 0x42100 0x100 0x42300 4>;
> 		interrupts =3D <4 0 3 0
> 		              5 0 3 0
> 		              6 0 3 0
> diff --git a/arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi b/arch/power=
pc/boot/dts/fsl/pq3-mpic-timer-B.dtsi
> index 8734cff..01cd33c 100644
> --- a/arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi
> @@ -32,9 +32,10 @@
>  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>  */
>=20
> -timer@42100 {
> -	compatible =3D "fsl,mpic-global-timer";
> -	reg =3D <0x42100 0x100 0x42300 4>;
> +timer@420f0 {
> +	compatible =3D "fsl,global-timer";

Shouldn't this be:

	compatible =3D "fsl,mpic-global-timer", "open-pic,global-timer";

> +	device_type =3D "open-pic";
> +	reg =3D <0x420f0 4 0x42100 0x100 0x42300 4>;
> 	interrupts =3D <4 0 3 0
> 		      5 0 3 0
> 		      6 0 3 0
> diff --git a/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi b/arch/powerpc/boot/=
dts/fsl/pq3-mpic.dtsi
> index 71c30eb..c71d8e0 100644
> --- a/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
> @@ -44,9 +44,10 @@ mpic: pic@40000 {
> 	last-interrupt-source =3D <255>;
> };
>=20
> -timer@41100 {
> -	compatible =3D "fsl,mpic-global-timer";
> -	reg =3D <0x41100 0x100 0x41300 4>;
> +timer@410f0 {
> +	compatible =3D "fsl,global-timer";

same as above.

> +	device_type =3D "open-pic";
> +	reg =3D <0x410f0 4 0x41100 0x100 0x41300 4>;
> 	interrupts =3D <0 0 3 0
> 		      1 0 3 0
> 		      2 0 3 0
> --=20
> 1.7.5.1
>=20
>=20
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
