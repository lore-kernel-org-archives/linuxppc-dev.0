Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqqj6XdyzDqgb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:22:41 +1000 (AEST)
In-Reply-To: <20170613184200.22541-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Shriya R . Kulkarni" <shriykul@in.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: powerpc64/hw_breakpoints: Handle data breakpoints in radix mode
Message-Id: <3wrqqj5yr8z9s8V@ozlabs.org>
Date: Mon, 19 Jun 2017 22:22:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-13 at 18:42:00 UTC, "Naveen N. Rao" wrote:
> On P9, trying to use data breakpoints throws the splat shown below (*).
> This is because the check for a data breakpoint in DSISR is in
> do_hash_page(). Move this check to handle_page_fault() so as to catch
> data breakpoints in both hash and radix MMU modes.
> 
> While at it, also remove the label '11' that was made redundant by
> commit a546498f3bf9aa ("powerpc: Call do_page_fault() with interrupts
> off")
> 
> (*)
>     Unable to handle kernel paging request for data at address 0xc000000000e19218
>     Faulting instruction address: 0xc0000000001155e8
>     cpu 0x0: Vector: 300 (Data Access) at [c0000000ef1e7b20]
>     pc: c0000000001155e8: find_pid_ns+0x48/0xe0
>     lr: c000000000116ac4: find_task_by_vpid+0x44/0x90
>     sp: c0000000ef1e7da0
>     msr: 9000000000009033
>     dar: c000000000e19218
>     dsisr: 400000
>     current = 0xc0000000f1f59700
>     paca    = 0xc00000000fd40000 softe: 0 irq_happened: 0x01
>     pid   = 1192, comm = sh
>     Linux version 4.12.0-rc3-nnr (root@ea605ec2993c) (gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) ) #74 SMP Tue Jun 13 16:52:49 UTC 2017
>     enter ? for help
>     [c0000000ef1e7dc0] c000000000116ac4 find_task_by_vpid+0x44/0x90
>     [c0000000ef1e7de0] c000000000108800 SyS_setpgid+0x80/0x220
>     [c0000000ef1e7e30] c00000000000ba6c system_call+0x38/0xfc
>     --- Exception: c01 (System Call) at 00007fff94480890
>     SP (7fffd91e7260) is in userspace
> 
> Fixes: caca285e5ab4a ("powerpc/mm/radix: Use STD_MMU_64 to properly
> isolate hash related code")
> Reported-by: Shriya R. Kulkarni <shriykul@in.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d89ba5353f301971dd7d2f9fdf25c4

cheers
