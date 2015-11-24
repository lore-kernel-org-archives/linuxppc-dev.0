Return-Path: <robherring2@gmail.com>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71AD81A0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 10:20:10 +1100 (AEDT)
Received: by obbww6 with SMTP id ww6so26198435obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 15:20:08 -0800 (PST)
Date: Tue, 24 Nov 2015 17:20:01 -0600
From: Rob Herring <robh@kernel.org>
To: Jia Hongtao <hongtao.jia@freescale.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 scottwood@freescale.com
Subject: Re: [PATCH V4 1/5] dt-bindings: Add QorIQ TMU thermal bindings
Message-ID: <20151124232001.GA2958@rob-hp-laptop>
References: <1448347968-37766-1-git-send-email-hongtao.jia@freescale.com>
 <1448347968-37766-2-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448347968-37766-2-git-send-email-hongtao.jia@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 24, 2015 at 02:52:44PM +0800, Jia Hongtao wrote:
> Add bindings documentation for TMU (Thermal Monitoring Unit) on QorIQ
> platform.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> Reviewed-by: Scott Wood <scottwood@freescale.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/thermal/qoriq-thermal.txt  | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> new file mode 100644
> index 0000000..66223d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> @@ -0,0 +1,63 @@
> +* Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
> +
> +Required properties:
> +- compatible : Must include "fsl,qoriq-tmu". The version of the device is
> +	determined by the TMU IP Block Revision Register (IPBRR0) at
> +	offset 0x0BF8.
> +	Table of correspondences between IPBRR0 values and example  chips:
> +		Value           Device
> +		----------      -----
> +		0x01900102      T1040
> +- reg : Address range of TMU registers.
> +- interrupts : Contains the interrupt for TMU.
> +- fsl,tmu-range : The values to be programmed into TTRnCR, as specified by
> +	the SoC reference manual. The first cell is TTR0CR, the second is
> +	TTR1CR, etc.
> +- fsl,tmu-calibration : A list of cell pairs containing temperature
> +	calibration data, as specified by the SoC reference manual.
> +	The first cell of each pair is the value to be written to TTCFGR,
> +	and the second is the value to be written to TSCFGR.
> +
> +Example:
> +
> +tmu@f0000 {
> +	compatible = "fsl,qoriq-tmu";
> +	reg = <0xf0000 0x1000>;
> +	interrupts = <18 2 0 0>;
> +	fsl,tmu-range = <0x000a0000 0x00090026 0x0008004a 0x0001006a>;
> +	fsl,tmu-calibration = <0x00000000 0x00000025
> +			       0x00000001 0x00000028
> +			       0x00000002 0x0000002d
> +			       0x00000003 0x00000031
> +			       0x00000004 0x00000036
> +			       0x00000005 0x0000003a
> +			       0x00000006 0x00000040
> +			       0x00000007 0x00000044
> +			       0x00000008 0x0000004a
> +			       0x00000009 0x0000004f
> +			       0x0000000a 0x00000054
> +
> +			       0x00010000 0x0000000d
> +			       0x00010001 0x00000013
> +			       0x00010002 0x00000019
> +			       0x00010003 0x0000001f
> +			       0x00010004 0x00000025
> +			       0x00010005 0x0000002d
> +			       0x00010006 0x00000033
> +			       0x00010007 0x00000043
> +			       0x00010008 0x0000004b
> +			       0x00010009 0x00000053
> +
> +			       0x00020000 0x00000010
> +			       0x00020001 0x00000017
> +			       0x00020002 0x0000001f
> +			       0x00020003 0x00000029
> +			       0x00020004 0x00000031
> +			       0x00020005 0x0000003c
> +			       0x00020006 0x00000042
> +			       0x00020007 0x0000004d
> +			       0x00020008 0x00000056
> +
> +			       0x00030000 0x00000012
> +			       0x00030001 0x0000001d>;
> +};
> -- 
> 2.1.0.27.g96db324
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
