Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id ABF9667A67
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2005 15:52:59 +1100 (EST)
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by fgwmail8.fujitsu.co.jp (8.13.3/Fujitsu Gateway)
	id j2A4qv1C014209 for <linuxppc-dev@ozlabs.org>;
	Thu, 10 Mar 2005 13:52:57 +0900
	(envelope-from kato.takeharu@jp.fujitsu.com)
Message-ID: <422FD24F.4070108@jp.fujitsu.com>
Date: Thu, 10 Mar 2005 13:51:27 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: Joerg Dorchain <joerg@dorchain.net>
References: <20050303124435.GA24233@Redstar.dorchain.net>	<4227153C.3030201@gmx.net>	<20050303141832.GU25080@Redstar.dorchain.net>
	<20050304075703.GA15637@Redstar.dorchain.net>
In-Reply-To: <20050304075703.GA15637@Redstar.dorchain.net>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: Re: boot time scheduling hile atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

Joerg Dorchain wrote:
> On Thu, Mar 03, 2005 at 03:18:32PM +0100, Joerg Dorchain wrote:
> 
>>>>scheduling while atomic: swapper/0x00000002/0
>>>>Call trace:
>>>> [c0007620] dump_stack+0x18/0x28
>>>> [c01de704] schedule+0x678/0x67c
>>>> [c0004500] syscall_exit_work+0x108/0x10c
>>>> [c02a97b4] proc_root_init+0x168/0x174
>>>> [ff847288] 0xff847288
>>>> [c02945e8] start_kernel+0x144/0x170
>>>> [00003a30] 0x3a30
>>
>>I'll do tonight.
> 
> I am more wondering what in proc_root_init or immediately after it
> causes a call to the exit_work syscall.
> 
This is not called by proc_root_init.
It seems be called by timer interrupt
(I confirmed it by viewing trap number in
interrupt context with ICE).

As long as I investigate the problem,
proc_root_init is called twice.
At first time, it's called from
start_kernel in init/main.c.
Second case, it seems to be called by some kind of
init call facility.

proc_root_init is not init_call function, I could not
figure out concretely why it called twice.

I will investigate the problem as long as I can.

I wishes this report to become your help.

Regards,
-- 
Takeharu KATO
Fujitsu Limited
Email:kato.takeharu at jp.fujitsu.com
