Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNbbh4WPCzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 23:47:12 +1000 (AEST)
Received: by mail-oi0-f67.google.com with SMTP id r4so5451017oib.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jun 2016 06:47:12 -0700 (PDT)
Date: Mon, 6 Jun 2016 08:47:08 -0500
From: Rob Herring <robh@kernel.org>
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, galak@codeaurora.org,
 scott.wood@nxp.com, shawnguo@kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] dt-bindings: Update QorIQ TMU thermal bindings
Message-ID: <20160606134708.GA27357@rob-hp-laptop>
References: <1464937059-19349-1-git-send-email-hongtao.jia@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464937059-19349-1-git-send-email-hongtao.jia@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 03, 2016 at 02:57:33PM +0800, Jia Hongtao wrote:
> For different types of SoC the sensor id and endianness may vary.
> "#thermal-sensor-cells" is used to provide sensor id information.
> "little-endian" property is to tell the endianness of TMU.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
>  .../devicetree/bindings/thermal/qoriq-thermal.txt     | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> index 66223d5..8eeef80 100644
> --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> @@ -1,22 +1,28 @@
>  * Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
>  
>  Required properties:
> -- compatible : Must include "fsl,qoriq-tmu". The version of the device is
> +- compatible: Must include "fsl,qoriq-tmu". The version of the device is

Please split functional changes from formatting changes. This one seems 
pretty pointless.

>  	determined by the TMU IP Block Revision Register (IPBRR0) at
>  	offset 0x0BF8.
> -	Table of correspondences between IPBRR0 values and example  chips:
> +	Table of correspondences between IPBRR0 values and example chips:
>  		Value           Device
>  		----------      -----
>  		0x01900102      T1040
> -- reg : Address range of TMU registers.
> -- interrupts : Contains the interrupt for TMU.
> -- fsl,tmu-range : The values to be programmed into TTRnCR, as specified by
> +- reg: Address range of TMU registers.
> +- interrupts: Contains the interrupt for TMU.
> +- fsl,tmu-range: The values to be programmed into TTRnCR, as specified by
>  	the SoC reference manual. The first cell is TTR0CR, the second is
>  	TTR1CR, etc.
> -- fsl,tmu-calibration : A list of cell pairs containing temperature
> +- fsl,tmu-calibration: A list of cell pairs containing temperature
>  	calibration data, as specified by the SoC reference manual.
>  	The first cell of each pair is the value to be written to TTCFGR,
>  	and the second is the value to be written to TSCFGR.
> +- #thermal-sensor-cells: Must be 1. The sensor specifier is the monitoring
> +	site ID, and represents the "n" in TRITSRn and TRATSRn.
> +
> +Optional property:
> +- little-endian: If present, the TMU registers are little endian.  If absent,
> +	the default is big endian.
>  
>  Example:
>  
> @@ -60,4 +66,5 @@ tmu@f0000 {
>  
>  			       0x00030000 0x00000012
>  			       0x00030001 0x0000001d>;
> +	#thermal-sensor-cells = <1>;
>  };
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
