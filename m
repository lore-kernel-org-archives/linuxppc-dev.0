Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xx5nR1m6LzDqF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 12:05:45 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u18so1093232pgo.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 19:05:45 -0700 (PDT)
Date: Tue, 19 Sep 2017 11:05:38 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 "Luck, Tony" <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "James E . J . Bottomley" <jejb@parisc-linux.org>,
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] [RFC] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
Message-ID: <20170919020537.GA16991@jagdpanzerIV.localdomain>
References: <20170916035347.19705-1-sergey.senozhatsky@gmail.com>
 <20170918174432.4fksyzco2g6gczwe@intel.com>
 <20170918183902.GA30752@p100.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170918183902.GA30752@p100.box>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (09/18/17 20:39), Helge Deller wrote:
[..]
> > A few new warnings when building on ia64:
> > 
> > arch/ia64/kernel/module.c:931: warning: passing argument 1 of 'dereference_function_descriptor' makes pointer from integer without a cast
> > arch/ia64/kernel/module.c:931: warning: return makes integer from pointer without a cast
> > kernel/kallsyms.c:325: warning: assignment makes integer from pointer without a cast
> > kernel/kallsyms.c:325: warning: passing argument 1 of 'dereference_kernel_function_descriptor' makes pointer from integer without a cast
> 
> 
> I got similiar warnings on parisc.
> This patch on top of yours fixed those:
> 

Tony, Helge,

thanks for the reports!

I'll simply convert everything to `unsigned long'. including the
dereference_function_descriptor() function [I believe there are
still some casts happening when we pass addr from kernel/module
dereference functions to dereference_function_descriptor(), or
when we return `void *' back to symbol resolution code, etc.)
besides, it seems that everything that uses
dereference_function_descriptor() wants `unsigned long' anyway:

drivers/misc/kgdbts.c:  addr = (unsigned long) dereference_function_descriptor((void *)addr);
init/main.c:    addr = (unsigned long) dereference_function_descriptor(fn);
kernel/extable.c:       addr = (unsigned long) dereference_function_descriptor(ptr);
kernel/module.c:        unsigned long a = (unsigned long)dereference_function_descriptor(addr);

so I'll just switch it to ulong.


> I did tried your testcases too.
> 
> "echo 1 > /proc/sys/vm/drop_caches" gave correct output:
>  printk#1 schedule_timeout+0x0/0x4a8
>  printk#2 schedule_timeout+0x0/0x4a8
>  printk#3 proc_sys_call_handler+0x120/0x180
>  printk#4 proc_sys_call_handler+0x120/0x180
>  printk#5 proc_sys_call_handler+0x120/0x180
>  printk#6 proc_sys_call_handler+0x120/0x180
> 
> and here is "modprobe zram":
>  printk#7 __UNIQUE_ID_vermagic8+0xb9a4/0xbd04 [zram]
>  printk#8 __UNIQUE_ID_vermagic8+0xb9a4/0xbd04 [zram]
>  printk#9 do_one_initcall+0x194/0x290
>  printk#10 do_one_initcall+0x194/0x290
>  printk#11 do_one_initcall+0x194/0x290
>  printk#12 do_one_initcall+0x194/0x290
>  printk#13 zram_init+0x22c/0x2a0 [zram]
>  printk#14 zram_init+0x22c/0x2a0 [zram]
>  printk#15 zram_init+0x22c/0x2a0 [zram]
>  printk#16 zram_init+0x22c/0x2a0 [zram]
> 
> I wonder why printk#7 and printk#8 don't show "zram_init"...

interesting... what does the unpatched kernel show?


> Regarding your patches:
> 
> In arch/parisc/kernel/process.c:
> +void *dereference_kernel_function_descriptor(void *ptr)
> +{
> +       if (ptr < (void *)__start_opd || (void *)__end_opd < ptr)
> 
> This needs to be (__end_opd is outside):
> +       if (ptr < (void *)__start_opd || (void *)__end_opd <= ptr)
> 
> The same is true for the checks in the other arches.

um... yeah. __end_opd is definitely not a valid place for a descriptor!
I think I had `if (!(ptr >= __start_opd && ptr < __end_opd))' which I
wrongly converted. "shame, shame, shame".

thanks!


> I'd suggest to move the various
> 	extern char __start_opd[], __end_opd[];
> out of arch/<arch>/include/asm/sections.h and into <asm-generic/sections.h>

ok, will take a look.

	-ss
