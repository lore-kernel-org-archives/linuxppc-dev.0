Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A34FB6F07
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Nov 2010 04:33:11 +1100 (EST)
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id 87AAF2597BE
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Nov 2010 18:33:07 +0100 (CET)
In-Reply-To: <OF385C74E5.E81887CB-ONC12577D5.00527686-C12577D5.0052E6B5@transmode.se>
References: <OF385C74E5.E81887CB-ONC12577D5.00527686-C12577D5.0052E6B5@transmode.se>
Subject: Re: INFO: task snmpd:398 blocked for more than 120 seconds.
Message-ID: <OF5A1033A2.48B05F1F-ONC12577D5.00605774-C12577D5.00606A22@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 8 Nov 2010 18:33:06 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org wrote on 2010/11/08 16:05:30:

> From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> To: linuxppc-dev@ozlabs.org
> Date: 2010/11/08 16:12
> Subject: INFO: task snmpd:398 blocked for more than 120 seconds.
> Sent by: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org
>
>
> I can't make out what is causing this hang every now an then:
>
> INFO: task snmpd:398 blocked for more than 120 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> snmpd         D 0fad1760     0   398      1 0x00000000
> Call Trace:
> [c7b5fc70] [c7a49a80] 0xc7a49a80 (unreliable)
> [c7b5fd30] [c0008608] __switch_to+0x4c/0x6c
> [c7b5fd40] [c028fed4] schedule+0x184/0x310
> [c7b5fd70] [c0290e5c] __mutex_lock_slowpath+0xa4/0x150
> [c7b5fdb0] [c0290c50] mutex_lock+0x44/0x48
> [c7b5fdc0] [c01eb5b0] rtnl_lock+0x18/0x28
> [c7b5fdd0] [c01df6c4] dev_ioctl+0x2b4/0x764
> [c7b5fe60] [c01cafc8] sock_ioctl+0x18c/0x2a0
> [c7b5fe80] [c009a16c] vfs_ioctl+0xcc/0xe0
> [c7b5fea0] [c009a998] do_vfs_ioctl+0xc4/0x79c
> [c7b5ff10] [c009b0b0] sys_ioctl+0x40/0x74
> [c7b5ff40] [c00117c4] ret_from_syscall+0x0/0x38
>
> The dev_ioctl is in SIOCGIFCONF:
> int dev_ioctl(struct net *net, unsigned int cmd, void __user *arg)
> {
>    struct ifreq ifr;
>    int ret;
>    char *colon;
>
>    /* One special case: SIOCGIFCONF takes ifconf argument
>       and requires shared lock, because it sleeps writing
>       to user space.
>     */
>
>    if (cmd == SIOCGIFCONF) {
>       rtnl_lock();
>       ret = dev_ifconf(net, (char __user *) arg);
>       rtnl_unlock();
>       return ret;
>    }
>
> Any ideas? Kernel is 2.6.35

I tried PROVE_LOCKING but now my kernel doesn't boot at all :)

Something goes very wrong in arch/powerpc/kernel/prom.c:694
694		memblock_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);

(gdb) print klimit
$8 = 0xc08c9000

What is klimit and can I do something about it?

kernel 2.6.35 on a mpc8321
