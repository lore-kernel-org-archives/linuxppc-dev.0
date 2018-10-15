Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63B8C070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 02:46:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA3120652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 02:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YpuRa9fN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA3120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YNBG3mqHzF31L
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 13:46:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="YpuRa9fN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=104.47.1.88; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="YpuRa9fN"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0088.outbound.protection.outlook.com [104.47.1.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YN7G0dM6zF310
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 13:44:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvfXcbcPT92V0EoRrFy9VTWTC15NL6A/GVLru9qx7AQ=;
 b=YpuRa9fNmgcV/tfVg6rvoPPyeADydeLYE1FX09fSRwwOHMiWmLoecKS+UQLPgs5fmT/0ywAqmpiCEsz1vEwaD1CtuaVtwdgvs6KI88gFzM3eVy/EjUIuGqPxVYExtS7ysf37OFsfBci9Y2QzUphLNNqbuPWKOicLKoDsV7M4YEE=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5279.eurprd04.prod.outlook.com (20.177.51.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 02:44:00 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::a45f:ad96:edec:a2df]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::a45f:ad96:edec:a2df%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 02:44:00 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH v4 6/6] arm64: dts: add LX2160ARDB board support
Thread-Topic: [PATCH v4 6/6] arm64: dts: add LX2160ARDB board support
Thread-Index: AQHUW+OAQmr4YeRg8k+lnJ1eSFizYaUU3kmAgArJwGA=
Date: Mon, 15 Oct 2018 02:44:00 +0000
Message-ID: <VI1PR04MB4800555506B64C9E93F9ED36F3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-7-git-send-email-vabhav.sharma@nxp.com>
 <20181008055159.GH3587@dragon>
In-Reply-To: <20181008055159.GH3587@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5279;
 6:4S1KZpJaVMzLqOMOJ6SYKGumCvp7wxrwVLhBcLs2rqCbbFBxJ2gLH9HwpKMnZM/wotFwKk+Gs+FxSroXIRXwOWGZ1KtPgJgmFJDN86K6+gH3FzrHF64Pg3wBx4DYxJKf3mhTUAGwqwIwsvNISEkt2Re3eU1Dos6Z48SE1ZRok1x35Iepcv+dBJhREyJcEEwbMdcuGbbiKE37JcVvZiwi3puVZhHtqleR2L/zaOmXypoB4uytJXlSqgGiUIIPEvhT4GBPg76CuhAutxVhker6W9OAZXaoB8ozyLEjvKR5/OjvcAXQtFh6hLG51UjnzX/htpX7NX0pGX8wchFtwLLeMRbtQM0eb0VI4Uek9OV+MIxp5sto6zrehgmR/fywwEKL3AIcXJSJks79k7kGMrXd/X50oCNQB0bIfBRPKJfe/F5Y9tyLega17lL8v4QdyrK2MDI2STgRag9roVCeKcrJ0Q==;
 5:abnehYpK8KxiVELu3ZJampWfPpyswAjdoHwqJZw0D6+6WO3N5TknekJ6OmKWCQUYeD12vHr3czagW2XykGG30GZBXSDCt6VXJXnt5a+HJcsCE/T5QKNe6JGoqzTJ8xrcTT+ZgKTLxKnU0nk2aR8yj8JsA5X0kwh5xrfFEyfj+kc=;
 7:AeI2nvQXtb55CqP/lQCED2fKuHN4Bf7CLD8EsndysqpikvIPO7loFJMm7d07tuum6Ehr+ee0gTit2ZvGX5zWZUxKdK8bZrPLLIJP2n9bdM3o4tRqApmOfQKfudtxXRdjCW2ICKiYOOF+7QEx9AvCTpDyhh93+MiiIDan+kJInhYVESL6Dk6LKcrnFzFnYukih4VuzFBeodPOtqGlTTG1kaKZ6swAgQ9wuQgStm35A1LjWXjUhLyw4WzcFEfnl+2e
x-ms-office365-filtering-correlation-id: eccb7d9b-4155-4646-c78d-08d632480ff6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5279; 
x-ms-traffictypediagnostic: VI1PR04MB5279:
x-microsoft-antispam-prvs: <VI1PR04MB5279B131D25699F2AC9E9CA4F3FD0@VI1PR04MB5279.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(180628864354917)(65623756079841)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991067);
 SRVR:VI1PR04MB5279; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5279; 
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(13464003)(7416002)(55236004)(305945005)(7736002)(256004)(446003)(74316002)(25786009)(68736007)(54906003)(8676002)(86362001)(55016002)(81166006)(81156014)(9686003)(6436002)(53936002)(76176011)(26005)(4326008)(5660300001)(186003)(7696005)(99286004)(53546011)(6506007)(6916009)(486006)(102836004)(476003)(11346002)(14444005)(44832011)(8936002)(2906002)(6116002)(3846002)(316002)(33656002)(2900100001)(71190400001)(97736004)(71200400001)(6246003)(14454004)(478600001)(5250100002)(66066001)(105586002)(106356001)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5279;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ShH4R0lUmq7bxZcoWS6kfyJ5Oon5qOtCeghWqWrx86xpqnvouRWlTgRBXjNZ5YN/2pXV4mDv84lt1o9aPZxxUMM1CkX6PDPGOxURmk3DxvZdYHXvFgcUaBydba1hjx+sIyh0yyUrfx2WawRC9w7pZMlwy4GTEKHwsermlihDgbSMQb+Ca7RSDTC4R85gJ1mOkKRqeBSn1V973WPhdoykrwUgTK4EzBqQAtAcu8h/7eXzPxReAsqRTHo/wvyUSCwTR1No4N7KBvWsFLF1vgZqNHWRvLqbYl95Cu/5f9CDkDh5O9mtDdl38ulcA6Rd7tlVL2I7TS7JvKDZzqiBPgvxFz3+fFjsCAxGyzeiPembTy8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccb7d9b-4155-4646-c78d-08d632480ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 02:44:00.4037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5279
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
 Sriram Dash <sriram.dash@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Pankaj Bansal <pankaj.bansal@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "oss@buserror.net" <oss@buserror.net>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Varun Sethi <V.Sethi@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Shawn Guo
