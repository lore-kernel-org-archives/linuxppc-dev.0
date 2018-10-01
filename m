Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7709C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 08:53:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56AEE20652
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 08:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AEE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Nx093F0kzF37q
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 18:53:45 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NwyB5wrczF35T
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 18:52:02 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w918pRFo018236;
 Mon, 1 Oct 2018 03:51:28 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id w918pLNl018199;
 Mon, 1 Oct 2018 03:51:22 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 1 Oct 2018 03:51:21 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64: Increase stack redzone for 64-bit kernel
 to 512 bytes
Message-ID: <20181001085121.GB23155@gate.crashing.org>
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
 <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
 <20181001092715.0a2696bd@roar.ozlabs.ibm.com>
 <CAEUhbmUih9irf-A8E4rouvpWKjeqg78Vzg+xm5TzUVB_vLPr=g@mail.gmail.com>
 <20181001122256.7cfdf186@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001122256.7cfdf186@roar.ozlabs.ibm.com>
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

Hi!

On Mon, Oct 01, 2018 at 12:22:56PM +1000, Nicholas Piggin wrote:
> On Mon, 1 Oct 2018 09:11:04 +0800
> Bin Meng <bmeng.cn@gmail.com> wrote:
> > On Mon, Oct 1, 2018 at 7:27 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > On Sat, 29 Sep 2018 23:25:20 -0700
> > > Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > commit 573ebfa6601f ("powerpc: Increase stack redzone for 64-bit
> > > > userspace to 512 bytes") only changes stack userspace redzone size.
> > > > We need increase the kernel one to 512 bytes too per ABIv2 spec.  
> > >
> > > You're right we need 512 to be compatible with ABIv2, but as the
> > > comment says, gcc limits this to 288 bytes so that's what is used
> > > to save stack space. We can use a compiler version test to change
> > > this if llvm or a new version of gcc does something different.
> > >  
> > 
> > I believe what the comment says is for ABIv1. At the time when commit
> > 573ebfa6601f was submitted, kernel had not switched to ABIv2 build
> > yet.
> 
> I see, yes you are right about that. However gcc still seems to be using
> 288 bytes.

And that is required by the ABI!

"""
2.2.2.4. Protected Zone

The 288 bytes below the stack pointer are available as volatile program
storage that is not preserved across function calls. Interrupt handlers and
any other functions that might run without an explicit call must take care
to preserve a protected zone, also referred to as the red zone, of 512 bytes
that consists of:

 * The 288-byte volatile program storage region that is used to hold saved
   registers and local variables
 * An additional 224 bytes below the volatile program storage region that is
   set aside as a volatile system storage region for system functions

If a function does not call other functions and does not need more stack
space than is available in the volatile program storage region (that is, 288
bytes), it does not need to have a stack frame. The 224-byte volatile system
storage region is not available to compilers for allocation to saved
registers and local variables.
"""

A routine has a red zone of 288 bytes.  Below there is 224 more bytes of
available storage, but that is not available to the routine itself: some
(asynchronous) other code (like an interrupt) can use (i.e. clobber) it.


Segher
