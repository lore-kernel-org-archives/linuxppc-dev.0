Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA14C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:10:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254442084D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckk8vwGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254442084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TBMl6JmWzDqfP
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 18:10:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ckk8vwGi";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=shawnguo@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ckk8vwGi"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TBBN1WM5zF3Fc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 18:02:20 +1100 (AEDT)
Received: from dragon (unknown [45.56.155.247])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 422AF20645;
 Mon,  8 Oct 2018 07:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538982138;
 bh=akX4ilV4bVm5CUc18rZGQLlEO4XbQnkGKzN/vXmkXdc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ckk8vwGiHSdX82EEAogNKS6a3zeH8LUoDS19X0DsT1oPbQW1w9vLZyvFLYDRTqlfA
 rVsAA4HlvrB66mcUI/XfrYFwq1tnnPaByJugxFP3nEwm/bs4QGGvzAhp+xlZCSnjiF
 al3jZgjQXx3Yhe092AtNBMRdFBDhl/xa74YuBwgo=
Date: Mon, 8 Oct 2018 15:01:45 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 22/36] dt-bindings: arm: Convert FSL board/soc bindings
 to json-schema
Message-ID: <20181008070142.GM3587@dragon>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-23-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005165848.3474-23-robh@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
 Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jonathan Cameron <jic23@kernel.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 05, 2018 at 11:58:34AM -0500, Rob Herring wrote:
