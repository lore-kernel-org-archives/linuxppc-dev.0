Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 71596DDE2F
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 14:45:39 +1000 (EST)
Date: Fri, 13 Apr 2007 23:45:30 -0500
From: Nathan Lynch <ntl@pobox.com>
To: David Huffman <dhuffman@storix.com>
Subject: Re: Kernel Panic booting cdrom
Message-ID: <20070414044529.GE6062@localdomain>
References: <46202254.1090606@storix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46202254.1090606@storix.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David-

David Huffman wrote:
> I created a cdrom (using the same procedure that has been working for 
> years), and received a kernel panic when booting a linux system on a 
> System i p5 lpar. Here is a section of the boot messages, plus I added 
> the output of .registers from OF. Anyone have an idea what could be the 
> cause?

> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=128 NUMA PSERIES LPAR
> NIP: C00000000012F210 XER: 0000000020000010 LR: C000000000476024
> REGS: c00000007ff5fab0 TRAP: 0380   Not tainted  (2.6.5-7.244-pseries64 
> SLES9_SP3_BRANCH-200512121832250000)
> MSR: 8000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 0000000000000010, DSISR: 0000000000200000
> TASK: c00000007ff5b440[1] 'swapper' THREAD: c00000007ff5c000 CPU: 0
> GPR00: C000000000476024 C00000007FF5FD30 C00000000071DCC8 C000000000723338
> GPR04: C0000000028CC080 C0000000028CC088 C000000000954C98 C000000002692888
> GPR08: 0000000000000002 0000000000000001 C000000000643160 0000000000000001
> GPR12: 0000000024000042 C000000000491000 0000000000000000 0000000000000000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: 0000000000000000 0000000000000010 00000000001BB591 0000000001C00000
> GPR24: C000000000491000 C00000000071D008 C00000000048B5F0 C0000000028CC080
> GPR28: 0000000000000000 C000000000723338 C0000000006316D0 C0000000028CC088
> NIP [c00000000012f210] .sysfs_create_link+0x30/0x134
> LR [c000000000476024] .register_cpu+0xc8/0x104
> Call Trace:
> [c00000007ff5fd30] [c0000000002753cc] .sysdev_register+0x98/0x250 
> (unreliable)
> [c00000007ff5fdd0] [c000000000476024] .register_cpu+0xc8/0x104
> [c00000007ff5fe70] [c0000000004621dc] .topology_init+0x1b4/0x290
> [c00000007ff5ff00] [c00000000000c654] .init+0x1a0/0x360
> [c00000007ff5ff90] [c000000000017d24] .kernel_thread+0x4c/0x68
>  <0>Fatal exception: panic in 5 seconds


>From the full version at http://www.storix.com/p5panic.txt:

Linux version 2.6.5-7.244-pseries64 (geeko@buildhost) (gcc version 3.3.3 (SuSE Linux)) #1 SMP Mon Dec 12 18:32:25 UTC 2005
[boot]0012 Setup Arch
NUMA associativity depth for CPU/Memory: 3
cpu 0 maps to domain 5
cpu 1 maps to domain 5
memory region 0 to 8000000 maps to domain 5
memory region 8000000 to 9000000 maps to domain 5
memory region 9000000 to a000000 maps to domain 5
....

Could you see whether adding numa=off on the kernel command line
helps?

I think it's crashing because kernels this old assume that numa node
numbering as given by firmware begins with 0.  This partition has a
single node numbered 5.
