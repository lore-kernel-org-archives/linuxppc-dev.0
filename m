Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29F4F67A75
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2005 11:20:03 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
In-Reply-To: <4231387D.6030204@jp.fujitsu.com>
References: <20050303124435.GA24233@Redstar.dorchain.net>
	<4227153C.3030201@gmx.net>	<20050303141832.GU25080@Redstar.dorchain.net>
	<20050304075703.GA15637@Redstar.dorchain.net>
	<422FD24F.4070108@jp.fujitsu.com>
	<20050310072803.GR4017@Redstar.dorchain.net> <423073A9.70404@ybb.ne.jp>
	<4231387D.6030204@jp.fujitsu.com>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 11:18:05 +1100
Message-Id: <1110932285.25201.66.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: boot time scheduling hile atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-03-11 at 15:19 +0900, Takeharu KATO wrote:
> Hi Joerg:
> 
> First of all, I am sorry to making mistake on my stack analysis.
> After all, I found what is wrong.
> 
> The syscall_exit_work is called(jumped) by fork, strictly speaking,
> this is caused by kernel_thead for init process.
> At this point, kernel set a need_resched flag in thread_info struct
> (flags member).
> So, the system executes syscall_exit_work when
> the swapper thread exited from syscall.
> 
> However, the syscall_exit_work routine does not check
> preempt counts when it calls schedule function.
> 
> FYI, I post the patch which fix this problem.
> I've confirmed the problem has been removed by this patch,
> but I can not figure out whether it is truely
> correct or not.

I think the problem is more why are we calling a syscall while the
preempt count is up ?

Ben.
