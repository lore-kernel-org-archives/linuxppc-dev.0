Return-Path: <ananth@in.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4453B1A094B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 20:39:34 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Mon, 20 Jul 2015 04:39:32 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0F55F3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 04:39:30 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6KAdTEK53739574
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 03:39:29 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6KAdTrC025066
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 04:39:29 -0600
Date: Mon, 20 Jul 2015 16:08:59 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kprobes: Mark OPTPROBES n/a for powerpc
Message-ID: <20150720103859.GH2196@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20150716105639.9151.75671.stgit@thinktux.in.ibm.com>
 <55AB09BE.5040506@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55AB09BE.5040506@hitachi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 19, 2015 at 11:21:50AM +0900, Masami Hiramatsu wrote:
> On 2015/07/16 19:56, Ananth N Mavinakayanahalli wrote:
> > Kprobes uses a breakpoint instruction to trap into execution flow
> > and the probed instruction is single-stepped from an alternate location.
> > 
> > On some architectures like x86, under certain conditions, the OPTPROBES
> > feature enables replacing the probed instruction with a jump instead,
> > resulting in a significant perfomance boost (one single-step exception
> > is bypassed for each kprobe).
> 
> The OPTPROBE is not only for bypassing the single-step exception, but also
> the breakpoint exception.
> Please see commit 0dc016dbd820260b (ARM: kprobes: enable OPTPROBES for ARM 32) too,
> which shows how it is done on RISC processor.

Yes, will fix and send.

> > Powerpc has an in-kernel instruction emulator. Kprobes on powerpc uses
> > this emulator already and bypasses the single-step exception, with a
> > lot less complexity.
> 
> So, this might miss the point. Since it is impossible to do on some RISC
> processor, I agree with this change, but it should be committed with
> correct comments.

Sure, thanks!

Ananth
