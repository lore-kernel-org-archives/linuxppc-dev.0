Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE8C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 10:51:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6192B2087E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 10:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D+blUeSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6192B2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ypvw61qfzDqRx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:51:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="D+blUeSM"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Ypsp5s4szDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 21:49:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yTdZfVFtLBOKoGnllbQfxLoeT4ufqAHc7DRrU9MkNQI=; b=D+blUeSMEt5iyYRsyD647qCqA
 E4knXkY9NIqGXrAOJJ7U3Tp/S5G9sfNIelyVDRKA/lLBXsdM7L55vm0goMwBNElderAuuaR0OzxbW
 KOzeaQdPrg33fAHIAPCIVxMrFGSlJ6Sw4+QkDcEE7cloG/9bGoVNBrEKojKIcSWMojQ9L9AMqHjTD
 YUNuWzi5MlVZOVVgx7sflt+EFJ86eV2Zs4ziMehCGSWfRuHba+Vlz2szTpEgFD4b9t6kTeQOGPEd9
 bC0dGYsRf1RclLpky5AqDZb6wUQIq4vcY/7D22MrRxB2Hk81kVOcYG2DvsVuobPkRCAy1j8zjr/c9
 xUjXrMFAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggow6-0003sw-TW; Tue, 08 Jan 2019 10:48:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 1FAE0201BC2AE; Tue,  8 Jan 2019 11:48:41 +0100 (CET)
Date: Tue, 8 Jan 2019 11:48:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v4 10/13] x86: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for
 exclude incapable PMUs
Message-ID: <20190108104841.GD6808@hirez.programming.kicks-ass.net>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
 <1546878450-20341-11-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546878450-20341-11-git-send-email-andrew.murray@arm.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, Shawn Guo <shawnguo@kernel.org>,
 boris.ostrovsky@oracle.com, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Matt Turner <mattst88@gmail.com>, suzuki.poulose@arm.com,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, jgross@suse.com, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 07, 2019 at 04:27:27PM +0000, Andrew Murray wrote:
> For drivers that do not support context exclusion let's advertise the
> PERF_PMU_CAP_NOEXCLUDE capability. This ensures that perf will
> prevent us from handling events where any exclusion flags are set.
> Let's also remove the now unnecessary check for exclusion flags.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/x86/events/amd/ibs.c          | 13 +------------
>  arch/x86/events/amd/power.c        | 10 ++--------
>  arch/x86/events/intel/cstate.c     | 12 +++---------
>  arch/x86/events/intel/rapl.c       |  9 ++-------
>  arch/x86/events/intel/uncore_snb.c |  9 ++-------
>  arch/x86/events/msr.c              | 10 ++--------
>  6 files changed, 12 insertions(+), 51 deletions(-)

You (correctly) don't add CAP_NO_EXCLUDE to the main x86 pmu code, but
then you also don't check if it handles all the various exclude options
correctly/consistently.

Now; I must admit that that is a bit of a maze, but I think we can at
least add exclude_idle and exclude_hv fails in there, nothing uses those
afaict.

On the various exclude options; they are as follows (IIUC):

  - exclude_guest: we're a HV/host-kernel and we don't want the counter
                   to run when we run a guest context.

  - exclude_host: we're a HV/host-kernel and we don't want the counter
                  to run when we run in host context.

  - exclude_hv: we're a guest and don't want the counter to run in HV
                context.

Now, KVM always implies exclude_hv afaict (for guests), I'm not sure
what, if anything Xen does on x86 (IIRC Brendan Gregg once said perf
works on Xen) -- nor quite sure who to ask, Boris, Jeurgen?

