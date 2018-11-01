Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A16C6786F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 17:30:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7DA205F4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 17:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gWLRh4r6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7DA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mBzq2RS0zF3NM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 04:30:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="gWLRh4r6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="gWLRh4r6"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mBxF1xVQzF3H4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 04:28:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cqmmiMgCoNcYZQd3PjTzf7yi7hw7o8SwAHEWFTCrXl8=; b=gWLRh4r6aXQzNSHXyEu6rBCZ0
 CXntVUXtJM7/5EOPwODwlXeSL7EmyL0qVWbo1al8RQrIRBjiboIjqi1FRwPHUki+FEub2DgMCN16q
 qQJaNWTsghoRMRDX0mBRay5LsKTKLlz6KH0pNTYOt3kVNhGjD4gcDjSzhQlnVMO7RqvtddOHMAcgX
 F5wImHGmImAKF8mI96vG+8qR0gVOdYlCWxwzkuxlkePVLDG9x+donUW01Scn0HYp5Vwwobmi3G5YW
 40rP5Rj7NmuIJaVbrW1E0pLR+BS3THdg2CScMj7zCN/sGDRUUBuZ9BCNVRVhHd43UyIqAwZg30xnZ
 NFI5GOftA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gIGkx-0005xd-BU; Thu, 01 Nov 2018 17:27:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 6E0512029F9FF; Thu,  1 Nov 2018 18:27:39 +0100 (CET)
Date: Thu, 1 Nov 2018 18:27:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181101172739.GA3196@hirez.programming.kicks-ass.net>
References: <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
 <b0160f4b-b996-b0ee-405a-3d5f1866272e@gmail.com>
 <20181101171432.GH3178@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101171432.GH3178@hirez.programming.kicks-ass.net>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bfields@fieldses.org" <bfields@fieldses.org>,
 "paulus@samba.org" <paulus@samba.org>,
 Trond Myklebust <trondmy@hammerspace.com>,
 "jhogan@kernel.org" <jhogan@kernel.org>, aryabinin@virtuozzo.com,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>, "arnd@arndb.de" <arnd@arndb.de>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>, dvyukov@google.com,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
 "paul.burton@mips.com" <paul.burton@mips.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 01, 2018 at 06:14:32PM +0100, Peter Zijlstra wrote:
> > This reminds me of this sooooo silly patch :/
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adb03115f4590baa280ddc440a8eff08a6be0cb7

You'd probably want to write it like so; +- some ordering stuff, that
code didn't look like it really needs the memory barriers implied by
these, but I didn't look too hard.

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index c0a9d26c06ce..11deb1d7e96b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -485,16 +485,10 @@ u32 ip_idents_reserve(u32 hash, int segs)
 	u32 now = (u32)jiffies;
 	u32 new, delta = 0;
 
-	if (old != now && cmpxchg(p_tstamp, old, now) == old)
+	if (old != now && try_cmpxchg(p_tstamp, &old, now))
 		delta = prandom_u32_max(now - old);
 
-	/* Do not use atomic_add_return() as it makes UBSAN unhappy */
-	do {
-		old = (u32)atomic_read(p_id);
-		new = old + delta + segs;
-	} while (atomic_cmpxchg(p_id, old, new) != old);
-
-	return new - segs;
+	return atomic_fetch_add(segs + delta, p_id) + delta;
 }
 EXPORT_SYMBOL(ip_idents_reserve);
 
