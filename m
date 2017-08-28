Return-Path: <ktkhai@virtuozzo.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0129.outbound.protection.outlook.com [104.47.0.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgpMB2m00zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 20:45:25 +1000 (AEST)
Subject: Re: [linux-next][ppc] kernel hung when running trinity fuzzer
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@suse.com>,
 linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 sachinp <sachinp@linux.vnet.ibm.com>
References: <1503916099.3740.8.camel@abdul.in.ibm.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <54ce6db5-68c1-e8f3-3804-63efb31956bf@virtuozzo.com>
Date: Mon, 28 Aug 2017 13:45:21 +0300
MIME-Version: 1.0
In-Reply-To: <1503916099.3740.8.camel@abdul.in.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28.08.2017 13:28, Abdul Haleem wrote:
> Hi,
> 
> offlate we are seeing hung task call traces when running trinity fuzzer
> test. kernel go hung and requires machine reboot.
> 
> Machine Type : Power 8
> Kernel : 4.13.0-rc6-next-20170825
> config: Tul-VM-config
> 
> 
> call traces:
> -------------
> INFO: task systemd-timesyn:472 blocked for more than 120 seconds.
>       Not tainted 4.13.0-rc6-next-20170825 #3
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
> systemd-timesyn D    0   472      1 0x00040000   
> Call Trace:
> [c000000775f2b750] [0000000b00000000] 0xb00000000 (unreliable)
> [c000000775f2b920] [c00000000001c788] __switch_to+0x2a8/0x470
> [c000000775f2b980] [c000000000c16974] __schedule+0x394/0xa40
> [c000000775f2ba50] [c000000000c17068] schedule+0x48/0xc0
> [c000000775f2ba80] [c000000000c1b2e8] rwsem_down_read_failed+0x128/0x1b0
> [c000000775f2bae0] [c0000000001700c8] __percpu_down_read+0x108/0x110
> [c000000775f2bb10] [c00000000038fda8] __sb_start_write+0x118/0x130
> [c000000775f2bb50] [c0000000003c1768] mnt_want_write+0x38/0x80
> [c000000775f2bb80] [c0000000003a3328] path_openat+0x9c8/0x14b0
> [c000000775f2bc90] [c0000000003a579c] do_filp_open+0xfc/0x170
> [c000000775f2bdc0] [c000000000388618] do_sys_open+0x1b8/0x2e0
> [c000000775f2be30] [c00000000000b184] system_call+0x58/0x6c
> INFO: task rs:main Q:Reg:624 blocked for more than 120 seconds.
>       Not tainted 4.13.0-rc6-next-20170825 #3

I'm in CC here, but it doesn't seem my commit 83ced169d9a0 "locking/rwsem-xadd:
Add killable versions of rwsem_down_read_failed()" is involved.

It introduces the code, which is unused at the moment:

kirill$:~/linux-next$ git grep rwsem_down_read_failed_killable
include/linux/rwsem.h:extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
kernel/locking/rwsem-xadd.c:rwsem_down_read_failed_killable(struct rw_semaphore *sem)
kernel/locking/rwsem-xadd.c:EXPORT_SYMBOL(rwsem_down_read_failed_killable);

We still call rwsem_down_read_failed() with TASK_UNINTERRUPTIBLE argument, so "signal_pending_state()" branch
is always dead.