> Sent: Monday, October 8, 2018 11:22 AM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: sudeep.holla@arm.com; oss@buserror.net; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org; mark.rutland@arm.com;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; sboyd@kernel.org; rjw@rjwysocki.net;
> viresh.kumar@linaro.org; linux-clk@vger.kernel.org; linux-pm@vger.kernel.=
org;
> linux-kernel-owner@vger.kernel.org; catalin.marinas@arm.com;
> will.deacon@arm.com; gregkh@linuxfoundation.org; arnd@arndb.de;
> kstewart@linuxfoundation.org; yamada.masahiro@socionext.com; Leo Li
> <leoyang.li@nxp.com>; linux@armlinux.org.uk; Varun Sethi <V.Sethi@nxp.com=
>;
> Udit Kumar <udit.kumar@nxp.com>; Pankaj Bansal <pankaj.bansal@nxp.com>;
> Priyanka Jain <priyanka.jain@nxp.com>; Sriram Dash <sriram.dash@nxp.com>
> Subject: Re: [PATCH v4 6/6] arm64: dts: add LX2160ARDB board support
>=20
> On Thu, Oct 04, 2018 at 06:33:51AM +0530, Vabhav Sharma wrote:
> > LX2160A reference design board (RDB) is a high-performance computing,
> > evaluation, and development platform with LX2160A SoC.
> >
> > Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile            |   1 +
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 100
> > ++++++++++++++++++++++
> >  2 files changed, 101 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > b/arch/arm64/boot/dts/freescale/Makefile
> > index 86e18ad..445b72b 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-
> rdb.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2080a-simu.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-qds.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-rdb.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > new file mode 100644
> > index 0000000..1483071
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT) // // Device Tree file
> > +for LX2160ARDB // // Copyright 2018 NXP
> > +
> > +/dts-v1/;
> > +
> > +#include "fsl-lx2160a.dtsi"
> > +
> > +/ {
> > +	model =3D "NXP Layerscape LX2160ARDB";
> > +	compatible =3D "fsl,lx2160a-rdb", "fsl,lx2160a";
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	sb_3v3: regulator-fixed {
>=20
> The node name should probably be named like regulator-sb3v3 or something,=
 so
> that the pattern can be followed when we have another fixed regulator to =
be
> added.
Ok, Agree this is fixed 3.3 standby voltage for i2c subchannels
Updating to regulator-sb3v3=20
>=20
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "fixed-3.3V";
>=20
> The name should be something we can find on board schematics.
Sure, I will update SMPS name which provide fixed 3.3 stand-by voltage
>=20
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > +
> > +};
> > +
> > +&uart0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&uart1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&i2c0 {
>=20
> Please keep these labeled nodes sorted alphabetically.
Ok
>=20
> > +	status =3D "okay";
>=20
> Have a newline between properties and child node.
Sure.
>=20
> > +	i2c-mux@77 {
> > +		compatible =3D "nxp,pca9547";
> > +		reg =3D <0x77>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		i2c@2 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			reg =3D <0x2>;
> > +
> > +			power-monitor@40 {
> > +				compatible =3D "ti,ina220";
> > +				reg =3D <0x40>;
> > +				shunt-resistor =3D <1000>;
> > +			};
> > +		};
> > +
> > +		i2c@3 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			reg =3D <0x3>;
> > +
> > +			temperature-sensor@4c {
> > +				compatible =3D "nxp,sa56004";
> > +				reg =3D <0x4c>;
> > +				vcc-supply =3D <&sb_3v3>;
> > +			};
> > +
> > +			temperature-sensor@4d {
> > +				compatible =3D "nxp,sa56004";
> > +				reg =3D <0x4d>;
> > +				vcc-supply =3D <&sb_3v3>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&i2c4 {
> > +	status =3D "okay";
> > +
> > +	rtc@51 {
> > +		compatible =3D "nxp,pcf2129";
> > +		reg =3D <0x51>;
> > +		// IRQ10_B
> > +		interrupts =3D <0 150 0x4>;
> > +		};
>=20
> Bad indentation.
My mistake, Updated
>=20
> Shawn
>=20
> > +
> > +};
> > +
> > +&usb0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&usb1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&crypto {
> > +	status =3D "okay";
> > +};
> > --
> > 2.7.4
> >
