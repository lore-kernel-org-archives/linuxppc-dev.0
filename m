Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF3DC67863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 10:07:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A2020658
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 10:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A2020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dsdz4xXczDrWW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 21:07:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ds0g2cZ8zDrVx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 20:38:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42ds0g02cPz9sDF; Mon, 22 Oct 2018 20:38:58 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 67361cf80712867329a9cd3ff0e3171545cfc867
In-Reply-To: <20181016202500.28039-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/ftrace: Handle large kernel configs
Message-Id: <42ds0g02cPz9sDF@ozlabs.org>
Date: Mon, 22 Oct 2018 20:38:58 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-10-16 at 20:25:00 UTC, "Naveen N. Rao" wrote:
> Currently, we expect to be able to reach ftrace_caller() from all
> ftrace-enabled functions through a single relative branch. With large
> kernel configs, we see functions outside of 32MB of ftrace_caller()
> causing ftrace_init() to bail.
> 
> In such configurations, gcc/ld emits two types of trampolines for mcount():
> 1. A long_branch, which has a single branch to mcount() for functions that
>    are one hop away from mcount():
> 	c0000000019e8544 <00031b56.long_branch._mcount>:
> 	c0000000019e8544:	4a 69 3f ac 	b       c00000000007c4f0 <._mcount>
> 
> 2. A plt_branch, for functions that are farther away from mcount():
> 	c0000000051f33f8 <0008ba04.plt_branch._mcount>:
> 	c0000000051f33f8:	3d 82 ff a4 	addis   r12,r2,-92
> 	c0000000051f33fc:	e9 8c 04 20 	ld      r12,1056(r12)
> 	c0000000051f3400:	7d 89 03 a6 	mtctr   r12
> 	c0000000051f3404:	4e 80 04 20 	bctr
> 
> We can reuse those trampolines for ftrace if we can have those
> trampolines go to ftrace_caller() instead. However, with ABIv2, we
> cannot depend on r2 being valid. As such, we use only the long_branch
> trampolines by patching those to instead branch to ftrace_caller or
> ftrace_regs_caller.
> 
> In addition, we add additional trampolines around .text and .init.text
> to catch locations that are covered by the plt branches. This allows
> ftrace to work with most large kernel configurations.
> 
> For now, we always patch the trampolines to go to ftrace_regs_caller,
> which is slightly inefficient. This can be optimized further at a later
> point.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/67361cf80712867329a9cd3ff0e317

cheers
