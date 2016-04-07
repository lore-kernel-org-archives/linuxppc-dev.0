Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgcjg1DYRzDq6R
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 19:29:11 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 7 Apr 2016 19:29:09 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0C8D33578062
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 19:28:50 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u379SY6m10879066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 19:28:44 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u379Rg7e003566
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 19:27:43 +1000
Date: Thu, 7 Apr 2016 14:56:38 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 0/2] perf probe fixes for ppc64le
Message-ID: <20160407092636.GK15993@naverao1-tp.in.ibm.com>
References: <cover.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
 <57061802.7020508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57061802.7020508@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/04/07 06:19PM, Balbir Singh wrote:
> 
> On 06/04/16 22:32, Naveen N. Rao wrote:
> > This patchset fixes three issues found with perf probe on ppc64le:
> > 1. 'perf test kallsyms' failure on ppc64le (reported by Michael
> > Ellerman). This was due to the symbols being fixed up during symbol
> > table load. This is fixed in patch 2 by delaying symbol fixup until
> > later.
> > 2. perf probe function offset was being calculated from the local entry
> > point (LEP), which does not match user expectation when trying to look
> > at function disassembly output (reported by Ananth N). This is fixed for
> > kallsyms in patch 1 and for symbol table in patch 2.
> 
> I think the bit where the offset is w.r.t LEP when using a name, but w.r.t
> GEP when using function+offset can be confusing.

Thanks for your review!

The rationale for this is actually from the end-user perspective. The 
two use cases we are considering are:
1. User just wants to probe at function entry point:
	# perf probe _do_fork

In this case, the user most definitely needs the local entry point, 
without which the probe won't be hit. So, for this case, we 
automatically insert the probe at the LEP.

[We really only want to alter perf probe behavior in this case only, but 
we were incorrectly changing the behavior of perf with the below 
scenario as well.]

2. User wants to probe at a specific location. In this case, the user 
most likely starts by looking at the function disassembly. For instance:
	# objdump -S -d vmlinux.bak | grep -A100 \<_do_fork\>:
	c0000000000b6a00 <_do_fork>:
		      unsigned long stack_start,
		      unsigned long stack_size,
		      int __user *parent_tidptr,
		      int __user *child_tidptr,
		      unsigned long tls)
	{
	c0000000000b6a00:	f7 00 4c 3c 	addis   r2,r12,247
	c0000000000b6a04:	00 86 42 38 	addi    r2,r2,-31232
	c0000000000b6a08:	a6 02 08 7c 	mflr    r0
	c0000000000b6a0c:	d0 ff 41 fb 	std     r26,-48(r1)
	c0000000000b6a10:	26 80 90 7d 	mfocrf  r12,8
	...<snip>...
		if (!(clone_flags & CLONE_UNTRACED)) {
	c0000000000b6a54:	e3 4f c7 7b 	rldicl. r7,r30,41,63
	c0000000000b6a58:	2c 00 82 40 	bne     c0000000000b6a84 <_do_fork+0x84>
			if (clone_flags & CLONE_VFORK)
	c0000000000b6a5c:	e3 97 c8 7b 	rldicl. r8,r30,50,63
	c0000000000b6a60:	a0 01 82 41 	beq     c0000000000b6c00 <_do_fork+0x200>
	c0000000000b6a64:	20 00 20 39 	li      r9,32
				trace = PTRACE_EVENT_VFORK;
	c0000000000b6a68:	02 00 80 3b 	li      r28,2
	c0000000000b6a6c:	10 02 4d e9 	ld      r10,528(r13)

If the user wants to probe at _do_fork+0x54, he'd do:
	# perf probe _do_fork+0x54

With the earlier approach, we would insert the probe at _do_fork+0x5c 
(0x54 from the LEP) instead, which is incorrect.

In reality, user would probably just use debuginfo:
	# perf probe -L _do_fork
	<_do_fork@/root/linus/kernel/fork.c:0>
	      0  long _do_fork(unsigned long clone_flags,
			      unsigned long stack_start,
			      unsigned long stack_size,
			      int __user *parent_tidptr,
			      int __user *child_tidptr,
			      unsigned long tls)
	      6  {
			struct task_struct *p;
	      8         int trace = 0;
			long nr;
		 
			/*
			 * Determine whether and which event to report to ptracer.  When
			 * called from kernel_thread or CLONE_UNTRACED is explicitly
			 * requested, no event is reported; otherwise, report if the event
			 * for the type of forking is enabled.
			 */
	     17         if (!(clone_flags & CLONE_UNTRACED)) {
	     18                 if (clone_flags & CLONE_VFORK)
	     19                         trace = PTRACE_EVENT_VFORK;
	     20                 else if ((clone_flags & CSIGNAL) != SIGCHLD)
	     21                         trace = PTRACE_EVENT_CLONE;

	# perf probe _do_fork:17

In this case, perf chooses the right address based on DWARF. The current 
patchset matches the behavior of perf without debuginfo with this.

> Do we really need probe
> points between GEP and LEP? All the GEP does is setup r2. The use case
> could be more generic, but please clarify.

There could be scenarios where having a probe point between GEP and LEP 
is useful - for instance, if we are only interested in calls to an 
in-kernel function from an external module. However, this is a secondary 
consideration and the more important consideration was to be consistent 
with userspace tooling (readelf/objdump) while choosing the address to 
probe.

- Naveen
