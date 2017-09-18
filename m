Return-Path: <tony.luck@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwtvy13GyzDqr8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 03:55:41 +1000 (AEST)
Date: Mon, 18 Sep 2017 10:44:32 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "James E . J . Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] [RFC] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
Message-ID: <20170918174432.4fksyzco2g6gczwe@intel.com>
References: <20170916035347.19705-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170916035347.19705-1-sergey.senozhatsky@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 16, 2017 at 12:53:42PM +0900, Sergey Senozhatsky wrote:
> 	Hello
> 
> 	RFC
> 
> 	On some arches C function pointers are indirect and point to
> a function descriptor, which contains the actual pointer to the code.
> This mostly doesn't matter, except for cases when people want to print
> out function pointers in symbolic format, because the usual '%pS/%ps'
> does not work on those arches as expected. That's the reason why we
> have '%pF/%pf', but since it's here because of a subtle ABI detail
> specific to some arches (ppc64/ia64/parisc64) it's easy to misuse
> '%pF/%pf' and '%pS/%ps' (see [1], for example).

A few new warnings when building on ia64:

arch/ia64/kernel/module.c:931: warning: passing argument 1 of 'dereference_function_descriptor' makes pointer from integer without a cast
arch/ia64/kernel/module.c:931: warning: return makes integer from pointer without a cast
kernel/kallsyms.c:325: warning: assignment makes integer from pointer without a cast
kernel/kallsyms.c:325: warning: passing argument 1 of 'dereference_kernel_function_descriptor' makes pointer from integer without a cast

Tried out the module case with a simple Hello-world test case.
This code:

char buf[1];

int init_module(void)
{
	printk(KERN_INFO "Hello world 1.\n");

	printk("using %%p  my init_module is at %p\n", init_module);
	printk("using %%pF my init_module is at %pF\n", init_module);
	printk("using %%pS my init_module is at %pS\n", init_module);

	printk("using %%p  my buf is at %p\n", buf);
	printk("using %%pF my buf is at %pF\n", buf);
	printk("using %%pS my buf is at %pS\n", buf);

	return 0;
}

Gave this console output:

Hello world 1.
using %p  my init_module is at a000000203bf0328
using %pF my init_module is at init_module+0x0/0x140 [hello_1]
using %pS my init_module is at init_module+0x0/0x140 [hello_1]
using %p  my buf is at a000000203bf0648
using %pF my buf is at buf+0x0/0xfffffffffffffb58 [hello_1]
using %pS my buf is at buf+0x0/0xfffffffffffffb58 [hello_1]


Which looks like what you wanted. People unaware of the vagaries
of ppc64/ia64/parisc64 can use the wrong %p[SF] variant, but still
get the right output.

-Tony
