Return-Path: <SRS0=XoDJ=6A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9904BC2BA19
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 02:38:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A139206F9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 02:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A139206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492k0j3P8dzDrGs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 12:37:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=libc.org
 (client-ip=216.12.86.13; helo=brightrain.aerifal.cx;
 envelope-from=dalias@libc.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=libc.org
Received: from brightrain.aerifal.cx (216-12-86-13.cv.mvl.ntelos.net
 [216.12.86.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492jyJ6gXBzDrDF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2020 12:35:50 +1000 (AEST)
Date: Wed, 15 Apr 2020 22:35:42 -0400
From: Rich Felker <dalias@libc.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [musl] Powerpc Linux 'scv' system call ABI proposal take 2
Message-ID: <20200416023542.GP11469@brightrain.aerifal.cx>
References: <1586931450.ub4c8cq8dj.astroid@bobo.none>
 <20200415225539.GL11469@brightrain.aerifal.cx>
 <1586994952.nnxigedbu2.astroid@bobo.none>
 <20200416004843.GO11469@brightrain.aerifal.cx>
 <1587002854.f0slo0111r.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587002854.f0slo0111r.astroid@bobo.none>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: libc-dev@lists.llvm.org, libc-alpha@sourceware.org,
 linuxppc-dev@lists.ozlabs.org, musl@lists.openwall.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 16, 2020 at 12:24:16PM +1000, Nicholas Piggin wrote:
> >> > Likewise, it's not useful to have different error return mechanisms
> >> > because the caller just has to branch to support both (or the
> >> > kernel-provided stub just has to emulate one for it; that could work
> >> > if you really want to change the bad existing convention).
> >> > 
> >> > Thoughts?
> >> 
> >> The existing convention has to change somewhat because of the clobbers,
> >> so I thought we could change the error return at the same time. I'm
> >> open to not changing it and using CR0[SO], but others liked the idea.
> >> Pro: it matches sc and vsyscall. Con: it's different from other common
> >> archs. Performnce-wise it would really be a wash -- cost of conditional
> >> branch is not the cmp but the mispredict.
> > 
> > If you do the branch on hwcap at each syscall, then you significantly
> > increase code size of every syscall point, likely turning a bunch of
> > trivial functions that didn't need stack frames into ones that do. You
> > also potentially make them need a TOC pointer. Making them all just do
> > an indirect call unconditionally (with pointer in TLS like i386?) is a
> > lot more efficient in code size and at least as good for performance.
> 
> I disagree. Doing the long vdso indirect call *necessarily* requires
> touching a new icache line, and even a new TLB entry. Indirect branches

The increase in number of icache lines from the branch at every
syscall point is far greater than the use of a single extra icache
line shared by all syscalls. Not to mention the dcache line to access
__hwcap or whatever, and the icache lines to setup access TOC-relative
access to it. (Of course you could put a copy of its value in TLS at a
fixed offset, which would somewhat mitigate both.)

> And finally, the HWCAP test can eventually go away in future. A vdso
> call can not.

We support nearly arbitrarily old kernels (with limited functionality)
and hardware (with full functionality) and don't intend for that to
change, ever. But indeed glibc might want too eventually drop the
check.

> If you really want to select with an indirect branch rather than
> direct conditional, you can do that all within the library.

OK. It's a little bit more work if that's not the interface the kernel
will give us, but it's no big deal.

Rich
