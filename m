Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61A38DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 22:43:11 +1000 (EST)
In-Reply-To: <18168.62378.472571.655865@cargo.ozlabs.ibm.com>
References: <18168.62378.472571.655865@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <24149ACB-D786-4415-99A8-117FAC9936E6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull powerpc.git merge branch
Date: Tue, 25 Sep 2007 07:43:02 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>, Greg KH <gregkh@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 25, 2007, at 6:40 AM, Paul Mackerras wrote:

> Linus,
>
> Please do
>
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
>
> to get a patch from Roland McGrath that fixes a user-triggerable oops
> on 64-bit powerpc.
>
> Thanks,
> Paul.

Should this also go to -stable?

- k

>
>  arch/powerpc/kernel/process.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> commit 474f81967217f3bec2389ae913da72641f2c40e3
> Author: Roland McGrath <roland@redhat.com>
> Date:   Mon Sep 24 16:52:44 2007 -0700
>
>     [POWERPC] Ensure FULL_REGS on exec
>
>     When PTRACE_O_TRACEEXEC is used, a ptrace call to fetch the  
> registers at
>     the PTRACE_EVENT_EXEC stop (PTRACE_PEEKUSR) will oops in  
> CHECK_FULL_REGS.
>     With recent versions, "gdb --args /bin/sh -c 'exec /bin/true'"  
> and "run" at
>     the (gdb) prompt is sufficient to produce this.  I also have  
> written an
>     isolated test case, see https://bugzilla.redhat.com/ 
> show_bug.cgi?id=301791#c15.
>
>     This change fixes the problem by clearing the low bit of  
> pt_regs.trap in
>     start_thread so that FULL_REGS is true again.  This is correct  
> since all of
>     the GPRs that "full" refers to are cleared in start_thread.
>
>     Signed-off-by: Roland McGrath <roland@redhat.com>
>     Signed-off-by: Paul Mackerras <paulus@samba.org>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
