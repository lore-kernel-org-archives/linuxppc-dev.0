Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0134.outbound.protection.outlook.com [207.46.100.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78EF61A0AB3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 08:40:19 +1000 (AEST)
Message-ID: <1428446404.22867.479.camel@freescale.com>
Subject: Re: [PATCH] dt/bindings: qoriq-clock: Add binding for FMan clock mux
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Tue, 7 Apr 2015 17:40:04 -0500
In-Reply-To: <1428379720-3247-1-git-send-email-igal.liberman@freescale.com>
References: <1428379720-3247-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-07 at 07:08 +0300, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
>  .../devicetree/bindings/clock/qoriq-clock.txt      |   59 ++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> index df4a259..a7e84ce 100644
> --- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> @@ -65,6 +65,7 @@ Required properties:
>  		It takes parent's clock-frequency as its clock.
>  	* "fsl,qoriq-platform-pll-1.0" for the platform PLL clock (v1.0)
>  	* "fsl,qoriq-platform-pll-2.0" for the platform PLL clock (v2.0)
> +	* "fsl,fman-clk-mux" for the Frame Manager clock.

Is there any versioning required on this?

>  - #clock-cells: From common clock binding. The number of cells in a
>  	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0"
>  	clocks, or <1> for "fsl,qoriq-core-pll-[1,2].0" clocks.
> @@ -73,6 +74,52 @@ Required properties:
>  	* 0 - equal to the PLL frequency
>  	* 1 - equal to the PLL frequency divided by 2
>  	* 2 - equal to the PLL frequency divided by 4
> +	For "fsl,fman-clk-mux" clocks, the single clock-specifier cell may
> +	take values according the Reset Configuration Word of the specific
> +	device:

fsl,fman-clk-mux nodes have #clock-cells of zero, so I don't understand
this section.

If this is meant to refer to the clock specifier that fsl,fman-clk-mux
nodes use in their input clocks, that is determined by the clock
provider and not the clock consumer.  

-Scott
