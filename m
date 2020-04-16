Return-Path: <SRS0=XoDJ=6A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F35C2BB55
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 16:22:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9787020857
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 16:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9787020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4934JX5LNNzDrD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 02:22:52 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4933Jl3GvgzDrQV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2020 01:37:58 +1000 (AEST)
Date: Thu, 16 Apr 2020 11:37:56 -0400
From: Rich Felker <dalias@libc.org>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: Re: [musl] Powerpc Linux 'scv' system call ABI proposal take 2
Message-ID: <20200416153756.GU11469@brightrain.aerifal.cx>
References: <1586931450.ub4c8cq8dj.astroid@bobo.none>
 <20200415225539.GL11469@brightrain.aerifal.cx>
 <c2612908-67f7-cceb-d121-700dea096016@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2612908-67f7-cceb-d121-700dea096016@linaro.org>
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
Cc: musl@lists.openwall.com, libc-alpha@sourceware.org,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 libc-dev@lists.llvm.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 16, 2020 at 11:16:04AM -0300, Adhemerval Zanella wrote:
> > My preference would be that it work just like the i386 AT_SYSINFO
> > where you just replace "int $128" with "call *%%gs:16" and the kernel
> > provides a stub in the vdso that performs either scv or the old
> > mechanism with the same calling convention. Then if the kernel doesn't
> > provide it (because the kernel is too old) libc would have to provide
> > its own stub that uses the legacy method and matches the calling
> > convention of the one the kernel is expected to provide.
> 
> What about pthread cancellation and the requirement of checking the
> cancellable syscall anchors in asynchronous cancellation? My plan is
> still to use musl strategy on glibc (BZ#12683) and for i686 it 
> requires to always use old int$128 for program that uses cancellation
> (static case) or just threads (dynamic mode, which should be more
> common on glibc).
> 
> Using the i686 strategy of a vDSO bridge symbol would require to always
> fallback to 'sc' to still use the same cancellation strategy (and
> thus defeating this optimization in such cases).

Yes, I assumed it would be the same, ignoring the new syscall
mechanism for cancellable syscalls. While there are some exceptions,
cancellable syscalls are generally not hot paths but things that are
expected to block and to have significant amounts of work to do in
kernelspace, so saving a few tens of cycles is rather pointless.

It's possible to do a branch/multiple versions of the syscall asm for
cancellation but would require extending the cancellation handler to
support checking against multiple independent address ranges or using
some alternate markup of them.

Rich
