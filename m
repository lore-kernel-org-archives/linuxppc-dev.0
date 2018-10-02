Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39774C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 08:32:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD782064E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 08:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD782064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PXTb3l0yzF3F3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 18:32:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PXRN5jD9zF31j
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 18:30:56 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w928UNuZ016781;
 Tue, 2 Oct 2018 03:30:23 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id w928UJK0016746;
 Tue, 2 Oct 2018 03:30:19 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 2 Oct 2018 03:30:19 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64: Increase stack redzone for 64-bit kernel
 to 512 bytes
Message-ID: <20181002083018.GH23155@gate.crashing.org>
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
 <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
 <20181001092715.0a2696bd@roar.ozlabs.ibm.com>
 <CAEUhbmUih9irf-A8E4rouvpWKjeqg78Vzg+xm5TzUVB_vLPr=g@mail.gmail.com>
 <20181001122256.7cfdf186@roar.ozlabs.ibm.com>
 <20181001085121.GB23155@gate.crashing.org>
 <20181002095929.25253b99@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002095929.25253b99@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.3i
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 02, 2018 at 09:59:29AM +1000, Nicholas Piggin wrote:
> On Mon, 1 Oct 2018 03:51:21 -0500
> Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > And that is required by the ABI!
> > 
> > """
> > 2.2.2.4. Protected Zone
> > 
> > The 288 bytes below the stack pointer are available as volatile program
> > storage that is not preserved across function calls. Interrupt handlers and
> > any other functions that might run without an explicit call must take care
> > to preserve a protected zone, also referred to as the red zone, of 512 bytes
> > that consists of:
> > 
> >  * The 288-byte volatile program storage region that is used to hold saved
> >    registers and local variables
> >  * An additional 224 bytes below the volatile program storage region that is
> >    set aside as a volatile system storage region for system functions
> > 
> > If a function does not call other functions and does not need more stack
> > space than is available in the volatile program storage region (that is, 288
> > bytes), it does not need to have a stack frame. The 224-byte volatile system
> > storage region is not available to compilers for allocation to saved
> > registers and local variables.
> > """
> > 
> > A routine has a red zone of 288 bytes.  Below there is 224 more bytes of
> > available storage, but that is not available to the routine itself: some
> > (asynchronous) other code (like an interrupt) can use (i.e. clobber) it.
> 
> Thanks Segher, that explains it very well and shows we are safe with
> 288 in the kernel. So we can leave the code as-is, but the comment
> could be updated.
> 
> What are "system functions" exactly?

That is an excellent question.  I think it was left vague on purpose?
"Stuff a user program cannot do itself", "ABI stuff", "whatever the OS
defines as system stuff"?

> Can the kernel use that, or are
> we talking about user mode system code like libraries? The kernel
> could maybe use that for scratch space for synchronous interrupts to
> avoid using a slow SPR for scratch.

If you're already using the kernel stack, sure.  When does this happen?


Segher
