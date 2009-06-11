Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 03926B715F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 07:41:25 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 58E2EDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 07:41:23 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so811272ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 14:41:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <008701c9eaa7$3c8336c0$8dde520a@cisco.com>
References: <008701c9eaa7$3c8336c0$8dde520a@cisco.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Jun 2009 15:41:02 -0600
Message-ID: <fa686aa40906111441n3d4afd48w334b7c0937c000da@mail.gmail.com>
Subject: Re: System clock systems to be twice as fast as RTC
To: Subodh Nijsure <sunijsur@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2009 at 9:13 AM, Subodh Nijsure<sunijsur@cisco.com> wrote:
>
>
> I am running system with kernel 2.6.10 with following cpuinfo

Wow, that's an old kernel version.  2.6.10 was released in 2004.  Can
you move up to something more recent?

g.

> sh-2.05b# cat /proc/cpuinfo
> processor =A0 =A0 =A0 : 0
> cpu =A0 =A0 =A0 =A0 =A0 =A0 : 440 in Virtex-5 FXT
> clock =A0 =A0 =A0 =A0 =A0 : 200MHz
> revision =A0 =A0 =A0 =A0: 25.18 (pvr 7ff2 1912)
> bogomips =A0 =A0 =A0 =A0: 296.96
> machine =A0 =A0 =A0 =A0 : Xilinx ML507 PPC440 evaluation board
> plb bus clock =A0 : 100MHz
>
> The system clock seems to be running twice as as fast as RTC,
>
> sh-2.05b# date ; sleep 60 ; date
> Fri Sep 11 01:37:11 UTC 1970
> Fri Sep 11 01:37:41 UTC 1970
> sh-2.05b# date ; sleep 60 ; date
> Fri Sep 11 01:38:21 UTC 1970
> Fri Sep 11 01:38:51 UTC 1970
> sh-2.05b# date ; sleep 60 ; date
> Fri Sep 11 01:38:59 UTC 1970
> Fri Sep 11 01:39:29 UTC 1970
>
> I have tried various values of CONFIG_HZ and that didn't help. Google
> searches has shown up this issue on X86 system but not on PPC. Any hints =
as
> to what I should be looking for? I have included relevant portion of conf=
ig
> file..
>
>
> /Subodh
>
>
>
> CONFIG_MMU=3Dy
> CONFIG_GENERIC_HARDIRQS=3Dy
> CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
> CONFIG_ASM_SEMAPHORES=3Dy
> CONFIG_HAVE_DEC_LOCK=3Dy
> CONFIG_PPC=3Dy
> CONFIG_PPC32=3Dy
> CONFIG_GENERIC_NVRAM=3Dy
> CONFIG_EXPERIMENTAL=3Dy
> CONFIG_CLEAN_COMPILE=3Dy
> CONFIG_BROKEN_ON_SMP=3Dy
> CONFIG_LOCK_KERNEL=3Dy
> CONFIG_LOCALVERSION=3D""
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SEMMNI=3D128
> CONFIG_SYSVIPC_SEMMSL=3D250
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_SYSCTL=3Dy
> CONFIG_LOG_BUF_SHIFT=3D14
> CONFIG_HOTPLUG=3Dy
> CONFIG_KOBJECT_UEVENT=3Dy
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> CONFIG_KALLSYMS=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_CC_ALIGN_FUNCTIONS=3D0
> CONFIG_CC_ALIGN_LABELS=3D0
> CONFIG_CC_ALIGN_LOOPS=3D0
> CONFIG_CC_ALIGN_JUMPS=3D0
> CONFIG_LTT_MAX_HANDLES=3D128
> CONFIG_LOCKLESS=3Dy
> CONFIG_BOOT_FLIGHT_BUFFERS=3D4
> CONFIG_BOOT_FLIGHT_SIZE=3D524288
> CONFIG_FLIGHT_PROC_BUFFERS=3D8
> CONFIG_FLIGHT_PROC_SIZE=3D8192
> CONFIG_NEWEV=3Dy
> CONFIG_CSTM=3Dy
> CONFIG_CREATE_DEV_CONSOLE=3Dy
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> CONFIG_MODULE_FORCE_UNLOAD=3Dy
> CONFIG_OBSOLETE_MODPARM=3Dy
> CONFIG_KMOD=3Dy
> CONFIG_44x=3Dy
> CONFIG_BOOKE=3Dy
> CONFIG_PTE_64BIT=3Dy
> CONFIG_PHYS_64BIT=3Dy
> CONFIG_MATH_EMULATION=3Dy
> CONFIG_4xx=3Dy
> CONFIG_XILINX_ML507=3Dy
> CONFIG_XILINX_OCP=3Dy
> CONFIG_XILINX_VIRTEX_5_FX=3Dy
> CONFIG_XILINX_VIRTEX=3Dy
> CONFIG_EMBEDDEDBOOT=3Dy
> CONFIG_PPC_GEN550=3Dy
> CONFIG_UART0_TTYS0=3Dy
> CONFIG_NOT_COHERENT_CACHE=3Dy
> CONFIG_PREEMPT_DESKTOP=3Dy
> CONFIG_PREEMPT=3Dy
> CONFIG_PREEMPT_BKL=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_CMDLINE_BOOL=3Dy
> CONFIG_CMDLINE=3D"console=3DttyS0,9600n8 initrd=3D0x1800000,32M rw root=
=3D/dev/ram
> ip=3D$(ipaddr)::(gatewayip):$(subnetmask)::eth0:none eth=3D$(ethaddr)"
> <snip>
>
>
>
>
>
>
>
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
