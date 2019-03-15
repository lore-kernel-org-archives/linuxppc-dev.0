Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C4DC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 18:16:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBFA218AC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 18:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBFA218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LYfq5BV4zDqRH
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 05:16:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LYYr6HMkzDqQZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 05:11:43 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Mar 2019 11:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,483,1544515200"; d="scan'208";a="131977047"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
 by fmsmga008.fm.intel.com with ESMTP; 15 Mar 2019 11:11:34 -0700
Received: from andy by smile with local (Exim 4.92)
 (envelope-from <andy.shevchenko@gmail.com>)
 id 1h4rIc-0003Ck-FI; Fri, 15 Mar 2019 20:11:18 +0200
Date: Fri, 15 Mar 2019 20:11:18 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: serial driver cleanups v2
Message-ID: <20190315181118.GF9224@smile.fi.intel.com>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
 <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
Cc: linux-arm-msm@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>, macro@linux-mips.org,
 Peter Korsgaard <jacmet@sunsite.dk>, Fabio Estevam <festevam@gmail.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Gross <andy.gross@linaro.org>, Tobias Klauser <tklauser@distanz.ch>,
 David Brown <david.brown@linaro.org>, Ray Jui <rjui@broadcom.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, slemieux.tyco@gmail.com,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, baohua@kernel.org,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Richard Genoud <richard.genoud@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 15, 2019 at 11:36:04AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 15.03.19 10:12, Andy Shevchenko wrote:
> 
> >> Part II will be about moving the mmio range from mapbase and
> >> mapsize (which are used quite inconsistently) to a struct resource
> >> and using helpers for that. But this one isn't finished yet.
> >> (if somebody likes to have a look at it, I can send it, too)
> > 
> > Let's do that way you are preparing a branch somewhere and anounce
> > here as an RFC, since this was neither tested nor correct.
> 
> Okay, here it is:
> 
> I. https://github.com/metux/linux/tree/submit/serial-clean-v3
>    --> general cleanups, as basis for II
> 
> II. https://github.com/metux/linux/tree/wip/serial-res
>    --> moving towards using struct resource consistently
> 
> III. https://github.com/metux/linux/tree/hack/serial
>     --> the final steps, which are yet completely broken
>     (more a notepad for things still to do :o)
> 
> The actual goal is generalizing the whole iomem handling, so individual
> usually just need to call some helpers that do most of the things.
> Finally, I also wanted to have all io region information consolidated
> in struct resource.

That's should be a selling point, not just conversion per se.

> > And selling point for many of them is not true: it doesn't make any
> > difference in the size in code, but increases a time to run
> > (devm_ioremap_resource() does more than plain devm_iomap() call).
> 
> Okay, just seen it. Does the the runtime overhead cause any problems ?

You have to explain that in each commit message, that the change does bring a
possible new error message printed.

The performance side of the deal, you are lucky here, is not significant
because it's slow path.

-- 
With Best Regards,
Andy Shevchenko


