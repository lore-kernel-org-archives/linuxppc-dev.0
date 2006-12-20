Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0336DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 11:54:18 +1100 (EST)
Subject: Re: Bad gcc-4.1.0 leads to Power4 crashes... and power5 too, actually
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061220004653.GL5506@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 11:53:04 +1100
Message-Id: <1166575984.19254.101.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-12-19 at 18:46 -0600, Linas Vepstas wrote:
> Hi Ben, 
> 
> Per xchat, here's the update. I'm guessing I'm using a broken
> compiler, as per chain of evidence below ... 
> 
> I noticed that linux-2.6.20-rc1-git6 crashes on power4
> in SMP mode:

Have you tried a different gcc to confirm ?

Ben.

> [    0.000000] [boot]0020 XICS Init
> [    0.000000] i8259 legacy interrupt controller initialized
> [    0.000000] [boot]0021 XICS Done
> [    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
> cpu 0x0: Vector: 700 (Program Check) at [c0000000007a3980]
>     pc: c00000000007d574: .debug_mutex_unlock+0x5c/0x118
>     lr: c000000000468068: .__mutex_unlock_slowpath+0x104/0x198
>     sp: c0000000007a3c00
>    msr: 9000000000029032
>   current = 0xc000000000663690
>   paca    = 0xc000000000663f80
>     pid   = 0, comm = swapper
> enter ? for help
> [c0000000007a3c80] c000000000468068 .__mutex_unlock_slowpath+0x104/0x198
> [c0000000007a3d20] c000000000231da8 .double_unlock_mutex+0x3c/0x58
> [c0000000007a3db0] c00000000023b47c .dotest+0x5c/0x370
> [c0000000007a3e50] c00000000023bc0c .locking_selftest+0x47c/0x17fc
> [c0000000007a3ef0] c0000000005f06ec .start_kernel+0x1e4/0x344
> [c0000000007a3f90] c0000000000084c8 .start_here_common+0x54/0x8c
> 0:mon>
> 
> 
> However, I also note that the following scrolled by:
> init/main.c:81:2: warning: #warning gcc-4.1.0 is known to miscompile the
> kernel. A different compiler version is recommended.
> 
> and I have not yet tried a different gcc
> 
> Strangely, linux-2.6.19-git7 crashed with 
> 
> [    0.000000] [boot]0020 XICS Init
> [    0.000000] i8259 legacy interrupt controller initialized
> [    0.000000] [boot]0021 XICS Done
> [    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
> System assert at:  file: rtas_io_config.c  -- line: 195
> rio_hub_num: 10
> drawer_num: 6
> phb_num: 3
> buid: 7
> 
> which is suspiciously in a similar place. So I am guessing 
> that it is indeed a compiler problem, the compiler passing
> subroutine arguments in some broken way, or something.
> 
> Hmm. seems that linux-2.6.20-rc1-git6 on power5 gives me
> 
> [23178.532001]              A-B-B-C-C-A deadlock:failed|failed|  ok
> |failed|fa|[23178.532028]              A-B-C-A-B-C
> deadlock:failed|failed|  ok  |failed|fa|[23178.532054]
> A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|fa|[23178.532083]
> A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|fa|[23178.532111]
> A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|fa|[23178.532139]
> double unlock:  ok  |  ok  |failed|<0>-------[23178.532171] Kernel BUG
> at c00000000007d574 [verbose debug info unavailable]
> cpu 0x0: Vector: 700 (Program Check) at [c0000000007a3980]
>     pc: c00000000007d574: .debug_mutex_unlock+0x5c/0x118
>     lr: c000000000468068: .__mutex_unlock_slowpath+0x104/0x198
>     sp: c0000000007a3c00
>    msr: 8000000000029032
>   current = 0xc000000000663690
>   paca    = 0xc000000000663f80
>     pid   = 0, comm = swapper
> enter ? for help
> [c0000000007a3c80] c000000000468068 .__mutex_unlock_slowpath+0x104/0x198
> [c0000000007a3d20] c000000000231da8 .double_unlock_mutex+0x3c/0x58
> [c0000000007a3db0] c00000000023b47c .dotest+0x5c/0x370
> [c0000000007a3e50] c00000000023bc0c .locking_selftest+0x47c/0x17fc
> [c0000000007a3ef0] c0000000005f06ec .start_kernel+0x1e4/0x344
> [c0000000007a3f90] c0000000000084c8 .start_here_common+0x54/0x8c
> 
> although linux-2.6.19-git7 worked fine for weeks.
> 
> At any rate, the warning: #warning gcc-4.1.0 should be converted
> to a flat-out error. 
> 
> --linas
> 
> 
> 
