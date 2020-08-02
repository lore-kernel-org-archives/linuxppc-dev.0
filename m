Return-Path: <SRS0=CfD8=BM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ED6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 17:34:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A58620738
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Aug 2020 17:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A58620738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKSnM20FvzDqSW
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 03:34:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=1wt.eu
 (client-ip=62.212.114.60; helo=1wt.eu; envelope-from=w@1wt.eu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=1wt.eu
X-Greylist: delayed 719 seconds by postgrey-1.36 at bilbo;
 Mon, 03 Aug 2020 03:32:30 AEST
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BKSl21xbJzDqNt
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2020 03:32:29 +1000 (AEST)
Received: (from willy@localhost)
 by pcw.home.local (8.15.2/8.15.2/Submit) id 072HKJqe027023;
 Sun, 2 Aug 2020 19:20:19 +0200
Date: Sun, 2 Aug 2020 19:20:19 +0200
From: Willy Tarreau <w@1wt.eu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: powerpc: build failures in Linus' tree
Message-ID: <20200802172019.GB26677@1wt.eu>
References: <20200802204842.36bca162@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802204842.36bca162@canb.auug.org.au>
User-Agent: Mutt/1.6.1 (2016-04-27)
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Aug 02, 2020 at 08:48:42PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> We are getting build failures in some PowerPC configs for Linus' tree.
> See e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/14306515/
> 
> In file included from /kisskb/src/arch/powerpc/include/asm/paca.h:18,
>                  from /kisskb/src/arch/powerpc/include/asm/percpu.h:13,
>                  from /kisskb/src/include/linux/random.h:14,
>                  from /kisskb/src/include/linux/net.h:18,
>                  from /kisskb/src/net/ipv6/ip6_fib.c:20:
> /kisskb/src/arch/powerpc/include/asm/mmu.h:139:22: error: unknown type name 'next_tlbcam_idx'
>   139 | DECLARE_PER_CPU(int, next_tlbcam_idx);
> 
> I assume this is caused by commit
> 
>   1c9df907da83 ("random: fix circular include dependency on arm64 after addition of percpu.h")
> 
> But I can't see how, sorry.

So there, asm/mmu.h includes asm/percpu.h, which includes asm/paca.h, which
includes asm/mmu.h.

I suspect that we can remove asm/paca.h from asm/percpu.h as it *seems*
to be only used by the #define __my_cpu_offset but I don't know if anything
will break further, especially if this __my_cpu_offset is used anywhere
without this paca definition.

Willy
