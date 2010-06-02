Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B69BBB7D51
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Jun 2010 11:30:37 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o521E1oY019267
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Jun 2010 21:14:01 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o521UXY1131710
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Jun 2010 21:30:33 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o521UWnp001670
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Jun 2010 22:30:33 -0300
Date: Tue, 1 Jun 2010 18:38:39 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Albert Cahalan <acahalan@gmail.com>
Subject: Re: [PATCH v21 011/100] eclone (11/11): Document sys_eclone
Message-ID: <20100602013839.GB17579@us.ibm.com>
References: <AANLkTimDfbJkAuoK1-asvk8Ub9C9QBkK5RkzLR3ilJUY@mail.gmail.com>
	<20100601193230.GA17579@us.ibm.com>
	<AANLkTinxCKl7RVe62UhIpNe5EriCufkgaih2D2mLLmC4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinxCKl7RVe62UhIpNe5EriCufkgaih2D2mLLmC4@mail.gmail.com>
Cc: randy.dunlap@oracle.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

| Come on, seriously, you know it's ia64 and hppa that
| have issues. Maybe the nommu ports also have issues.
| 
| The only portable way to specify the stack is base and offset,
| with flags or magic values for "share" and "kernel managed".

Ah, ok, we have not yet ported to IA64 and I see now where the #ifdef
comes in.

But are you saying that we should force x86 and other architectures to
specify base and offset for eclone() even though they currently specify
just the stack pointer to clone() ?

That would remove the ifdef, but could be a big change to applications
on x86 and other architectures.

| 
| > | There is no reason to have field usage vary by architecture. The
| >
| > The field usage does not vary by architecture. Some architectures
| > don't use some fields and those fields must be 0.
| 
| It looks like you contradict yourself. Please explain how
| those two sentences are compatible.
| 
| > | original clone syscall was not designed with ia64 and hppa
| > | in mind, and has been causing trouble ever since. Let's not
| > | perpetuate the problem.
| >
| > and lot of folks contributed to this new API to try and make sure
| > it is portable and meets the forseeable requirements.
| 
| Right, and some folks were ignored.

I don't think your comment was ignored. The ->child_stack_size field was
added specifically for IA64 and my understanding was that ->clone_flags_high
could be used to specify the "kernel managed" or "shared" mode you mention
above.

| >
| > I don't understand how "making up some numbers (pids) that will work"
| > is more portable/cleaner than the proposed eclone().
| 
| It isolates the cross-platform problems to an obscure tool
| instead of polluting the kernel interface that everybody uses.

Sure, there was talk about using an approach like /proc/<pid>/next_pid
where you write your target pid into the file and the next time you
fork() you get that target pid. But it was considered racy and ugly.

Sukadev
