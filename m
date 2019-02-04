Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789FEC282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 20:13:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B836220821
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 20:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B836220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tf6b5PFdzDqMC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 07:13:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tf520kbwzDqKg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 07:12:21 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id k98so2024461otk.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 12:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=05TcC0mVNsG1FXSCe7mkTG+0mFL2ljeP6sQuGrocubQ=;
 b=oHjgdxHFaBPg1Wj7amr7+urjjZSuH4eyzu9lAvtblZGqhAUPm7100tDTksZIqxtTqd
 PTR4PmfVtWE+yh+23d0GudQqhA4iHccCOa9fjIPUXNv4+41EuSR895VpDMNSRdnk+rS3
 VcvN7HJGHlc7+npoAwK3ChQASI9A9lwVrFQJnlI7MDXxKzBRbGrueLv7TyiIBSbZvUBn
 rgDtx+qVON/qn7cbCzzwvU8hJbqLnyGUXs6TwzcxRl3QwrS8RcLxfV5ClP/L9tMgllhd
 rKm1wGurxsKg0fjrtvTlgqHqdVpKPztOP1CjyXmRBJb3eaTFmijJMlk7++0FmCOTg+qE
 oZ9w==
X-Gm-Message-State: AHQUAubthp51Pwe9WVFiyrjDRuUP9XkmCTQ4CIEk4/P3tLlM9DQC/LRq
 JHDIzk1pefNs50+aCqz3Luq9vGn5
X-Google-Smtp-Source: AHgI3Ib4XPym2B4rboyRQwVZx/5eO70e0R29TwN1o/TgSP0zdqaP+rRonAMiaCurm5QFCS+pQ3JLvw==
X-Received: by 2002:a9d:71c9:: with SMTP id z9mr670194otj.294.1549311138755;
 Mon, 04 Feb 2019 12:12:18 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com.
 [209.85.210.41])
 by smtp.gmail.com with ESMTPSA id a15sm7303292otd.66.2019.02.04.12.12.17
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 12:12:18 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id v23so1956995otk.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Feb 2019 12:12:17 -0800 (PST)
X-Received: by 2002:aca:31cb:: with SMTP id x194mr580917oix.213.1549311137614; 
 Mon, 04 Feb 2019 12:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20190204143449.25040-1-pankaj.bansal@nxp.com>
 <20190204143449.25040-2-pankaj.bansal@nxp.com>
In-Reply-To: <20190204143449.25040-2-pankaj.bansal@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 4 Feb 2019 14:12:06 -0600
X-Gmail-Original-Message-ID: <CADRPPNTjD1nN2eoyV6NucFYjH4vG8TaCG0u3YgEJd1699d07bQ@mail.gmail.com>
Message-ID: <CADRPPNTjD1nN2eoyV6NucFYjH4vG8TaCG0u3YgEJd1699d07bQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
To: Pankaj Bansal <pankaj.bansal@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Please include device tree binding mailing list and maintainers for
binding patches(cc'ed now).

On Mon, Feb 4, 2019 at 3:15 AM Pankaj Bansal <pankaj.bansal@nxp.com> wrote:
>
> an FPGA-based system controller, called =E2=80=9CQixis=E2=80=9D, which
> manages several critical system features, including:
> =E2=80=A2 Reset sequencing
> =E2=80=A2 Power supply configuration
> =E2=80=A2 Board configuration
> =E2=80=A2 hardware configuration
>
> The qixis registers are accessible over one or more system-specific
> interfaces, typically I2C, JTAG or an embedded processor.
>
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
>
> Notes:
>     V3:
>     - Added boardname based compatible field in bindings
>     - Added bindings for MMIO based FPGA
>     V2:
>     - No change
>
>  .../bindings/soc/fsl/qixis_ctrl.txt          | 53 ++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt b/D=
ocumentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt
> new file mode 100644
> index 000000000000..5d510df14be8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt
> @@ -0,0 +1,53 @@
> +* QIXIS FPGA block
> +
> +an FPGA-based system controller, called =E2=80=9CQixis=E2=80=9D, which
> +manages several critical system features, including:
> +=E2=80=A2 Configuration switch monitoring
> +=E2=80=A2 Power on/off sequencing
> +=E2=80=A2 Reset sequencing
> +=E2=80=A2 Power supply configuration
> +=E2=80=A2 Board configuration
> +=E2=80=A2 hardware configuration
> +=E2=80=A2 Background power data collection (DCM)
> +=E2=80=A2 Fault monitoring
> +=E2=80=A2 RCW bypass SRAM (replace flash RCW with internal RCW) (NOR onl=
y)
> +=E2=80=A2 Dedicated functional validation blocks (POSt/IRS, triggered ev=
ent, and so on)
> +=E2=80=A2 I2C master for remote board control even with no DUT available
> +
> +The qixis registers are accessible over one or more system-specific inte=
rfaces,
> +typically I2C, JTAG or an embedded processor.
> +
> +FPGA connected to I2C:
> +Required properties:
> +
> + - compatible: should be a board-specific string followed by a string
> +   indicating the type of FPGA.  Example:
> +       "fsl,<board>-fpga", "fsl,fpga-qixis-i2c"
> + - reg : i2c address of the qixis device.
> +
> +Example (LX2160A-QDS):
> +       /* The FPGA node */
> +        fpga@66 {
> +               compatible =3D "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c=
";
> +               reg =3D <0x66>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +       }
> +
> +* Freescale on-board FPGA
> +
> +This is the memory-mapped registers for on board FPGA.
> +
> +Required properties:
> +- compatible: should be a board-specific string followed by a string
> +  indicating the type of FPGA.  Example:
> +       "fsl,<board>-fpga", "fsl,fpga-qixis"
> +- reg: should contain the address and the length of the FPGA register se=
t.
> +
> +Example (LS2080A-RDB):
> +
> +        cpld@3,0 {
> +                compatible =3D "fsl,ls2080ardb-fpga", "fsl,fpga-qixis";
> +                reg =3D <0x3 0 0x10000>;
> +        };
> +
> --
> 2.17.1
>