> Convert Freescale SoC bindings to DT schema format using json-schema.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/armadeus.txt      |   6 -
>  Documentation/devicetree/bindings/arm/bhf.txt |   6 -
>  .../bindings/arm/compulab-boards.txt          |  25 ---
>  Documentation/devicetree/bindings/arm/fsl.txt | 185 ------------------
>  .../devicetree/bindings/arm/fsl.yaml          | 166 ++++++++++++++++
>  .../devicetree/bindings/arm/i2se.txt          |  22 ---
>  .../devicetree/bindings/arm/olimex.txt        |  10 -
>  .../devicetree/bindings/arm/technologic.txt   |  23 ---
>  8 files changed, 166 insertions(+), 277 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/armadeus.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/bhf.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/fsl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/fsl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/i2se.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/olimex.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/technologic.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/armadeus.txt b/Documentation/devicetree/bindings/arm/armadeus.txt
> deleted file mode 100644
> index 9821283ff516..000000000000
> --- a/Documentation/devicetree/bindings/arm/armadeus.txt
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -Armadeus i.MX Platforms Device Tree Bindings
> ------------------------------------------------
> -
> -APF51: i.MX51 based module.
> -Required root node properties:
> -    - compatible = "armadeus,imx51-apf51", "fsl,imx51";
> diff --git a/Documentation/devicetree/bindings/arm/bhf.txt b/Documentation/devicetree/bindings/arm/bhf.txt
> deleted file mode 100644
> index 886b503caf9c..000000000000
> --- a/Documentation/devicetree/bindings/arm/bhf.txt
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -Beckhoff Automation Platforms Device Tree Bindings
> ---------------------------------------------------
> -
> -CX9020 Embedded PC
> -Required root node properties:
> -    - compatible = "bhf,cx9020", "fsl,imx53";
> diff --git a/Documentation/devicetree/bindings/arm/compulab-boards.txt b/Documentation/devicetree/bindings/arm/compulab-boards.txt
> deleted file mode 100644
> index 42a10285af9c..000000000000
> --- a/Documentation/devicetree/bindings/arm/compulab-boards.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -CompuLab SB-SOM is a multi-module baseboard capable of carrying:
> - - CM-T43
> - - CM-T54
> - - CM-QS600
> - - CL-SOM-AM57x
> - - CL-SOM-iMX7
> -modules with minor modifications to the SB-SOM assembly.
> -
> -Required root node properties:
> -    - compatible = should be "compulab,sb-som"
> -
> -Compulab CL-SOM-iMX7 is a miniature System-on-Module (SoM) based on
> -Freescale i.MX7 ARM Cortex-A7 System-on-Chip.
> -
> -Required root node properties:
> -    - compatible = "compulab,cl-som-imx7", "fsl,imx7d";
> -
> -Compulab SBC-iMX7 is a single board computer based on the
> -Freescale i.MX7 system-on-chip. SBC-iMX7 is implemented with
> -the CL-SOM-iMX7 System-on-Module providing most of the functions,
> -and SB-SOM-iMX7 carrier board providing additional peripheral
> -functions and connectors.
> -
> -Required root node properties:
> -    - compatible = "compulab,sbc-imx7", "compulab,cl-som-imx7", "fsl,imx7d";
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> deleted file mode 100644
> index 1e775aaa5c5b..000000000000
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ /dev/null
> @@ -1,185 +0,0 @@
> -Freescale i.MX Platforms Device Tree Bindings
> ------------------------------------------------
> -
> -i.MX23 Evaluation Kit
> -Required root node properties:
> -    - compatible = "fsl,imx23-evk", "fsl,imx23";
> -
> -i.MX25 Product Development Kit
> -Required root node properties:
> -    - compatible = "fsl,imx25-pdk", "fsl,imx25";
> -
> -i.MX27 Product Development Kit
> -Required root node properties:
> -    - compatible = "fsl,imx27-pdk", "fsl,imx27";
> -
> -i.MX28 Evaluation Kit
> -Required root node properties:
> -    - compatible = "fsl,imx28-evk", "fsl,imx28";
> -
> -i.MX51 Babbage Board
> -Required root node properties:
> -    - compatible = "fsl,imx51-babbage", "fsl,imx51";
> -
> -i.MX53 Automotive Reference Design Board
> -Required root node properties:
> -    - compatible = "fsl,imx53-ard", "fsl,imx53";
> -
> -i.MX53 Evaluation Kit
> -Required root node properties:
> -    - compatible = "fsl,imx53-evk", "fsl,imx53";
> -
> -i.MX53 Quick Start Board
> -Required root node properties:
> -    - compatible = "fsl,imx53-qsb", "fsl,imx53";
> -
> -i.MX53 Smart Mobile Reference Design Board
> -Required root node properties:
> -    - compatible = "fsl,imx53-smd", "fsl,imx53";
> -
> -i.MX6 Quad Armadillo2 Board
> -Required root node properties:
> -    - compatible = "fsl,imx6q-arm2", "fsl,imx6q";
> -
> -i.MX6 Quad SABRE Lite Board
> -Required root node properties:
> -    - compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
> -
> -i.MX6 Quad SABRE Smart Device Board
> -Required root node properties:
> -    - compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
> -
> -i.MX6 Quad SABRE Automotive Board
> -Required root node properties:
> -    - compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
> -
> -i.MX6SLL EVK board
> -Required root node properties:
> -    - compatible = "fsl,imx6sll-evk", "fsl,imx6sll";
> -
> -Generic i.MX boards
> --------------------
> -
> -No iomux setup is done for these boards, so this must have been configured
> -by the bootloader for boards to work with the generic bindings.
> -
> -i.MX27 generic board
> -Required root node properties:
> -    - compatible = "fsl,imx27";
> -
> -i.MX51 generic board
> -Required root node properties:
> -    - compatible = "fsl,imx51";
> -
> -i.MX53 generic board
> -Required root node properties:
> -    - compatible = "fsl,imx53";
> -
> -i.MX6q generic board
> -Required root node properties:
> -    - compatible = "fsl,imx6q";
> -
> -Freescale Vybrid Platform Device Tree Bindings
> -----------------------------------------------
> -
> -For the Vybrid SoC familiy all variants with DDR controller are supported,
> -which is the VF5xx and VF6xx series. Out of historical reasons, in most
> -places the kernel uses vf610 to refer to the whole familiy.
> -The compatible string "fsl,vf610m4" is used for the secondary Cortex-M4
> -core support.
> -
> -Required root node compatible property (one of them):
> -    - compatible = "fsl,vf500";
> -    - compatible = "fsl,vf510";
> -    - compatible = "fsl,vf600";
> -    - compatible = "fsl,vf610";
> -    - compatible = "fsl,vf610m4";
> -
> -Freescale LS1021A Platform Device Tree Bindings
> -------------------------------------------------
> -
> -Required root node compatible properties:
> -  - compatible = "fsl,ls1021a";
> -
> -Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
> -----------------------------------------------------------------
> -
> -LS1012A SoC
> -Required root node properties:
> -    - compatible = "fsl,ls1012a";
> -
> -LS1012A ARMv8 based RDB Board
> -Required root node properties:
> -    - compatible = "fsl,ls1012a-rdb", "fsl,ls1012a";
> -
> -LS1012A ARMv8 based FRDM Board
> -Required root node properties:
> -    - compatible = "fsl,ls1012a-frdm", "fsl,ls1012a";
> -
> -LS1012A ARMv8 based QDS Board
> -Required root node properties:
> -    - compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
> -
> -LS1043A SoC
> -Required root node properties:
> -    - compatible = "fsl,ls1043a";
> -
> -LS1043A ARMv8 based RDB Board
> -Required root node properties:
> -    - compatible = "fsl,ls1043a-rdb", "fsl,ls1043a";
> -
> -LS1043A ARMv8 based QDS Board
> -Required root node properties:
> -    - compatible = "fsl,ls1043a-qds", "fsl,ls1043a";
> -
> -LS1046A SoC
> -Required root node properties:
> -    - compatible = "fsl,ls1046a";
> -
> -LS1046A ARMv8 based QDS Board
> -Required root node properties:
> -    - compatible = "fsl,ls1046a-qds", "fsl,ls1046a";
> -
> -LS1046A ARMv8 based RDB Board
> -Required root node properties:
> -    - compatible = "fsl,ls1046a-rdb", "fsl,ls1046a";
> -
> -LS1088A SoC
> -Required root node properties:
> -    - compatible = "fsl,ls1088a";
> -
> -LS1088A ARMv8 based QDS Board
> -Required root node properties:
> -    - compatible = "fsl,ls1088a-qds", "fsl,ls1088a";
> -
> -LS1088A ARMv8 based RDB Board
> -Required root node properties:
> -    - compatible = "fsl,ls1088a-rdb", "fsl,ls1088a";
> -
> -LS2080A SoC
> -Required root node properties:
> -    - compatible = "fsl,ls2080a";
> -
> -LS2080A ARMv8 based Simulator model
> -Required root node properties:
> -    - compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
> -
> -LS2080A ARMv8 based QDS Board
> -Required root node properties:
> -    - compatible = "fsl,ls2080a-qds", "fsl,ls2080a";
> -
> -LS2080A ARMv8 based RDB Board
> -Required root node properties:
> -    - compatible = "fsl,ls2080a-rdb", "fsl,ls2080a";
> -
> -LS2088A SoC
> -Required root node properties:
> -    - compatible = "fsl,ls2088a";
> -
> -LS2088A ARMv8 based QDS Board
> -Required root node properties:
> -    - compatible = "fsl,ls2088a-qds", "fsl,ls2088a";
> -
> -LS2088A ARMv8 based RDB Board
> -Required root node properties:
> -    - compatible = "fsl,ls2088a-rdb", "fsl,ls2088a";
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> new file mode 100644
> index 000000000000..5241fa92e3d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -0,0 +1,166 @@
> +# SPDX-License-Identifier: None
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/arm/fsl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Shawn Guo <shawn.guo@freescale.com>

