Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FAF91007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 04:05:34 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o59HpxDX017829
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jun 2010 13:51:59 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o59I5PJV050056
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jun 2010 14:05:26 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o59I5L3O005243
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jun 2010 14:05:21 -0400
Date: Wed, 9 Jun 2010 11:14:31 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Albert Cahalan <acahalan@gmail.com>
Subject: Re: [PATCH v21 011/100] eclone (11/11): Document sys_eclone
Message-ID: <20100609181431.GB1211@us.ibm.com>
References: <AANLkTimDfbJkAuoK1-asvk8Ub9C9QBkK5RkzLR3ilJUY@mail.gmail.com>
	<20100601193230.GA17579@us.ibm.com>
	<AANLkTinxCKl7RVe62UhIpNe5EriCufkgaih2D2mLLmC4@mail.gmail.com>
	<20100602013839.GB17579@us.ibm.com>
	<AANLkTinFGblE4fW35O0LchJZ22tz_5-qervpGC_lpUj_@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinFGblE4fW35O0LchJZ22tz_5-qervpGC_lpUj_@mail.gmail.com>
Cc: randy.dunlap@oracle.com, arnd@arndb.de,
	linux-kernel <linux-kernel@vger.kernel.org>, hpa@zytor.com,
	linuxppc-dev@lists.ozlabs.org, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Albert Cahalan [acahalan@gmail.com] wrote:
| On Tue, Jun 1, 2010 at 9:38 PM, Sukadev Bhattiprolu
| <sukadev@linux.vnet.ibm.com> wrote:
| > | Come on, seriously, you know it's ia64 and hppa that
| > | have issues. Maybe the nommu ports also have issues.
| > |
| > | The only portable way to specify the stack is base and offset,
| > | with flags or magic values for "share" and "kernel managed".
| >
| > Ah, ok, we have not yet ported to IA64 and I see now where the #ifdef
| > comes in.
| >
| > But are you saying that we should force x86 and other architectures to
| > specify base and offset for eclone() even though they currently specify
| > just the stack pointer to clone() ?
| 
| Even for x86, it's an easier API. Callers would be specifying
| two numbers they already have: the argument and return value
| for malloc. Currently the numbers must be added together,
| destroying information, except on hppa (must not add size)
| and ia64 (must use what I'm proposing already).

I agree its easier and would avoid #ifdefs in the applications.

Peter, Arnd, Roland - do you have any concerns with requiring all
architectures to specify the stack to eclone() as [base, offset]

To recap, currently we have 

struct clone_args {
	u64 clone_flags_high;
	/*
	 * Architectures can use child_stack for either the stack pointer or
	 * the base of of stack. If child_stack is used as the stack pointer,
	 * child_stack_size must be 0. Otherwise child_stack_size must be
	 * set to size of allocated stack.
	 */
	u64 child_stack;
	u64 child_stack_size;
	u64 parent_tid_ptr;
	u64 child_tid_ptr;
	u32 nr_pids;
	u32 reserved0;
};

sys_eclone(u32 flags_low, struct clone_args * __user cargs, int cargs_size,
		pid_t * __user pids)


Most architecutres would specify the stack pointer in ->child_stack and
ignore the ->child_stack_size.

IA64 specifies the *stack-base* in ->child_stack and the stack size in
->child_stack_size.

Albert and Randy point out that this would require #ifdefs in the
application code that intends to be portable across say IA64 and x86.

Can we instead have all architectures specify [base, size] ?

Thanks

Sukadev
