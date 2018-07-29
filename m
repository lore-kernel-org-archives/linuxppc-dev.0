Return-Path: <srs0=humg=kn=molgen.mpg.de=pmenzel@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41dkV75djBzF12F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 23:45:19 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41dkV748QYz8vrn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 23:45:19 +1000 (AEST)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41dkV62RrVz9s0R
 for <linuxppc-dev@ozlabs.org>; Sun, 29 Jul 2018 23:45:17 +1000 (AEST)
Subject: Re: [PATCH] powerpc/mm: Don't report PUDs as memory leaks when using
 kmemleak
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
References: <20180719143316.23486-1-mpe@ellerman.id.au>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <e653db46-a829-4673-4378-4c0afef03cde@molgen.mpg.de>
Date: Sun, 29 Jul 2018 15:35:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180719143316.23486-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Michael,


Am 19.07.2018 um 16:33 schrieb Michael Ellerman:
> Paul Menzel reported that kmemleak was producing reports such as:
> 
>    unreferenced object 0xc0000000f8b80000 (size 16384):
>      comm "init", pid 1, jiffies 4294937416 (age 312.240s)
>      hex dump (first 32 bytes):
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      backtrace:
>        [<00000000d997deb7>] __pud_alloc+0x80/0x190
>        [<0000000087f2e8a3>] move_page_tables+0xbac/0xdc0
>        [<00000000091e51c2>] shift_arg_pages+0xc0/0x210
>        [<00000000ab88670c>] setup_arg_pages+0x22c/0x2a0
>        [<0000000060871529>] load_elf_binary+0x41c/0x1648
>        [<00000000ecd9d2d4>] search_binary_handler.part.11+0xbc/0x280
>        [<0000000034e0cdd7>] __do_execve_file.isra.13+0x73c/0x940
>        [<000000005f953a6e>] sys_execve+0x58/0x70
>        [<000000009700a858>] system_call+0x5c/0x70
> 
> Indicating that a PUD was being leaked.
> 
> However what's really happening is that kmemleak is not able to
> recognise the references from the PGD to the PUD, because they are not
> fully qualified pointers.
> 
> We can confirm that in xmon, eg:
> 
> Find the task struct for pid 1 "init":
>    0:mon> P
>         task_struct     ->thread.ksp    PID   PPID S  P CMD
>    c0000001fe7c0000 c0000001fe803960      1      0 S 13 systemd
> 
> Dump virtual address 0 to find the PGD:
>    0:mon> dv 0 c0000001fe7c0000
>    pgd  @ 0xc0000000f8b01000
> 
> Dump the memory of the PGD:
>    0:mon> d c0000000f8b01000
>    c0000000f8b01000 00000000f8b90000 0000000000000000  |................|
>    c0000000f8b01010 0000000000000000 0000000000000000  |................|
>    c0000000f8b01020 0000000000000000 0000000000000000  |................|
>    c0000000f8b01030 0000000000000000 00000000f8b80000  |................|
>                                      ^^^^^^^^^^^^^^^^
> 
> There we can see the reference to our supposedly leaked PUD. But
> because it's missing the leading 0xc, kmemleak won't recognise it.
> 
> We can confirm it's still in use by translating an address that is
> mapped via it:
>    0:mon> dv 7fff94000000 c0000001fe7c0000
>    pgd  @ 0xc0000000f8b01000
>    pgdp @ 0xc0000000f8b01038 = 0x00000000f8b80000 <--
>    pudp @ 0xc0000000f8b81ff8 = 0x00000000037c4000
>    pmdp @ 0xc0000000037c5ca0 = 0x00000000fbd89000
>    ptep @ 0xc0000000fbd89000 = 0xc0800001d5ce0386
>    Maps physical address = 0x00000001d5ce0000
>    Flags = Accessed Dirty Read Write
> 
> The fix is fairly simple. We need to tell kmemleak to ignore PUD
> allocations and never report them as leaks. We can also tell it not to
> scan the PGD, because it will never find pointers in there. However it
> will still notice if we allocate a PGD and then leak it.
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au> > ---
>   arch/powerpc/include/asm/book3s/64/pgalloc.h | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)

[…]

Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> on IBM S822LC


Kind regards,

Paul
