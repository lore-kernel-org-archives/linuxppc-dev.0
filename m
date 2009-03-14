Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: rsa@us.ibm.com
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs,
	and VSRs in the MSR
In-reply-to: <1236975831.3137.61.camel@localhost.localdomain> 
References: <1236975831.3137.61.camel@localhost.localdomain>
Date: Sat, 14 Mar 2009 19:20:45 +1100
Message-ID: <1746.1237018845@neuling.org>
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

> Hi all,
> 
> Those of us working on the POWER toolchain can envision a certain class
> of customers who may benefit from intelligently disabling certain
> register class enable bits on context switches, i.e. not disabling by
> default.
> 
> Currently, per process, if the MSR enable bits for FPs, VRs or VSRs are
> set to disabled, an interrupt will be generated as soon as an FP, VMX,
> or VSX instruction is encountered.  At this point the kernel enables the
> relevant bits in the MSR and returns.
> 
> Currently, the kernel will disable all of the bits on a context switch.
> 
> If a customer _knows_ a process will be using a register class
> extensively, e.g. VRs, they're paying the interrupt->enable-VMX price
> with every context switch.  It'd be nice if we could intelligently leave
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

Another option is to look at getting lazy save working on SMP.  We
currently only enable it on UP compiles.  

This would probably have the biggest performance impact when there is
only 1 FP/VSX/VMX application running per CPU.

Mikey

> 
> We have some ideas on how to benchmark this to verify the expense of the
> interrupt->enable.  As it presently works this stands in the way of
> using VMX or VSX for optimized string routines in GLIBC.
> 
> Regards,
> 
> Ryan S. Arnold
> IBM Linux Technology Center
> Linux Toolchain Development
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
