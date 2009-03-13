Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BA69DDDF0
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 08:15:18 +1100 (EST)
Message-Id: <6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: rsa@us.ibm.com
In-Reply-To: <1236975831.3137.61.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs,
	and VSRs in the MSR
Date: Fri, 13 Mar 2009 16:15:11 -0500
References: <1236975831.3137.61.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Steven Munroe <sjmunroe@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 13, 2009, at 3:23 PM, Ryan Arnold wrote:

> Hi all,
>
> Those of us working on the POWER toolchain can envision a certain  
> class
> of customers who may benefit from intelligently disabling certain
> register class enable bits on context switches, i.e. not disabling by
> default.
>
> Currently, per process, if the MSR enable bits for FPs, VRs or VSRs  
> are
> set to disabled, an interrupt will be generated as soon as an FP, VMX,
> or VSX instruction is encountered.  At this point the kernel enables  
> the
> relevant bits in the MSR and returns.
>
> Currently, the kernel will disable all of the bits on a context  
> switch.
>
> If a customer _knows_ a process will be using a register class
> extensively, e.g. VRs, they're paying the interrupt->enable-VMX price
> with every context switch.  It'd be nice if we could intelligently  
> leave
> the bits enabled.
>
> Solutions:
> - A boot flag which always enables VSRs, VRs, FPRs, etc.  These are
> cumulative, i.e. VSRs implies VRs and FPRS; VRs implies FPRs.
>
> - A heuristic which permanently enables said register classes for a
> process if they've been enabled during the previous X interrupts.
>
> - The same heuristic could disable the register class bits after a
> certain criteria is met.
>
> We have some ideas on how to benchmark this to verify the expense of  
> the
> interrupt->enable.  As it presently works this stands in the way of
> using VMX or VSX for optimized string routines in GLIBC.

If these applications are aware they are heavy users (of FP, VMX, VSX)  
can we not use a sysctl()?  Doing so wouldn't be that difficult.

I think trying to do something based on a runtime heuristic sounds a  
bit iffy.

- k
