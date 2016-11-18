Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKxWT2d9lzDvx6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 23:04:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND PATCH] cxl: Fix coredump generation when cxl_get_fd() is
 used
In-Reply-To: <20161114085854.19667-1-fbarrat@linux.vnet.ibm.com>
References: <20161114085854.19667-1-fbarrat@linux.vnet.ibm.com>
Date: Fri, 18 Nov 2016 23:04:51 +1100
Message-ID: <8760nlgfj0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> If a process dumps core while owning a cxl file descriptor obtained
> from an AFU driver (e.g. cxlflash) through the cxl_get_fd() API, the
> following error occurs:
>
> [  868.027591] Unable to handle kernel paging request for data at address ...
> [  868.027778] Faulting instruction address: 0xc00000000035edb0
> cpu 0x8c: Vector: 300 (Data Access) at [c000003c688275e0]
>     pc: c00000000035edb0: elf_core_dump+0xd60/0x1300
>     lr: c00000000035ed80: elf_core_dump+0xd30/0x1300
>     sp: c000003c68827860
>    msr: 9000000100009033
>    dar: c
> dsisr: 40000000
>  current = 0xc000003c68780000
>  paca    = 0xc000000001b73200   softe: 0        irq_happened: 0x01
>     pid   = 46725, comm = hxesurelock
> enter ? for help
> [c000003c68827a60] c00000000036948c do_coredump+0xcec/0x11e0
> [c000003c68827c20] c0000000000ce9e0 get_signal+0x540/0x7b0
> [c000003c68827d10] c000000000017354 do_signal+0x54/0x2b0
> [c000003c68827e00] c00000000001777c do_notify_resume+0xbc/0xd0
> [c000003c68827e30] c000000000009838 ret_from_except_lite+0x64/0x68
> --- Exception: 300 (Data Access) at 00003fff98ad2918

Just FYI, the triple "---" is the "end of change log" marker. It took me
a while to work out why whenever I applied this I only got half the
change log and no sign offs :D

Personally I like to indent oopses anyway, which also avoids that
problem.

cheers
