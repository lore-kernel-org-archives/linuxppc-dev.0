Return-Path: <sunijsur@cisco.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BAFFAB7165
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 01:24:27 +1000 (EST)
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-4.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0DA53DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 01:24:26 +1000 (EST)
Received: from sj-core-4.cisco.com (sj-core-4.cisco.com [171.68.223.138])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n5BFDukI031830
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 08:13:56 -0700
Received: from sj-webmail-9.cisco.com (sj-webmail-9.cisco.com [171.71.183.158])
	by sj-core-4.cisco.com (8.13.8/8.13.8) with ESMTP id n5BFDusL004748
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 15:13:56 GMT
Received: from sj-webmail-9.cisco.com (localhost.localdomain [127.0.0.1])
	by sj-webmail-9.cisco.com (8.13.1/8.13.1) with ESMTP id n5BFDuJw015688
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 08:13:56 -0700
Received: from sj-webmail-9 (root@localhost)
	by sj-webmail-9.cisco.com (8.13.1/8.13.1/Submit) with ESMTP id
	n5BFDtmt015687
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 08:13:56 -0700
Date: Thu, 11 Jun 2009 08:13:54 -0700
From: Subodh Nijsure <sunijsur@cisco.com>
To: <linuxppc-dev@ozlabs.org>
Message-ID: <008701c9eaa7$3c8336c0$8dde520a@cisco.com>
Subject: System clock systems to be twice as fast as RTC
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



I am running system with kernel 2.6.10 with following cpuinfo

sh-2.05b# cat /proc/cpuinfo
processor       : 0
cpu             : 440 in Virtex-5 FXT
clock           : 200MHz
revision        : 25.18 (pvr 7ff2 1912)
bogomips        : 296.96
machine         : Xilinx ML507 PPC440 evaluation board
plb bus clock   : 100MHz

The system clock seems to be running twice as as fast as RTC, 

sh-2.05b# date ; sleep 60 ; date
Fri Sep 11 01:37:11 UTC 1970
Fri Sep 11 01:37:41 UTC 1970
sh-2.05b# date ; sleep 60 ; date
Fri Sep 11 01:38:21 UTC 1970
Fri Sep 11 01:38:51 UTC 1970
sh-2.05b# date ; sleep 60 ; date
Fri Sep 11 01:38:59 UTC 1970
Fri Sep 11 01:39:29 UTC 1970

I have tried various values of CONFIG_HZ and that didn't help. Google
searches has shown up this issue on X86 system but not on PPC. Any hints as
to what I should be looking for? I have included relevant portion of config
file..


/Subodh



CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_ASM_SEMAPHORES=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SEMMNI=128
CONFIG_SYSVIPC_SEMMSL=250
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_LTT_MAX_HANDLES=128
CONFIG_LOCKLESS=y
CONFIG_BOOT_FLIGHT_BUFFERS=4
CONFIG_BOOT_FLIGHT_SIZE=524288
CONFIG_FLIGHT_PROC_BUFFERS=8
CONFIG_FLIGHT_PROC_SIZE=8192
CONFIG_NEWEV=y
CONFIG_CSTM=y
CONFIG_CREATE_DEV_CONSOLE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_44x=y
CONFIG_BOOKE=y
CONFIG_PTE_64BIT=y
CONFIG_PHYS_64BIT=y
CONFIG_MATH_EMULATION=y
CONFIG_4xx=y
CONFIG_XILINX_ML507=y
CONFIG_XILINX_OCP=y
CONFIG_XILINX_VIRTEX_5_FX=y
CONFIG_XILINX_VIRTEX=y
CONFIG_EMBEDDEDBOOT=y
CONFIG_PPC_GEN550=y
CONFIG_UART0_TTYS0=y
CONFIG_NOT_COHERENT_CACHE=y
CONFIG_PREEMPT_DESKTOP=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_BINFMT_ELF=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttyS0,9600n8 initrd=0x1800000,32M rw root=/dev/ram
ip=$(ipaddr)::(gatewayip):$(subnetmask)::eth0:none eth=$(ethaddr)"
<snip>
