Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKH59ZHzDr4l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:07 +1000 (AEST)
In-Reply-To: <149633761543.6229.12888040793158845755.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Pingfan Liu <piliu@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [v3,1/3] powerpc/fadump: avoid duplicates in crash memory ranges
Message-Id: <3wyzKH3D0pz9s76@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-01 at 17:20:38 UTC, Hari Bathini wrote:
> fadump sets up crash memory ranges to be used for creating PT_LOAD
> program headers in elfcore header. Memory chunk RMA_START through
> boot memory area size is added as the first memory range because
> firmware, at the time of crash, moves this memory chunk to different
> location specified during fadump registration making it necessary to
> create a separate program header for it with the correct offset.
> This memory chunk is skipped while setting up the remaining memory
> ranges. But currently, there is possibility that some of this memory
> may have duplicate entries like when it is hot-removed and added
> again. Ensure that no two memory ranges represent the same memory.
> 
> When 5 lmbs are hot-removed and then hot-plugged before registering
> fadump, here is how the program headers in /proc/vmcore exported by
> fadump look like
> 
> without this change:
> 
>   Program Headers:
>     Type           Offset             VirtAddr           PhysAddr
>                    FileSiz            MemSiz              Flags  Align
>     NOTE           0x0000000000010000 0x0000000000000000 0x0000000000000000
>                    0x0000000000001894 0x0000000000001894         0
>     LOAD           0x0000000000021020 0xc000000000000000 0x0000000000000000
>                    0x0000000040000000 0x0000000040000000  RWE    0
>     LOAD           0x0000000040031020 0xc000000000000000 0x0000000000000000
>                    0x0000000010000000 0x0000000010000000  RWE    0
>     LOAD           0x0000000050040000 0xc000000010000000 0x0000000010000000
>                    0x0000000050000000 0x0000000050000000  RWE    0
>     LOAD           0x00000000a0040000 0xc000000060000000 0x0000000060000000
>                    0x000000019ffe0000 0x000000019ffe0000  RWE    0
> 
> and with this change:
> 
>   Program Headers:
>     Type           Offset             VirtAddr           PhysAddr
>                    FileSiz            MemSiz              Flags  Align
>     NOTE           0x0000000000010000 0x0000000000000000 0x0000000000000000
>                    0x0000000000001894 0x0000000000001894         0
>     LOAD           0x0000000000021020 0xc000000000000000 0x0000000000000000
>                    0x0000000040000000 0x0000000040000000  RWE    0
>     LOAD           0x0000000040030000 0xc000000040000000 0x0000000040000000
>                    0x0000000020000000 0x0000000020000000  RWE    0
>     LOAD           0x0000000060030000 0xc000000060000000 0x0000000060000000
>                    0x000000019ffe0000 0x000000019ffe0000  RWE    0
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a77af552ccc9d4d54459a39f9e5f7a

cheers
