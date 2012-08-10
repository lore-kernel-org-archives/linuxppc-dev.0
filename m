Return-Path: <B07421@freescale.com>
Message-ID: <50255F49.5050500@freescale.com>
Date: Fri, 10 Aug 2012 14:21:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <Dongsheng.wang@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc/mpic: Add Open-PIC global timer document
References: <1344578002-8057-1-git-send-email-Dongsheng.wang@freescale.com>
In-Reply-To: <1344578002-8057-1-git-send-email-Dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree-discuss@lists.ozlabs.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2012 12:53 AM, Dongsheng.wang@freescale.com wrote:
> From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
> 
> Add a description of the OPEN-PIC global timer in the OPEN-PIC document.
> 
> Moidfy mpic-timer document. 1.Add a TFRR register region. This register
> is written by software to report the clocking frequency of the PIC timers.
> 2.Add a device_type. The global timer in line with the OPEN-PIC specification.
> 
> Signed-off-by: Wang Dongsheng <Dongsheng.Wang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  Documentation/devicetree/bindings/open-pic.txt     |   46 ++++++++++++++++++++
>  .../devicetree/bindings/powerpc/fsl/mpic-timer.txt |   21 +++++----
>  arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi    |    7 ++-
>  arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi            |    7 ++-
>  4 files changed, 66 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/open-pic.txt b/Documentation/devicetree/bindings/open-pic.txt
> index 909a902..045c2e9 100644
> --- a/Documentation/devicetree/bindings/open-pic.txt
> +++ b/Documentation/devicetree/bindings/open-pic.txt
> @@ -92,6 +92,52 @@ Example 2:
>  
>  * References
>  
> +* Open PIC global timers
> +
> +Required properties:
> +- compatible: "open-pic,global-timer"

open-pic isn't a vendor (or software project that acts like a
pseudo-vendor) -- I'd go with "open-pic-global-timer".

> +- reg : Contains two regions.  The first is the timer frequency reporting
> +  register for the group.  The second is the main timer register bank
> +  (GTCCR, GTBCR, GTVPR, GTDR).

Why not just put clock-frequency in the node, instead of describing
TFRR?  I don't think U-Boot currently sets TFRR.

> +- available-ranges: use <start count> style section to define which
> +  timer interrupts can be used.  This property is optional; without this,
> +  all timers within the group can be used.
> +
> +- interrupts: one interrupt per timer in the group, in order, starting
> +  with timer zero.  If available-ranges is present, only the interrupts
> +  that correspond to available timers shall be present.
> +
> +* Examples
> +
> +Example 1:
> +
> +	/* Note that this requires #interrupt-cells to be 4 */
> +	timer: timer@010f0 {

Unit addres shouldn't have leading zeroes.

> +		compatible = "open-pic,global-timer";
> +		device_type = "open-pic";

Remove device_type.  Not only is it deprecated outside of real OF, it's
wrong -- this isn't an openpic, it's just a subset of it.

> +		reg = <0x010f0 4 0x01100 0x100>;
> +
> +		/* Another AMP partition is using timer */
> +		available-ranges = <2 2>;
>
> +
> +		interrupts = <2 0 3 0
> +		              3 0 3 0>;
> +	};
> +
> +Example 2:
> +
> +	timer: timer@010f0 {
> +		compatible = "open-pic,global-timer";
> +		device_type = "open-pic";
> +		reg = <0x010f0 4 0x01100 0x100>;
> +		interrupts = <0 0 3 0
> +			      1 0 3 0
> +			      2 0 3 0
> +		              3 0 3 0>;
> +	};

4-cell interrupt specifiers are specific to Freescale MPICs.  This means
there's no way to describe the timer interrupt on a non-Freescale
openpic.  Again, I suggest we not bother with this in the absence of an
actual need to support the timer on non-Freescale openpic in partitioned
scenarios.  The existing openpic node is sufficient to describe the
hardware in the absence of partitioning.   We could have an
"openpic-no-timer" property to indicate that we're describing it
separately, so that the absence of a timer node isn't ambiguous as to
whether it's an old tree or a partitioned scenario.  An fsl,mpic
compatible would imply openpic-no-timer.

Note that I believe many of the non-Freescale openpic nodes are going to
be found on systems with real Open Firmware, so we can't go changing the
device tree for them.

-Scott
