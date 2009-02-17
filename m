Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 7B317DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 18:04:08 +1100 (EST)
Date: Tue, 17 Feb 2009 01:03:55 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Oren Laadan <orenl@cs.columbia.edu>
Subject: Re: [PATCH 1/3] powerpc: bare minimum checkpoint/restart
	implementation
Message-ID: <20090217010355.58afd5cf@thinkcentre.lan>
In-Reply-To: <20090129214035.GB6913@localdomain>
References: <1233182478-27113-1-git-send-email-ntl@pobox.com>
	<1233182478-27113-2-git-send-email-ntl@pobox.com>
	<49814FA2.9060108@cs.columbia.edu> <20090129214035.GB6913@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: containers@lists.osdl.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch <ntl@pobox.com> wrote:
>
> Oren Laadan wrote:
> > 
> > Nathan Lynch wrote:
> > > 
> > > What doesn't work:
> > > * restarting a 32-bit task from a 64-bit task and vice versa
> > 
> > Is there a test to bail if we attempt to checkpoint such tasks ?
> 
> No, but I'll add one if it looks too hard to fix for the next round.

Unfortunately, adding a check for this is hard.

The "point of no return" in the restart path is cr_read_mm, which tears
down current's address space.  cr_read_mm runs way before cr_read_cpu,
which is the only restart method I've implemented for powerpc so far.
So, checking for this condition in cr_read_cpu is too late if I want
restart(2) to return an error and leave the caller's memory map
intact.  (And I do want this: restart should be as robust as execve.)

Well okay then, cr_read_head_arch seems to be the right place in the
restart sequence for the architecture code to handle this.  However,
cr_write_head_arch (which produces the buffer that cr_read_head_arch
consumes) is not provided a reference to the task to be checkpointed,
nor can it assume that it's operating on current.  I need a reference
to a task before I can determine whether it's running in 32- or 64-bit
mode, or using the FPU, Altivec, SPE, whatever.

In any case, mixing 32- and 64-bit tasks across restart is something I
eventually want to support, not reject.  But the problem I've outlined
applies to FPU state and vector extensions (VMX, SPE), as well as
sanity-checking debug register (DABR) contents.  We'll need to be able
to error out gracefully from restart when a checkpoint image specifies a
feature unsupported by the current kernel or hardware.  But I don't see
how to do it with the current architecture.  Am I missing something?
