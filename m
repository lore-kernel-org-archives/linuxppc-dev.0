Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60710C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 00:03:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A4E21850
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 00:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zDfH4MMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A4E21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448t6s2Y0yzDqNH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 11:03:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="signature verification failed" (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="zDfH4MMV"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448t4r4KrHzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 11:01:32 +1100 (AEDT)
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A64321850;
 Thu, 28 Feb 2019 00:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551312089;
 bh=q1T5iaEa2b4R1Gj+EQUVl8fwuZfLBtUF45gOHNybkwc=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=zDfH4MMVgN14ka7lGXfzzT6yY2UOpwoM08CbnIi2qMsfzFPy/UNF1wP2A5b/g9iRr
 PwUhxPaX9PMXbmoWzrOiLO2YgO8u71Zefm+U8ke7OoXBMqttzWVLRLqMM5NeX+IBF5
 UTrQgTHzCmkHGL4IJB+ltUYcHyGkireIt0QMTuqg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: "arnd@arndb.de" <arnd@arndb.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "oss@buserror.net" <oss@buserror.net>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "viresh.kumar@lina
 ro.org" <viresh.kumar@linaro.org>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
 Leo Li <leoyang.li@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <155131208867.260864.6630901066653352400@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v1 0/4] arm64: dts: NXP: add basic dts file for LX2160A SoC
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Date: Wed, 27 Feb 2019 16:01:28 -0800
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
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 Vabhav Sharma <vabhav.sharma@nxp.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Quoting Vabhav Sharma (2019-02-26 02:10:46)
> These patches were reviewed and acked but dropped during merge window.
> Patchwork link was https://lore.kernel.org/patchwork/cover/1004155/
>=20
> Changes for v1:
> - Updated lx2160a clockgen in alphabetical order
>=20
> Vabhav Sharma (2):
>   dt-bindings: arm64: add compatible for LX2160A
>   soc/fsl/guts: Add definition for LX2160A
>=20
> Yogesh Gaur (2):
>   clk: qoriq: increase array size of cmux_to_group
>   clk: qoriq: Add clockgen support for lx2160a

Who do you want to apply these patches?

