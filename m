Return-Path: <SRS0=xy+f=GZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D10AC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Jan 2021 18:33:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFD223AAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Jan 2021 18:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFD223AAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMnvH3mf0zDsQ3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Jan 2021 05:33:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=libc.org
 (client-ip=216.12.86.13; helo=brightrain.aerifal.cx;
 envelope-from=dalias@libc.org; receiver=<UNKNOWN>)
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMnsK4ZfpzDrNG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jan 2021 05:31:32 +1100 (AEDT)
Date: Fri, 22 Jan 2021 13:31:27 -0500
From: Rich Felker <dalias@libc.org>
To: Florian Weimer <fweimer@redhat.com>, musl@lists.openwall.com,
 libc-alpha@sourceware.org, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, Alan Modra <amodra@gmail.com>
Subject: Re: [musl] Re: [PATCH v2] powerpc/64/signal: balance return
 predictor stack in signal trampoline
Message-ID: <20210122183127.GQ23432@brightrain.aerifal.cx>
References: <20200511101952.1463138-1-npiggin@gmail.com>
 <87im7pp5yl.fsf@oldenburg.str.redhat.com>
 <20210122144402.GP23432@brightrain.aerifal.cx>
 <20210122181922.pcxyomeg5xcf2umu@work-tp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122181922.pcxyomeg5xcf2umu@work-tp>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 22, 2021 at 03:19:22PM -0300, Raoni Fassina Firmino wrote:
> On Fri, Jan 22, 2021 at 09:44:05AM -0500, Rich Felker wrote:
> > Maybe I'm missing something but I don't see how this would break musl;
> > we just inspect the PC in the mcontext, which I don't see any changes
> > to and which should still point to the next instruction of the
> > interrupted context. I don't have a test environment though so I'll
> > have to wait for feedback from ppc users to be sure. Are there any
> > further details on how it's breaking glibc?
> 
> For glibc, backtrace() compares the return-address from each stack frame
> to the value of `__kernel_sigtramp_rt64` to identify the frame with the
> mcontext information, but now the return-address is not the start of the
> routine, but the middle of it, so it fails to catch this special frame.

Is there a reason it's backtracing rather than just looking at the
interrupted context (pointed to by the third argument to the signal
handler)?

Rich
