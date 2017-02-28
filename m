Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXtxF1FvbzDqJx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 09:46:57 +1100 (AEDT)
Message-ID: <1488322005.2944.12.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Cc: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
Date: Tue, 28 Feb 2017 16:46:45 -0600
In-Reply-To: <58B58F4B.1040807@nxp.com>
References: <20170216151129.8971-1-laurentiu.tudor@nxp.com>
 <87tw7tc8o9.fsf@skywalker.in.ibm.com> <58B58F4B.1040807@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc: booke: fix boot crash due to null hugepd
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-28 at 14:55 +0000, Laurentiu Tudor wrote:
> Hi,
> 
> Some more information on the crash, inline.
> 
> On 02/17/2017 02:18 PM, Aneesh Kumar K.V wrote:
> > 
> > laurentiu.tudor@nxp.com writes:
> > 
> > > 
> > > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > 
> > > On 32-bit book-e machines, hugepd_ok() does not take
> > > into account null hugepd values, causing this crash at boot:
> > > 
> > > Unable to handle kernel paging request for data at address 0x80000000
> > > Faulting instruction address: 0xc00182a8
> > > Oops: Kernel access of bad area, sig: 11 [#1]
> > > SMP NR_CPUS=24
> > > CoreNet Generic
> > > Modules linked in:
> > > CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       4.10.0-rc8-
> > > 00016-g69b1f87 #11
> > > task: e5050000 task.stack: e5058000
> > > NIP: c00182a8 LR: c001829c CTR: 00007ffe
> > > REGS: e5059c50 TRAP: 0300   Tainted: G        W        (4.10.0-rc8-
> > > 00016-g69b1f87)
> > > MSR: 00021002 <CE,ME>
> > >    CR: 88428e82  XER: 00000000
> > > DEAR: 80000000 ESR: 00000000
> > > GPR00: c0107510 e5059d00 e5050000 80000000 bffffff1 e5059d0c e5059d08
> > > 00002017
> > > GPR08: 00000000 00000000 00000000 00000000 28428e82 00000000 c00027d0
> > > 00000000
> > > GPR16: 00000000 00000000 88a28e82 20000000 48422e82 00000000 88a28e84
> > > dd004000
> > > GPR24: e5059e38 00000000 00000000 bffffff1 dd004000 00000001 00029002
> > > bffffff1
> > > NIP [c00182a8] follow_huge_addr+0x38/0xf0
> > > LR [c001829c] follow_huge_addr+0x2c/0xf0
> > > Call Trace:
> > > [e5059d00] [e5059d00] 0xe5059d00 (unreliable)
> > > [e5059d20] [c0107510] follow_page_mask+0x40/0x3c0
> > > [e5059d80] [c0107958] __get_user_pages+0xc8/0x420
> > > [e5059de0] [c010817c] get_user_pages_remote+0x8c/0x230
> > > [e5059e30] [c013f170] copy_strings+0x110/0x3a0
> > > [e5059ea0] [c013f42c] copy_strings_kernel+0x2c/0x50
> > > [e5059ec0] [c0141324] do_execveat_common+0x474/0x620
> > > [e5059f10] [c01414fc] do_execve+0x2c/0x40
> > > [e5059f20] [c0001f68] try_to_run_init_process+0x18/0x60
> > > [e5059f30] [c000289c] kernel_init+0xcc/0x120
> > > [e5059f40] [c000f1e8] ret_from_kernel_thread+0x5c/0x64
> > > Instruction dump:
> > > bfc10018 7c9f2378 90010024 7fc000a6 7c000146 80630020 38a1000c 38c10008
> > > 4bfff869 2c030000 41c20090 81210008 <81430000> 81630004 3860ffea
> > > 2f890000
> > > ---[ end trace 4bf94e15fd9fa824 ]---
> > 
> > Which code path is that. That null should be filtered by the if
> > (pmd_none(pmd)) check in find_linux_pte_or_hugepte right ?
> The crash happens when __find_linux_pte_or_hugepte() calls hugepd_ok(),
> on this line [1]. It's triggered when __find_linux_pte_or_hugepte() is
> first called, when the kernel tries to spawn the init process. The input
> effective address (ea arg) is bffffff1. This is the call stack:

What is the pmd value?  There's a pmd_none() check before that line.

That said, regardless of what's going wrong here, it would be simpler and more
robust if is_hugepd() returned false for empty ptes rather than assuming the
caller explicitly checked pmd_none().

-Scott
