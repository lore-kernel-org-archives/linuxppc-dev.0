Return-Path: <wg@grandegger.com>
Message-ID: <4E4404E6.5060302@grandegger.com>
Date: Thu, 11 Aug 2011 18:35:50 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH v11 5/6] flexcan: Prefer device tree clock frequency if
	available.
References: <1313078831-2511-1-git-send-email-holt@sgi.com>
	<1313078831-2511-6-git-send-email-holt@sgi.com>
In-Reply-To: <1313078831-2511-6-git-send-email-holt@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2011 06:07 PM, Robin Holt wrote:
> If our CAN device's device tree node has a clock-frequency property,
> then use that value for the can devices clock frequency.  If not, fall
> back to asking the platform/mach code for the clock frequency associated
> with the flexcan device.
> 
> Signed-off-by: Robin Holt <holt@sgi.com>
> To: Kumar Gala <galak@kernel.crashing.org>
> To: Wolfgang Grandegger <wg@grandegger.com>,
> To: Marc Kleine-Budde <mkl@pengutronix.de>,
> To: U Bhaskar-B22300 <B22300@freescale.com>
> To: Scott Wood <scottwood@freescale.com>
> To: Grant Likely <grant.likely@secretlab.ca>
> Cc: socketcan-core@lists.berlios.de,
> Cc: netdev@vger.kernel.org,
> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> ---
>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |    2 +
>  drivers/net/can/flexcan.c                          |   33 +++++++++++++++-----
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index c78dcbb..a4382c7 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -11,6 +11,7 @@ Required properties:
>  
>  - reg : Offset and length of the register set for this device
>  - interrupts : Interrupt tuple for this device
> +- clock-frequency : The oscillator frequency driving the flexcan device
>  
>  Example:
>  
> @@ -19,4 +20,5 @@ Example:
>            reg = <0x1c000 0x1000>;
>            interrupts = <48 0x2>;
>            interrupt-parent = <&mpic>;
> +          clock-frequency = <0x0bebc1fc>;

             clock-frequency = <200000000>; // filled in by bootloader

Is better readable. You should also add the comment.
	
Wolfgang.
