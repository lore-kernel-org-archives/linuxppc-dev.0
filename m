Return-Path: <roland@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 2BAC1B6F2B
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 11:56:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: prasad@linux.vnet.ibm.com
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
In-Reply-To: K.Prasad's message of  Friday, 11 December 2009 21:34:09 +0530
	<20091211160409.GB23156@in.ibm.com>
References: <20091211160409.GB23156@in.ibm.com>
Message-Id: <20091214005648.82BA31DE@magilla.sf.frob.com>
Date: Sun, 13 Dec 2009 16:56:48 -0800 (PST)
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I can't see anything you've done to keep this use of MSR_SE in the
user-mode register state from interfering with user_enable_single_step().
It looks to me like you'd swallow the normal step indications.

Likewise I'm not very clear on the interaction with kprobes, kgdb,
or whatnot for kernel-mode cases.  But I'll leave those concerns to
others, since I know more about the user-mode situations.

Back to the user-mode case, is it really reasonable to disable
preemption in hw_breakpoint_handler and leave it so across returning
to user mode?  (Is that even possible?  I thought user mode was
always preemptible.)  That is done very casually with little comment
in hw_breakpoint_handler and single_step_dabr_instruction, but it
seems like an extremely deep and magical thing that merits more
explanation.  I guess the need for it has to do with the per_cpu
variable you're using, but the whole situation is not very clear on
first reading.  Even for kernel mode, what does this mean when the
stepped instruction does a page fault?


Thanks,
Roland
