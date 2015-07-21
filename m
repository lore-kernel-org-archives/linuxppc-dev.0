Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A9851A0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 12:53:07 +1000 (AEST)
Message-ID: <1437447187.30722.2.camel@ellerman.id.au>
Subject: Re: [PATCH] kprobes: Mark OPTPROBES n/a for powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 21 Jul 2015 12:53:07 +1000
In-Reply-To: <55AB09BE.5040506@hitachi.com>
References: <20150716105639.9151.75671.stgit@thinktux.in.ibm.com>
 <55AB09BE.5040506@hitachi.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-07-19 at 11:21 +0900, Masami Hiramatsu wrote:
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
> 
> > Powerpc has an in-kernel instruction emulator. Kprobes on powerpc uses
> > this emulator already and bypasses the single-step exception, with a
> > lot less complexity.
> 
> So, this might miss the point. Since it is impossible to do on some RISC
> processor, I agree with this change, but it should be committed with
> correct comments.

I don't think it's impossible on powerpc.

So we should leave it as a TODO for now.

cheers
