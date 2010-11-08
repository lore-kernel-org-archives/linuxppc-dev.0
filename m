Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6D94B7108
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Nov 2010 05:22:27 +1100 (EST)
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id 10A4A2597BE
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Nov 2010 19:22:24 +0100 (CET)
In-Reply-To: <OF5A1033A2.48B05F1F-ONC12577D5.00605774-C12577D5.00606A22@transmode.se>
References: <OF385C74E5.E81887CB-ONC12577D5.00527686-C12577D5.0052E6B5@transmode.se>
	<OF5A1033A2.48B05F1F-ONC12577D5.00605774-C12577D5.00606A22@transmode.se>
Subject: Re: INFO: task snmpd:398 blocked for more than 120 seconds.
Message-ID: <OF842B4241.74D0E305-ONC12577D5.00649397-C12577D5.0064ED20@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 8 Nov 2010 19:22:23 +0100
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

>
> linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org wrote on 2010/11/08 16:05:30:
>
> > From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> > To: linuxppc-dev@ozlabs.org
> > Date: 2010/11/08 16:12
> > Subject: INFO: task snmpd:398 blocked for more than 120 seconds.
> > Sent by: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org
> >
> >
> > I can't make out what is causing this hang every now an then:
> >
> > INFO: task snmpd:398 blocked for more than 120 seconds.
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > snmpd         D 0fad1760     0   398      1 0x00000000
> > Call Trace:
> > [c7b5fc70] [c7a49a80] 0xc7a49a80 (unreliable)
> > [c7b5fd30] [c0008608] __switch_to+0x4c/0x6c
> > [c7b5fd40] [c028fed4] schedule+0x184/0x310
> > [c7b5fd70] [c0290e5c] __mutex_lock_slowpath+0xa4/0x150
> > [c7b5fdb0] [c0290c50] mutex_lock+0x44/0x48
> > [c7b5fdc0] [c01eb5b0] rtnl_lock+0x18/0x28
> > [c7b5fdd0] [c01df6c4] dev_ioctl+0x2b4/0x764
> > [c7b5fe60] [c01cafc8] sock_ioctl+0x18c/0x2a0
> > [c7b5fe80] [c009a16c] vfs_ioctl+0xcc/0xe0
> > [c7b5fea0] [c009a998] do_vfs_ioctl+0xc4/0x79c
> > [c7b5ff10] [c009b0b0] sys_ioctl+0x40/0x74
> > [c7b5ff40] [c00117c4] ret_from_syscall+0x0/0x38
> >
> > The dev_ioctl is in SIOCGIFCONF:
> > int dev_ioctl(struct net *net, unsigned int cmd, void __user *arg)
> > {
> >    struct ifreq ifr;
> >    int ret;
> >    char *colon;
> >
> >    /* One special case: SIOCGIFCONF takes ifconf argument
> >       and requires shared lock, because it sleeps writing
> >       to user space.
> >     */
> >
> >    if (cmd == SIOCGIFCONF) {
> >       rtnl_lock();
> >       ret = dev_ifconf(net, (char __user *) arg);
> >       rtnl_unlock();
> >       return ret;
> >    }
> >
> > Any ideas? Kernel is 2.6.35
>
> I tried PROVE_LOCKING but now my kernel doesn't boot at all :)
>
> Something goes very wrong in arch/powerpc/kernel/prom.c:694
> 694      memblock_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
>
> (gdb) print klimit
> $8 = 0xc08c9000
>
> What is klimit and can I do something about it?
>
> kernel 2.6.35 on a mpc8321

That was not quite right, turns out that early_init_devtree(*params)
points to a memory that has been zeroed:
print initial_boot_params
$3 = (struct boot_param_header *) 0xc07fa000

Above matches what u-boot writes:
Booting kernel from Legacy Image at 00200000 ...
   Image Name:   oskernel02a:p1a:99
   Created:      2010-11-08  18:09:28 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1898430 Bytes =  1.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 07fdebb0
   Booting using the fdt blob at 0x7fdebb0
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 007fa000, end 007ff327 ... OK

(gdb) print *initial_boot_params
$4 = {magic = 0x0, totalsize = 0x0, off_dt_struct = 0x0, off_dt_strings = 0x0,
  off_mem_rsvmap = 0x0, version = 0x0, last_comp_version = 0x0,
  boot_cpuid_phys = 0x0, dt_strings_size = 0x0, dt_struct_size = 0x0}

 Jocke