The email address has been unavailable for long time.  Please use
Shawn Guo <shawnguo@kernel.org>.

> +  - Shaohui Xie <Shaohui.Xie@nxp.com>

Li Yang <leoyang.li@nxp.com> is the co-maintainer for Layerscape.

> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: i.MX23 based Boards
> +        items:
> +          - enum:
> +              - fsl,imx23-evk
> +              - olimex,imx23-olinuxino
> +          - const: fsl,imx23
> +
> +      - description: i.MX25 Product Development Kit
> +        items:
> +          - enum:
> +              - fsl,imx25-pdk
> +          - const: fsl,imx25
> +
> +      - description: i.MX27 Product Development Kit
> +        items:
> +          - enum:
> +              - fsl,imx27-pdk
> +          - const: fsl,imx27
> +
> +      - description: i.MX28 based Boards
> +        items:
> +          - enum:
> +              - fsl,imx28-evk
> +              - i2se,duckbill
> +              - i2se,duckbill-2
> +              - technologic,imx28-ts4600
> +          - const: fsl,imx28
> +      - items:

The schema is new to me.  This line looks unusual to me, so you may want
to double check.

> +          - enum:
> +              - i2se,duckbill-2-485
> +              - i2se,duckbill-2-enocean
> +              - i2se,duckbill-2-spi
> +          - const: i2se,duckbill-2
> +          - const: fsl,imx28
> +
> +      - description: i.MX51 Babbage Board

