Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com
 [IPv6:2607:f8b0:400e:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23C771A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 17:03:35 +1100 (AEDT)
Received: by mail-pf0-x22e.google.com with SMTP id e127so24282811pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 22:03:35 -0800 (PST)
Message-ID: <1455170608.2885.5.camel@gmail.com>
Subject: Re: Fix kgdb on little endian ppc64le
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: kgdb-bugreport@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 11 Feb 2016 17:03:28 +1100
In-Reply-To: <20160209101159.C3BB4140B00@ozlabs.org>
References: <20160209101159.C3BB4140B00@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-09 at 21:11 +1100, Michael Ellerman wrote:
> On Mon, 2016-01-02 at 06:03:25 UTC, Balbir Singh wrote:
> > From: Balbir Singh <bsingharora@gmail.com>
> > 
> > I spent some time trying to use kgdb and debugged my inability to
> > resume from kgdb_handle_breakpoint(). NIP is not incremented
> > and that leads to a loop in the debugger.
> > 
> > I've tested this lightly on a virtual instance with KDB enabled.
> > After the patch, I am able to get the "go" command to work as
> > expected
> 
> The test suite isn't working for me (I think?), so I think maybe we need
> something more?
> 
> 
>   KGDB: Registered I/O driver kgdbts
>   kgdbts:RUN plant and detach test
> 
>   Entering kdb (current=0xc0000001fefc0000, pid 1) on processor 12 due to
> Keyboard Entry
>   [12]kdb> kgdbts:RUN sw breakpoint test
>   kgdbts: BP mismatch c00000000018e2cc expected c00000000061c510
>   KGDB: re-enter exception: ALL breakpoints killed
>   CPU: 12 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc3-00006-g893791ee8b01 #5
>   Call Trace:
>   [c0000001fb082e10] [c0000000009c4608] dump_stack+0xb0/0xf0 (unreliable)
>   [c0000001fb082e50] [c00000000018fa8c] kgdb_handle_exception+0x2ac/0x2c0
>   [c0000001fb082f20] [c0000000000405f4] kgdb_handle_breakpoint+0x64/0xa0
>   [c0000001fb082f50] [c0000000009bcee4] program_check_exception+0x144/0x370
>   [c0000001fb082fc0] [c000000000006244] program_check_common+0x144/0x180
>   --- interrupt: 700 at check_and_rewind_pc+0x100/0x130
>       LR = check_and_rewind_pc+0xfc/0x130
>   [c0000001fb083340] [c00000000061bfc0] validate_simple_test+0x60/0x170
>   [c0000001fb083370] [c00000000061c784] run_simple_test+0x194/0x3c0
>   [c0000001fb0833f0] [c00000000061c17c] kgdbts_put_char+0x4c/0x70
>   [c0000001fb083420] [c0000000001902e0] put_packet+0x130/0x210
>   [c0000001fb083470] [c000000000191338] gdb_serial_stub+0x478/0x1110
>   [c0000001fb083560] [c00000000018f19c] kgdb_cpu_enter+0x3fc/0x800
>   [c0000001fb083660] [c00000000018f970] kgdb_handle_exception+0x190/0x2c0
>   [c0000001fb083730] [c0000000000405f4] kgdb_handle_breakpoint+0x64/0xa0
>   [c0000001fb083760] [c0000000009bcee4] program_check_exception+0x144/0x370
>   [c0000001fb0837d0] [c000000000006244] program_check_common+0x144/0x180
>   --- interrupt: 700 at kgdb_breakpoint+0x3c/0x70
>       LR = run_breakpoint_test+0xa4/0x120
>   [c0000001fb083ac0] [0000000000000000]           (null) (unreliable)
>   [c0000001fb083ae0] [c00000000061d714] run_breakpoint_test+0xa4/0x120
>   [c0000001fb083b50] [c00000000061dcb4] configure_kgdbts+0x2c4/0x6e0
>   [c0000001fb083c30] [c00000000000b3d0] do_one_initcall+0xd0/0x250
>   [c0000001fb083d00] [c000000000cc42f8] kernel_init_freeable+0x270/0x350
>   [c0000001fb083dc0] [c00000000000bd3c] kernel_init+0x2c/0x150
>   [c0000001fb083e30] [c0000000000095b0] ret_from_kernel_thread+0x5c/0xac
>   Kernel panic - not syncing: Recursive entry to debugger
>   CPU: 12 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc3-00006-g893791ee8b01 #5
>   Call Trace:
>   [c0000001fb082d70] [c0000000009c4608] dump_stack+0xb0/0xf0 (unreliable)
>   [c0000001fb082db0] [c0000000009c2edc] panic+0x138/0x300
>   [c0000001fb082e50] [c00000000018fa9c] kgdb_handle_exception+0x2bc/0x2c0
>   [c0000001fb082f20] [c0000000000405f4] kgdb_handle_breakpoint+0x64/0xa0
>   [c0000001fb082f50] [c0000000009bcee4] program_check_exception+0x144/0x370
>   [c0000001fb082fc0] [c000000000006244] program_check_common+0x144/0x180
>   --- interrupt: 700 at check_and_rewind_pc+0x100/0x130
>       LR = check_and_rewind_pc+0xfc/0x130
>   [c0000001fb083340] [c00000000061bfc0] validate_simple_test+0x60/0x170
>   [c0000001fb083370] [c00000000061c784] run_simple_test+0x194/0x3c0
>   [c0000001fb0833f0] [c00000000061c17c] kgdbts_put_char+0x4c/0x70
>   [c0000001fb083420] [c0000000001902e0] put_packet+0x130/0x210
>   [c0000001fb083470] [c000000000191338] gdb_serial_stub+0x478/0x1110
>   [c0000001fb083560] [c00000000018f19c] kgdb_cpu_enter+0x3fc/0x800
>   [c0000001fb083660] [c00000000018f970] kgdb_handle_exception+0x190/0x2c0
>   [c0000001fb083730] [c0000000000405f4] kgdb_handle_breakpoint+0x64/0xa0
>   [c0000001fb083760] [c0000000009bcee4] program_check_exception+0x144/0x370
>   [c0000001fb0837d0] [c000000000006244] program_check_common+0x144/0x180
>   --- interrupt: 700 at kgdb_breakpoint+0x3c/0x70
>       LR = run_breakpoint_test+0xa4/0x120
>   [c0000001fb083ac0] [0000000000000000]           (null) (unreliable)
>   [c0000001fb083ae0] [c00000000061d714] run_breakpoint_test+0xa4/0x120
>   [c0000001fb083b50] [c00000000061dcb4] configure_kgdbts+0x2c4/0x6e0
>   [c0000001fb083c30] [c00000000000b3d0] do_one_initcall+0xd0/0x250
>   [c0000001fb083d00] [c000000000cc42f8] kernel_init_freeable+0x270/0x350
>   [c0000001fb083dc0] [c00000000000bd3c] kernel_init+0x2c/0x150
>   [c0000001fb083e30] [c0000000000095b0] ret_from_kernel_thread+0x5c/0xac
>   Rebooting in 10 seconds..
> 
I tried the tests with and without my changes and they both fail. I suspect its
broken on ppc64le on which I am testing. The tests require more work to fix.
I'll see if I can find some time to work on them. This patch is independent of
the current breakage

Thanks for testing the patch.

Balbir Singh
