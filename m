Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C28C31D95
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 21:25:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB5D222A4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 21:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB5D222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440CHS1gG2zDqM2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:25:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440CFR4nx9zDqHP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 08:23:55 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id n71so6839510ota.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 13:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=OZi5qeKyemTwFrkRIe6rM2nfjxLljMfmiFgKI5v1Pmk=;
 b=O67ofuzWQy5kmtUplmEcZ5Ofcyj3pLp8auZsj7yXiO7/KavMy3OsayEmiFDQ/TN5/Z
 Le+P3JXuXs4lNZqHm2+vWzMx9DcZ+/C5vpHYjrQ4r8h2R06RTs0mJEU1JNsOud8qawX/
 BT65Jn8MCiaRIh9z9lLse3nEE2O30pqB5WT7zYexxE8qs0FbxVnXetENwd7XtzCBTnPb
 eNmz1moC89IkR+L8DVtnChaQsCXWaPpjn4SWvzdjSOlb2qFtxVw4PG7Io/Zyk9Oz0beF
 dfI1c9Qlyt5Y7y/Sn+i0UW7jlp6EHyotWQz70YSecu7gjLtYK2BAXOPKZkVutrtbNGco
 5bPw==
X-Gm-Message-State: AHQUAubyYFCMNHMU+gF8RgCs5nOhgKf2Lg10+yapUsC9HbBV2vG56/8x
 AUcuVq1GyGYSTd/I/QmvFw==
X-Google-Smtp-Source: AHgI3IbFiYWp1blgcT1bjroj4h2TCTpGw8ddd9reFzOyK6+B6zlbt5lRuTNVoz1Z7HbREJBQA5pJ/A==
X-Received: by 2002:aca:3155:: with SMTP id x82mr140568oix.55.1550093033106;
 Wed, 13 Feb 2019 13:23:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r203sm187427oih.11.2019.02.13.13.23.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 13:23:52 -0800 (PST)
Date: Wed, 13 Feb 2019 15:23:47 -0600
From: Rob Herring <robh@kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
Message-ID: <20190213212347.GA26140@bogus>
References: <20190205153924.7204-1-pankaj.bansal@nxp.com>
 <20190205153924.7204-2-pankaj.bansal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190205153924.7204-2-pankaj.bansal@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list : OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Leo Li <leoyang.li@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 05, 2019 at 10:14:40AM +0000, Pankaj Bansal wrote:
> an FPGA-based system controller, called “Qixis”, which
> manages several critical system features, including:
> • Reset sequencing
> • Power supply configuration
> • Board configuration
> • hardware configuration
> 
> The qixis registers are accessible over one or more system-specific
> interfaces, typically I2C, JTAG or an embedded processor.
> 
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
> 
> Notes:
>     V4:
>     - No Change
>     V3:
>     - Added boardname based compatible field in bindings
>     - Added bindings for MMIO based FPGA
>     V2:
>     - No change
> 
>  .../bindings/soc/fsl/qixis_ctrl.txt          | 53 ++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt b/Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt
> new file mode 100644
> index 000000000000..5d510df14be8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt
> @@ -0,0 +1,53 @@
> +* QIXIS FPGA block
> +
> +an FPGA-based system controller, called “Qixis”, which
> +manages several critical system features, including:
> +• Configuration switch monitoring
> +• Power on/off sequencing
> +• Reset sequencing
> +• Power supply configuration
> +• Board configuration
> +• hardware configuration
> +• Background power data collection (DCM)
> +• Fault monitoring
> +• RCW bypass SRAM (replace flash RCW with internal RCW) (NOR only)
> +• Dedicated functional validation blocks (POSt/IRS, triggered event, and so on)
> +• I2C master for remote board control even with no DUT available
> +
> +The qixis registers are accessible over one or more system-specific interfaces,
> +typically I2C, JTAG or an embedded processor.
> +
> +FPGA connected to I2C:
> +Required properties:
> +
> + - compatible: should be a board-specific string followed by a string
> +   indicating the type of FPGA.  Example:
> +	"fsl,<board>-fpga", "fsl,fpga-qixis-i2c"

You don't really need the '-i2c' part because it will only get bound to 
an i2c based driver when a child of an i2c controller.

> + - reg : i2c address of the qixis device.
> +
> +Example (LX2160A-QDS):
> +	/* The FPGA node */
> +        fpga@66 {
> +		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> +		reg = <0x66>;

> +		#address-cells = <1>;
> +		#size-cells = <0>;

You don't need this unless you have child nodes with 'reg'.

> +	}
> +
> +* Freescale on-board FPGA
> +
> +This is the memory-mapped registers for on board FPGA.
> +
> +Required properties:
> +- compatible: should be a board-specific string followed by a string
> +  indicating the type of FPGA.  Example:
> +	"fsl,<board>-fpga", "fsl,fpga-qixis"
> +- reg: should contain the address and the length of the FPGA register set.
> +
> +Example (LS2080A-RDB):
> +
> +        cpld@3,0 {
> +                compatible = "fsl,ls2080ardb-fpga", "fsl,fpga-qixis";
> +                reg = <0x3 0 0x10000>;
> +        };
> +
> -- 
> 2.17.1
> 