i.MX51 based Boards

> +        items:
> +          - enum:
> +              - armadeus,imx51-apf51
> +              - fsl,imx51-babbage
> +              - technologic,imx51-ts4800
> +          - const: fsl,imx51
> +
> +      - description: i.MX53 Boards

i.MX53 based Boards

Shawn

> +        items:
> +          - enum:
> +              - bhf,cx9020
> +              - fsl,imx53-ard
> +              - fsl,imx53-evk
> +              - fsl,imx53-qsb
> +              - fsl,imx53-smd
> +          - const: fsl,imx53
> +
> +      - description: i.MX6Q based Boards
> +        items:
> +          - enum:
> +              - fsl,imx6q-arm2
> +              - fsl,imx6q-sabrelite
> +              - fsl,imx6q-sabresd
> +              - fsl,imx6q-sabreauto
> +              - technologic,imx6q-ts4900
> +              - technologic,imx6q-ts7970
> +          - const: fsl,imx6q
> +
> +      - description: i.MX6DL based Boards
> +        items:
> +          - enum:
> +              - technologic,imx6dl-ts4900
> +              - technologic,imx6dl-ts7970
> +          - const: fsl,imx6dl
> +
> +      - description: i.MX6SLL based Boards
> +        items:
> +          - enum:
> +              - fsl,imx6sll-evk
> +          - const: fsl,imx6sll
> +
> +      - description:
> +          Compulab SBC-iMX7 is a single board computer based on the
> +          Freescale i.MX7 system-on-chip. SBC-iMX7 is implemented with
> +          the CL-SOM-iMX7 System-on-Module providing most of the functions,
> +          and SB-SOM-iMX7 carrier board providing additional peripheral
> +          functions and connectors.
> +        items:
> +          - const: compulab,sbc-imx7
> +          - const: compulab,cl-som-imx7
> +          - const: fsl,imx7d
> +
> +      - description:
> +          Freescale Vybrid Platform Device Tree Bindings
> +
> +          For the Vybrid SoC familiy all variants with DDR controller are supported,
> +          which is the VF5xx and VF6xx series. Out of historical reasons, in most
> +          places the kernel uses vf610 to refer to the whole familiy.
> +          The compatible string "fsl,vf610m4" is used for the secondary Cortex-M4
> +          core support.
> +        items:
> +          - enum:
> +              - fsl,vf500
> +              - fsl,vf510
> +              - fsl,vf600
> +              - fsl,vf610
> +              - fsl,vf610m4
> +
> +      - description: LS1021A based Boards
> +        items:
> +          - enum:
> +              - fsl,ls1012a-rdb
> +              - fsl,ls1012a-frdm
> +              - fsl,ls1012a-qds
> +          - const: fsl,ls1021a
> +
> +      - description: LS1043A based Boards
> +        items:
> +          - enum:
> +              - fsl,ls1043a-rdb
> +              - fsl,ls1043a-qds
> +          - const: fsl,ls1043a
> +
> +      - description: LS1046A based Boards
> +        items:
> +          - enum:
> +              - fsl,ls1046a-qds
> +              - fsl,ls1046a-rdb
> +          - const: fsl,ls1046a
> +
> +      - description: LS1088A based Boards
> +        items:
> +          - enum:
> +              - fsl,ls1088a-qds
> +              - fsl,ls1088a-rdb
> +          - const: fsl,ls1088a
> +
> +      - description: LS2080A based Boards
> +        items:
> +          - enum:
> +              - fsl,ls2080a-simu
> +              - fsl,ls2080a-qds
> +              - fsl,ls2080a-rdb
> +          - const: fsl,ls2080a
> +
> +      - description: LS2088A based Boards
> +        items:
> +          - enum:
> +              - fsl,ls2088a-qds
> +              - fsl,ls2088a-rdb
> +          - const: fsl,ls2088a
> +
> +...
> diff --git a/Documentation/devicetree/bindings/arm/i2se.txt b/Documentation/devicetree/bindings/arm/i2se.txt
> deleted file mode 100644
> index dbd54a3aa07d..000000000000
> --- a/Documentation/devicetree/bindings/arm/i2se.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -I2SE Device Tree Bindings
> --------------------------
> -
> -Duckbill Board
> -Required root node properties:
> -    - compatible = "i2se,duckbill", "fsl,imx28";
> -
> -Duckbill 2 Board
> -Required root node properties:
> -    - compatible = "i2se,duckbill-2", "fsl,imx28";
> -
> -Duckbill 2 485 Board
> -Required root node properties:
> -    - compatible = "i2se,duckbill-2-485", "i2se,duckbill-2", "fsl,imx28";
> -
> -Duckbill 2 EnOcean Board
> -Required root node properties:
> -    - compatible = "i2se,duckbill-2-enocean", "i2se,duckbill-2", "fsl,imx28";
> -
> -Duckbill 2 SPI Board
> -Required root node properties:
> -    - compatible = "i2se,duckbill-2-spi", "i2se,duckbill-2", "fsl,imx28";
> diff --git a/Documentation/devicetree/bindings/arm/olimex.txt b/Documentation/devicetree/bindings/arm/olimex.txt
> deleted file mode 100644
> index d726aeca56be..000000000000
> --- a/Documentation/devicetree/bindings/arm/olimex.txt
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -Olimex Device Tree Bindings
> ----------------------------
> -
> -SAM9-L9260 Board
> -Required root node properties:
> -    - compatible = "olimex,sam9-l9260", "atmel,at91sam9260";
> -
> -i.MX23 Olinuxino Low Cost Board
> -Required root node properties:
> -    - compatible = "olimex,imx23-olinuxino", "fsl,imx23";
> diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
> deleted file mode 100644
> index f1cedc00dcab..000000000000
> --- a/Documentation/devicetree/bindings/arm/technologic.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Technologic Systems Platforms Device Tree Bindings
> ---------------------------------------------------
> -
> -TS-4600 is a System-on-Module based on the Freescale i.MX28 System-on-Chip.
> -It can be mounted on a carrier board providing additional peripheral connectors.
> -Required root node properties:
> -	- compatible = "technologic,imx28-ts4600", "fsl,imx28"
> -
> -TS-4800 board
> -Required root node properties:
> -	- compatible = "technologic,imx51-ts4800", "fsl,imx51";
> -
> -TS-4900 is a System-on-Module based on the Freescale i.MX6 System-on-Chip.
> -It can be mounted on a carrier board providing additional peripheral connectors.
> -Required root node properties:
> -	- compatible = "technologic,imx6dl-ts4900", "fsl,imx6dl"
> -	- compatible = "technologic,imx6q-ts4900", "fsl,imx6q"
> -
> -TS-7970 is a System-on-Module based on the Freescale i.MX6 System-on-Chip.
> -It can be mounted on a carrier board providing additional peripheral connectors.
> -Required root node properties:
> -	- compatible = "technologic,imx6dl-ts7970", "fsl,imx6dl"
> -	- compatible = "technologic,imx6q-ts7970", "fsl,imx6q"
> -- 
> 2.17.1
> 
