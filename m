Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CFA381007D2
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2010 06:18:37 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id o0OJIZih001810
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2010 06:18:35 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0OJDl3w1523740
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2010 06:13:47 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0OJIaLj029203
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2010 06:18:36 +1100
Date: Mon, 25 Jan 2010 00:48:30 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: shaggy@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
Subject: Re: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers
	through extended ptrace interface
Message-ID: <20100124191830.GB14075@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, David Gibson <dwg@au1.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From shaggy at linux.vnet.ibm.com  Tue Jan 19 08:57:04 2010
From: shaggy at linux.vnet.ibm.com (Dave Kleikamp)
Date: Mon, 18 Jan 2010 14:57:04 -0700
Subject: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers through
	extended ptrace interface
Message-ID: <20100118215704.15684.60646.sendpatchset@norville.austin.ibm.com>

> These patches implement an extention to the ptrace interface proposed by
> Thiago Bauermann and the the PowerPC gdb team.

(Using the plain text from mail archive..mail may not be in the usual
mail-reply format...kindly bear).

Hi,
  First of all, thanks for bringing this patch that puts the debug
registers in BookE to good use! I learnt about this patch submission
only recently...please see some of my concerns as under.

Given that there now exists generic kernel interfaces to use
hw-breakpoints - register_user_hw_breakpoint() and
unregister_hw_breakpoint() (available in mainline since 2.6.33-rc1), it
would be prudent to use them for the ptrace requests (that are made in
arch_ptrace()).

This would mean that some of the arch-specific debug register code that
read/write from/to the debug registers of Book-E may have to be in a
form that closely resembles arch/<x86><power>/kernel/hw_breakpoint.c 

A patch that enables arch-specific code for PPC64 is already submitted
(linuxppc-dev ref: 20100121084640.GA3252@in.ibm.com). This converts
ptrace requests for PTRACE_<GET><SET>_DEBUGREG flags to use the
above-mentioned interfaces for PPC64.

If you intend to re-write this patch to use the generic hw-breakpoint
interfaces (which I strongly recommend you to do, for the reasons mentioned
below), I would be more than glad to help you port them.

Some of the benefits of using these generic interfaces include:
- Interoperability with other users of debug register (such as parallel
  kernel requests) i.e. non-exclusive use of debug registers.
- Enables debugging/tracing tools such as perf-events and ftrace to make
  use of debug registers.
- Re-use of common code available in kernel (kernel/hw_breakpoint.c).

Let me know what you think.

Thanks,
K.Prasad
