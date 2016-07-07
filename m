Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rldYs5sLvzDqx9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 23:21:37 +1000 (AEST)
Message-ID: <1467897678.27157.45.camel@kernel.crashing.org>
Subject: Re: [v4] powerpc: Export thread_struct.used_vr/used_vsr to user space
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Simon Guo <wei.guo.simon@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Paul
 Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>, Rashmica
 Gupta <rashmicy@gmail.com>
Date: Thu, 07 Jul 2016 23:21:18 +1000
In-Reply-To: <577E5534.70300@linux.vnet.ibm.com>
References: <3rlZmP39HNz9sXR@ozlabs.org> <577E5534.70300@linux.vnet.ibm.com>
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

On Thu, 2016-07-07 at 15:12 +0200, Laurent Dufour wrote:
> 
> Basically, CRIU checkpoints the process register's state through the
> ptrace API, and it restores it through a signal frame at restart time.
> This is quite odd but that the way it works on all the CRIU's supported
> architectures.
> 
> Obviously everything is done from/in user space, so the sigframe
> building too.
> Since we can't know from user space if the thread has used or not the
> Altivec/VSX registers, since we can't rely on the MSR bits, we always
> dump these registers.

Right, however is that an issue ? These days with glibc using V{M,S}X
for things like memcpy I would think there is little to gain in trying
to avoid dumping them.

> > Alternately, when restoring, can you setup the sigframe with the Altivec/VSX
> > fields populated, and the kernel will then load them, regardless of whether
> > they were actually used or not prior to the checkpoint?
> 
> In the case of Altivec/VSX fields, we currently force the kernel to
> retrieve them from the signal frame by setting MSR_VEC/MSR_VSX so
> restore_sigcontext() will copy them to the kernel thread's state.

Yup, that's the way to go.

> However this doesn't touch to used_vsr and used_vr which may remain at 0.

That would be a kernel bug.

> Most of the time this is fine, but in the case a thread which has really
> used those registers is catching a signal just after the restore and
> before it has touched to these registers again (and so set used_vsr/vr),
> these registers will not be pushed in the newly built signal frame since
> setup_sigcontext() check for used_vsr/vr before pushing the registers on
> the stack.
> This may be an issue in the case the thread wants to changed those
> registers (don't ask me why :)) in the stacked signal frame from the
> signal handler since they will not be there...
> 
> Being able to get and set the used_vr and used_vsr thread's variables,
> fixes this issue.

I think the right fix is that if a restore_sigcontext() has the MSR bits set,
it should set the corresponding used_* flag.

Or is there a reason why that won't work ?

Cheers,
Ben.

> Cheers,
> Laurent.
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
