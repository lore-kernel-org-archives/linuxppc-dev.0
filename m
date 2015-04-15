Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DBEF1A0143
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 03:36:13 +1000 (AEST)
Message-ID: <1429119357.22867.724.camel@freescale.com>
Subject: Re: [v3] dt/bindings: qoriq-clock: Add binding for FMan clock mux
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Wed, 15 Apr 2015 12:35:57 -0500
In-Reply-To: <1429008968-24707-1-git-send-email-igal.liberman@freescale.com>
References: <1429008968-24707-1-git-send-email-igal.liberman@freescale.com>
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

On Tue, 2015-04-14 at 13:56 +0300, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> v3: Addressed feedback from Scott:
> 	- Removed clock specifier description.
> 
> v2: Addressed feedback from Scott:
> 	- Moved the "fman-clk-mux" clock provider details
> 	  under "clocks" property.
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
>  .../devicetree/bindings/clock/qoriq-clock.txt      |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> index b0d7b73..2bb3b38 100644
> --- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> @@ -65,9 +65,10 @@ Required properties:
>  		It takes parent's clock-frequency as its clock.
>  	* "fsl,qoriq-platform-pll-1.0" for the platform PLL clock (v1.0)
>  	* "fsl,qoriq-platform-pll-2.0" for the platform PLL clock (v2.0)
> +	* "fsl,fman-clk-mux" for the Frame Manager clock.
>  - #clock-cells: From common clock binding. The number of cells in a
> -	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0"
> -	clocks, or <1> for "fsl,qoriq-core-pll-[1,2].0" clocks.
> +	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0" and
> +	"fsl,fman-clk-mux" clocks or <1> for "fsl,qoriq-core-pll-[1,2].0".
>  	For "fsl,qoriq-core-pll-1.0" clocks, the single
>  	clock-specifier cell may take the following values:
>  	* 0 - equal to the PLL frequency
> @@ -145,6 +146,18 @@ Example for clock block and clock provider:
>  			clocks = <&sysclk>;
>  			clock-output-names = "platform-pll", "platform-pll-div2";
>  		};
> +
> +		fm0clk: fm0-clk-mux {
> +			#clock-cells = <0>;
> +			reg = <0x10 4>
> +			compatible = "fsl,fman-clk-mux";
> +			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>, <&pll0 3>,
> +				 <&platform_pll 0>, <&pll1 1>, <&pll1 2>;
> +			clock-names = "pll0", "pll0-div2", "pll0-div3",
> +				      "pll0-div4", "platform-pll", "pll1-div2",
> +				      "pll1-div3";
> +			clock-output-names = "fm0-clk";
> +		};
>  	};
>  };
>  

I don't see this register in the manuals for older DPAA chips, such as
p4080 or p3041.  Is it present but undocumented?  Should I be looking
somewhere other than "Clocking Memory Map"?

-Scott
