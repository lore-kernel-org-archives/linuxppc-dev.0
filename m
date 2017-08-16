Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTF93SJXzDrJp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:29:49 +1000 (AEST)
In-Reply-To: <20170802182538.26526-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/xmon: Exclude all of xmon/ from ftrace
Message-Id: <3xXTF92F6kz9t5T@ozlabs.org>
Date: Wed, 16 Aug 2017 22:29:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-02 at 18:25:38 UTC, "Naveen N. Rao" wrote:
> Exclude core xmon files from ftrace (along with an xmon xive helper
> outside of xmon/) to minimize impact of ftrace while within xmon.
> 
> Before patch:
>   root@ubuntu:/sys/kernel/debug/tracing# cat available_filter_functions | grep -i xmon
>   xmon_xive_do_dump
>   xmon_dbgfs_get
>   xmon_print_symbol
>   xmon_show_stack
>   xmon_dbgfs_ops_open
>   xmon_init.part.2
>   xmon_dbgfs_set
>   sysrq_handle_xmon
>   xmon_fault_handler
>   cpus_are_in_xmon
>   xmon_core
>   xmon
>   xmon_irq
>   xmon_break_match
>   xmon_iabr_match
>   xmon_sstep
>   xmon_bpt
>   xmon_ipi
>   xmon_write
>   xmon_start_pagination
>   xmon_end_pagination
>   xmon_set_pagination_lpp
>   xmon_putchar
>   xmon_gets
>   xmon_printf
>   xmon_puts
>   root@ubuntu:/sys/kernel/debug/tracing#
> 
> After patch:
>   root@ubuntu:/sys/kernel/debug/tracing# cat available_filter_functions | grep -i xmon
>   root@ubuntu:/sys/kernel/debug/tracing#
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e12d94f80614475b07d046eb095e6b

cheers
