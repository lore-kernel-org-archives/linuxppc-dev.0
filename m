Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id D09B067A46
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2005 16:25:14 +1100 (EST)
Message-ID: <4237C319.4050109@jp.fujitsu.com>
Date: Wed, 16 Mar 2005 14:24:41 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20050303124435.GA24233@Redstar.dorchain.net>	
	<4227153C.3030201@gmx.net>	<20050303141832.GU25080@Redstar.dorchain.net>	
	<20050304075703.GA15637@Redstar.dorchain.net>	
	<422FD24F.4070108@jp.fujitsu.com>	
	<20050310072803.GR4017@Redstar.dorchain.net>
	<423073A9.70404@ybb.ne.jp>	 <4231387D.6030204@jp.fujitsu.com>
	<1110932285.25201.66.camel@gaston>
In-Reply-To: <1110932285.25201.66.camel@gaston>
Content-Type: text/plain; charset=us-ascii
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

Hi Benjamin:

Thank you for your response.

> I think the problem is more why are we calling a syscall while the
> preempt count is up ?
> 
Because, start_kernel(line:455) in init/main.c count up this.
-- start_kernel (init/main.c)
451         /*
452          * Disable preemption - early bootup scheduling is extremely
453          * fragile until we cpu_idle() for the first time.
454          */
455         preempt_disable();
456         build_all_zonelists();
-- start_kernel(init/main.c)

Preemption is disabled until it enters the body of idle task from rest_init.
Please see below:
-- rest_init (init/main.c)
379 static void noinline rest_init(void)
380         __releases(kernel_lock)
381 {
382         kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
383         numa_default_policy();
384         unlock_kernel();
385         preempt_enable_no_resched();
386         cpu_idle();
387 }
--
I think that the kernel assumes that init thread(the kernel thread which become to
init process later) is kicked by idle process(cpu_idle).

But, the kernel invoke a system call trap when it execute kernel_thread call
(at rest_init line:382) on PowerPC.
The preemption count has positive value here.
So, PowerPC linux kernel invoke system call when the preempt count is up.

Regards,

-- 
Takeharu KATO
Fujitsu Limited
Email:kato.takeharu at jp.fujitsu.com
