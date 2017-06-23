Return-Path: <breno.debian@gmail.com>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvQxk4bXKzDqjL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 03:51:54 +1000 (AEST)
Received: by mail-qt0-f195.google.com with SMTP id v31so2229931qtb.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 10:51:54 -0700 (PDT)
Date: Fri, 23 Jun 2017 14:51:44 -0300
From: Breno Leitao <leitao@debian.org>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/kernel: Avoid redundancies on giveup_all
Message-ID: <20170623175143.qzrcrwustarcg6hv@gmail.com>
References: <1498163243-22203-1-git-send-email-leitao@debian.org>
 <1498197792.7039.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498197792.7039.1.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,

On Fri, Jun 23, 2017 at 04:03:12PM +1000, Cyril Bur wrote:
> On Thu, 2017-06-22 at 17:27 -0300, Breno Leitao wrote:
> > Currently giveup_all() calls __giveup_fpu(), __giveup_altivec(), and
> > __giveup_vsx(). But __giveup_vsx() also calls __giveup_fpu() and
> > __giveup_altivec() again, in a redudant manner.
> > 
> > Other than giving up FP and Altivec, __giveup_vsx() also disables
> > MSR_VSX on MSR, but this is already done by __giveup_{fpu,altivec}().
> > As VSX can not be enabled alone on MSR (without FP and/or VEC
> > enabled), this is also a redundancy. VSX is never enabled alone (without
> > FP and VEC) because every time VSX is enabled, as through load_up_vsx()
> > and restore_math(), FP is also enabled together.
> > 
> > This change improves giveup_all() in average just 3%, but since
> > giveup_all() is called very frequently, around 8x per CPU per second on
> > an idle machine, this change might show some noticeable improvement.
> > 
> 
> So I totally agree except this makes me quite nervous. I know we're
> quite good at always disabling VSX when we disable FPU and ALTIVEC and
> we do always turn VSX on when we enable FPU AND ALTIVEC. But still, if
> we ever get that wrong...

Right, I understand your point, we can consider this code as a
'fallback' if we, somehow, forget to disable VSX when disabling
FPU/ALTIVEC. Good point.

> I'm more interested in how this improves giveup_all() performance by so
> much, but then hardware often surprises - I guess that's the cost of a
> function call.

I got this number using ftrace. I used the 'funcgraph' tracer with the
trace_options set to 'funcgraph-duration'. Then I set set_ftrace_filter with
giveup_all().

There is also a tool that helps with it if you wish. It uses the
exactly same mechanism I used but in a more automated way. The tool name
is funcgraph by Brendan.

https://github.com/brendangregg/perf-tools/blob/master/kernel/funcgraph

> Perhaps caching the thread.regs->msr isn't a good idea.

Yes, I looked at it, but it seems that the compiler is optimizing it, keeping
it at r30, and not saving in the memory/stack. This is the code being generated
here, where r9 contains the task pointer.

 usermsr = tsk->thread.regs->msr;
	c0000000000199c4:       08 01 c9 eb     ld r30,264(r9)

 if ((usermsr & msr_all_available) == 0)                                                                                                  
	c0000000000199c8:       60 5f 2a e9     ld r9,24416(r10)
	c0000000000199cc:       39 48 ca 7f     and.  r10,r30,r9
	c0000000000199d0:       20 00 82 40     bne c0000000000199f0 <giveup_all+0x60>

> If we could
> branch over in the common case and but still have the call to the
> function in case something goes horribly wrong?

Yes, we can revisit it on a future opportunity. Thanks for sharing your opinion.
