Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZgGq01HnzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 19:07:14 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 30 Mar 2016 18:07:13 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E4F303578058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 19:06:59 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2U86eup47251710
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 19:06:54 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2U85dYm006725
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 19:05:39 +1100
Date: Wed, 30 Mar 2016 13:34:59 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
Message-ID: <20160330080459.GB21299@naverao1-tp.in.ibm.com>
References: <3qWbvb0yVwz9sdm@ozlabs.org>
 <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1459222294.8173.8.camel@ellerman.id.au>
 <3337968.FTL1d9fOmu@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3337968.FTL1d9fOmu@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/03/29 08:35PM, Thiago Jung Bauermann wrote:
> Am Dienstag, 29 März 2016, 14:31:34 schrieb Michael Ellerman:
> > On Mon, 2016-03-28 at 17:06 -0300, Thiago Jung Bauermann wrote:
> > > With this patch, all vmlinux symbols match /proc/kallsyms and the
> > > testcase passes.
> > 
> > Have you tested this on an LE system?
> 
> No, I was focusing on ppc64 BE.

Which kernel did you use? I don't see this with the latest 4.6.0-rc1.

> 
> > I did a quick test and it appears to
> > be completely broken. Basically every symbol is not found, eg:
> > 
> >  1: vmlinux symtab matches kallsyms                          :
> > --- start ---
> > test child forked, pid 16222
> > Using /proc/kcore for kernel object code
> > Looking at the vmlinux_path (8 entries long)
> > Using /boot/vmlinux-4.5.0-11318-gdf01bc5cf4ea for symbols
> > 0xc00000000000b428: run_init_process not on kallsyms
> > 0xc00000000000b478: try_to_run_init_process not on kallsyms
> > 0xc00000000000b4f8: do_one_initcall not on kallsyms
> > 0xc00000000000b768: match_dev_by_uuid not on kallsyms
> > ...
> > 0xc0000000009846b8: write_mem not on kallsyms
> > 0xc000000000984728: do_fp_store not on kallsyms
> > 0xc000000000984828: emulate_step not on kallsyms
> > 
> > $ sudo grep emulate_step /proc/kallsyms
> > c000000000984820 T emulate_step
> > 
> > 
> > Notice it's off by 8. That's because of the local/global entry point on
> > LE. So that will need to be fixed somewhere.
> 
> Symbols loaded from the vmlinux file get adjusted to the local entry point 
> because symbol-elf.c:dso__load_sym calls arch__elf_sym_adjust for each 
> function symbol, which on ppc64le adjusts the address to the local entry 
> point. On the other hand, when symbols are loaded from /proc/kallsyms 
> they are used as-is (i.e., with the global entry point address).
> 
> This seems inconsistent: dso__load_kernel_sym can end up loading symbols 
> from either vmlinux or /proc/kallsyms, so it seems symbols should look the 
> same wherever they are loaded from. I am still trying to understand what the 
> rest of the perf code expects.

The LEP is used since probing on that catches calls to both the GEP and 
the LEP. I did fix 'perf probe' to fixup the kallsyms address as well.  
See commit 7b6ff0bdb.

> 
> If I comment out the call to arch__elf_sym_adjust in dso__load_sym, then all 
> symbols are found in the vmlinux-kallsyms.c test (the test still fails 
> because two symbols have different names. I haven’t checked why). Also, the 
> code-reading.c test is able to read object code for a lot (but not all) of 
> the sample events, whereas in the adjusted symbols case it can’t read object 
> code for any sample event. The other perf tests are unaffected by the 
> change.
> 
> I thought that if there’s no vmlinux available, then perf would have to rely 
> only on /proc/kallsyms and I would see some difference in the test results 
> compared to when perf uses vmlinux and adjusts the symbols to the local 
> entry point, but I saw no difference at all.
> 
> So at first glance, it looks like perf is better off using symbols that 
> point to the global entry point...

See above - we need to use the LEP. I suspect we don't fixup all the 
symbols in kallsyms -- just the ones being probed which explains why 
there is a mismatch. Let me take a look.


- Naveen
