Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CFDC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 09:49:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C12F213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 09:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C12F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447vCh5GwNzDqGt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 20:49:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447vB00QTCzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 20:47:35 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gyZIX-0005qT-C1; Tue, 26 Feb 2019 03:45:13 -0600
Message-ID: <07441256501ad8bd45b187cf6e25338b028bc9ac.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Vabhav Sharma <vabhav.sharma@nxp.com>, "sudeep.holla@arm.com"
 <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
 "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, 
 "rjw@rjwysocki.net"
 <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
 "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, 
 "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, 
 "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "yamada.masahiro@socionext.com"
 <yamada.masahiro@socionext.com>, Leo Li <leoyang.li@nxp.com>, 
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Date: Tue, 26 Feb 2019 03:45:11 -0600
In-Reply-To: <1551126463-5341-5-git-send-email-vabhav.sharma@nxp.com>
References: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
 <1551126463-5341-5-git-send-email-vabhav.sharma@nxp.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: vabhav.sharma@nxp.com, sudeep.holla@arm.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
 mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
 sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
 will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 kstewart@linuxfoundation.org, yamada.masahiro@socionext.com,
 leoyang.li@nxp.com, shawnguo@kernel.org, linux@armlinux.org.uk,
 adrian.hunter@intel.com, ulf.hansson@linaro.org, yogeshnarayan.gaur@nxp.com,
 andy.tang@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 4/4] clk: qoriq: Add clockgen support for lx2160a
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Andy Tang <andy.tang@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-02-26 at 08:34 +0000, Vabhav Sharma wrote:
> @@ -1435,6 +1446,7 @@ CLK_OF_DECLARE(qoriq_clockgen_t1023, "fsl,t1023-
> clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_t1040, "fsl,t1040-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_t2080, "fsl,t2080-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_t4240, "fsl,t4240-clockgen", clockgen_init);
> +CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen",
> clockgen_init);

The chips were previously in alphabetical order...

-Scott


