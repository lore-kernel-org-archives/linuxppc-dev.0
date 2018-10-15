Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF72C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 16:51:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805E22064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 16:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqj8iPOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805E22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YkwP49chzF3Rx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 03:51:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cqj8iPOm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="cqj8iPOm"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Yksd28sYzF3Lp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 03:48:36 +1100 (AEDT)
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C1E62064A;
 Mon, 15 Oct 2018 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539622114;
 bh=znxwo/KkYuHQ7BZTi+VB2plhm/XsXVWQ2KyC/W+QbvM=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=cqj8iPOmE0KwFpKdbX+XPS0iIcDG2F7RmFYwZnmFdWHEv2canwwM0bYQk7OAqdWgW
 tfNy6Xzn3VcFhdN1j7pB1p9YDeuPrlkh/XVNdObILkeArwMQEQqxBce/C42ZypoCQ4
 YmW7nuNfDVUq6uBl1ynceoY1bGkrDANf+PyLHZ+E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Shawn Guo <shawnguo@kernel.org>, Vabhav Sharma <vabhav.sharma@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <VI1PR04MB4800C0AB214B258793AF9ABAF3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-6-git-send-email-vabhav.sharma@nxp.com>
 <20181008054510.GG3587@dragon>
 <VI1PR04MB4800C0AB214B258793AF9ABAF3FD0@VI1PR04MB4800.eurprd04.prod.outlook.com>
Message-ID: <153962211360.5275.18031876744546062419@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH v4 5/6] arm64: dts: add QorIQ LX2160A SoC support
Date: Mon, 15 Oct 2018 09:48:33 -0700
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
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
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
 Nipun Gupta <nipun.gupta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Ramneek Mehresh <ramneek.mehresh@nxp.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Ying Zhang <ying.zhang22455@nxp.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Quoting Vabhav Sharma (2018-10-14 19:58:15)
> > > +
> > > +   pmu {
> > > +           compatible =3D "arm,cortex-a72-pmu";
> > > +           interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > > +   };
> > > +
> > > +   psci {
> > > +           compatible =3D "arm,psci-0.2";
> > > +           method =3D "smc";
> > > +   };
> > > +
> > > +   memory@80000000 {
> > > +           // DRAM space - 1, size : 2 GB DRAM
> > > +           device_type =3D "memory";
> > > +           reg =3D <0x00000000 0x80000000 0 0x80000000>;
> > > +   };
> > > +
> > > +   ddr1: memory-controller@1080000 {
> > > +           compatible =3D "fsl,qoriq-memory-controller";
> > > +           reg =3D <0x0 0x1080000 0x0 0x1000>;
> > > +           interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > > +           little-endian;
> > > +   };
> > > +
> > > +   ddr2: memory-controller@1090000 {
> > > +           compatible =3D "fsl,qoriq-memory-controller";
> > > +           reg =3D <0x0 0x1090000 0x0 0x1000>;
> > > +           interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> > > +           little-endian;
> > > +   };
> > > +
> > > +   sysclk: sysclk {
> > =

> > Name the node a bit generic like clock-xxx.
> There is only one clock-unit, Bootloader(U-boot) require sysclk node duri=
ng device tree fix-up as different platform support varied platform frequen=
cy as per reset configuration word used.
> Referred other ARM based platform with one clock using name as x: x

Please add a comment above this node with this information. Newcomers
reading this DTS file won't have any idea why this node is specially
named and a comment will help tremendously here.

