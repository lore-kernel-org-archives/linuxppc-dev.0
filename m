Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09A4567B15
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 09:32:12 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1FsTE0-0000U4-Mp
	for linuxppc-dev@ozlabs.org; Mon, 19 Jun 2006 18:32:09 -0500
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 5/9 v3] Add the MPC8641 HPCN platform files. 
In-Reply-To: Your message of "Tue, 20 Jun 2006 01:18:06 +0200."
	<F5D6E2FC-CE35-4681-9F42-A1B4E2BFE097@kernel.crashing.org>
References: <E1Frjen-0004Oz-Hz@jdl.com>
	<1150600056.23600.152.camel@localhost.localdomain>
	<1150725866.9022.5.camel@cashmere.sps.mot.com>
	<F34E213C-B073-4D85-A323-644340E3C09D@kernel.crashing.org>
	<E1FsSOB-0000CE-2o@jdl.com>
	<A609CF22-66E8-404C-A6F2-528BE097BF57@kernel.crashing.org>
	<E1FsSuB-0000Qc-P6@jdl.com>
	<F5D6E2FC-CE35-4681-9F42-A1B4E2BFE097@kernel.crashing.org>
Date: Mon, 19 Jun 2006 18:32:08 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FsTE0-0000U4-Mp@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Segher Boessenkool mumbled:
> 
> I'm confused now.  So are or arent't all CPUs running at the
> time Linux is started?

Only the boot CPU is running.  The others are not.

>  Are you saying Linux manually starts
> all non-boot CPUs?!?

Right.  The secondary CPUs are not clocking, not able to
fetch memory, not nothing until Linux gets a shot at
smp_secondary_kick()'ing them into motion.  And then we
have the ability to start the scondary CPUs one at a time.

jdl
