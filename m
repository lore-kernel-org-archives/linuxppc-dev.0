Return-Path: <serge@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C745DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 06:58:42 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1OJwH2p031344
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 12:58:17 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n1OJwRx7136336
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 12:58:32 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1OJwPXQ024031
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 12:58:26 -0700
Date: Tue, 24 Feb 2009 13:58:26 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 1/3] powerpc: bare minimum checkpoint/restart
	implementation
Message-ID: <20090224195826.GA25909@us.ibm.com>
References: <1233182478-27113-1-git-send-email-ntl@pobox.com>
	<1233182478-27113-2-git-send-email-ntl@pobox.com>
	<49814FA2.9060108@cs.columbia.edu>
	<20090129214035.GB6913@localdomain>
	<20090217010355.58afd5cf@thinkcentre.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090217010355.58afd5cf@thinkcentre.lan>
Cc: containers@lists.osdl.org, Oren Laadan <orenl@cs.columbia.edu>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quoting Nathan Lynch (ntl@pobox.com):
> Nathan Lynch <ntl@pobox.com> wrote:
> >
> > Oren Laadan wrote:
> > > 
> > > Nathan Lynch wrote:
> > > > 
> > > > What doesn't work:
> > > > * restarting a 32-bit task from a 64-bit task and vice versa
> > > 
> > > Is there a test to bail if we attempt to checkpoint such tasks ?
> > 
> > No, but I'll add one if it looks too hard to fix for the next round.
> 
> Unfortunately, adding a check for this is hard.
> 
> The "point of no return" in the restart path is cr_read_mm, which tears
> down current's address space.  cr_read_mm runs way before cr_read_cpu,
> which is the only restart method I've implemented for powerpc so far.
> So, checking for this condition in cr_read_cpu is too late if I want
> restart(2) to return an error and leave the caller's memory map
> intact.  (And I do want this: restart should be as robust as execve.)
> 
> Well okay then, cr_read_head_arch seems to be the right place in the
> restart sequence for the architecture code to handle this.  However,
> cr_write_head_arch (which produces the buffer that cr_read_head_arch
> consumes) is not provided a reference to the task to be checkpointed,
> nor can it assume that it's operating on current.  I need a reference
> to a task before I can determine whether it's running in 32- or 64-bit
> mode, or using the FPU, Altivec, SPE, whatever.
> 
> In any case, mixing 32- and 64-bit tasks across restart is something I
> eventually want to support, not reject.  But the problem I've outlined
> applies to FPU state and vector extensions (VMX, SPE), as well as
> sanity-checking debug register (DABR) contents.  We'll need to be able
> to error out gracefully from restart when a checkpoint image specifies a
> feature unsupported by the current kernel or hardware.  But I don't see
> how to do it with the current architecture.  Am I missing something?

I suspect I can guess the response to this suggestion, but how about we
accept that if sys_restart() fails due to something like this, the
task is lost and can't exit gracefully?  The end-user can then run
a user-space program to run through the checkpoint image ahead of
time (if they want) and verify whether restart can be expected to
succeed on the current hardware and os version?

If a minor difference is detected, the user-space program might
simply rewrite (a copy of) the checkpoint image into one which can
in fact succeed.

-serge
