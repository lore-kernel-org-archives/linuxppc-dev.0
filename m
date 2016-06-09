Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQMX12SFfzDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 20:50:09 +1000 (AEST)
Message-ID: <1465469403.31662.7.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] selftests/powerpc: Test unaligned copy and paste
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, Chris Smart <chris@distroguy.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 09 Jun 2016 20:50:03 +1000
In-Reply-To: <1465457196.14163.3.camel@neuling.org>
References: <db3d861c85eb7c49362eec1a973ad023cfff82df.1465451957.git.chris@distroguy.com>
 <20160609060223.GA26308@distroguy.com>
 <1465457196.14163.3.camel@neuling.org>
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

On Thu, 2016-06-09 at 17:26 +1000, Michael Neuling wrote:
> On Thu, 2016-06-09 at 16:02 +1000, Chris Smart wrote:
> > Test that an ISA 3.0 compliant machine performing an unaligned copy,
> > copy_first, paste or paste_last is sent a SIGBUS.
> 
> It's probably overkill but we could check in the signal handler that the
> sigbus was on the instruction we actually cared about.  ie something like
> this in the sig handler for copy first.
> 
> static void sig_handler(int signr, siginfo_t *info, void *ucontext)
> {
>         ucontext_t *ctx = ucontext;
>         unsigned int *pc = ctx->uc_mcontext.gp_regs[PT_NIP];
 
You're a hard taskmaster.

For it to build on 32-bit BE, you'll need:

    #if defined(__powerpc64__)
    pc = ctx->uc_mcontext.gp_regs[PT_NIP];
    #else
    pc = ctx->uc_mcontext.uc_regs->gregs[PT_NIP]
    #endif

cheers
