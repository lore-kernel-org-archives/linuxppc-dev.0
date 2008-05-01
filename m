Return-Path: <roland@redhat.com>
Received: from QMTA06.westchester.pa.mail.comcast.net
	(qmta06.westchester.pa.mail.comcast.net [76.96.62.56])
	by ozlabs.org (Postfix) with ESMTP id 5EB83DDEEC
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 09:55:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: overloading existing PTRACE_GET_DEBUGREG/PTRACE_SET_DEBUGREG
	commands
In-Reply-To: Kumar Gala's message of  Tuesday, 29 April 2008 03:56:31 -0500
	<30110DA2-3887-4679-9073-CC69A267E9DC@kernel.crashing.org>
References: <30110DA2-3887-4679-9073-CC69A267E9DC@kernel.crashing.org>
Message-Id: <20080501235515.A06CE26FA07@magilla.localdomain>
Date: Thu,  1 May 2008 16:55:15 -0700 (PDT)
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Paralkar Anmol <Anmol@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For the short answer, no, I'd like not to extend PTRACE_SET_DEBUGREG in
the simple fashion.  The direction I want to move with this is away from
providing the hardware register formats directly as the user ABI.

What I mean is resurrecting, finishing, and porting the "hw_breakpoint"
work that Alan Stern <stern@rowland.harvard.edu> started, but which was
never finished or merged.  This is an in-kernel interface handling the
hardware details and multiplexing in-kernel and user uses, with a
higher-level API that is mostly machine-independent.  The idea is that
future user-level extensions for watchpoint-like features would be based
on that, not on exposing hardware features directly as such.

I think someone at IBM told me they were going to look at picking that
work up, but I'll have to remember who and track them down.

> Also, what functionality can GDB take advantage of today?  Does it  
> comprehend the idea of breakpoints or watchpoints that cover a range?

I'm not the expert on that, but probably the answer is "sort of".
The low-level feature on s390 is range-based, and it supports that.
The hook for machine support uses "addr+len", though on most machines
len has to be 8 or has to be {1,2,4,8} and addr has to be aligned to len.
I'm not sure that high-level watchpoints ever translate into big ranges
in practice.

Understanding the details of all the hardware features in the powerpc
variants would inform ironing out the hw_breakpoint interface details.


Thanks,
Roland
