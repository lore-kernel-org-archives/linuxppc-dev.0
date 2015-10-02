Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 74F3C1A0FF4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 18:50:23 +1000 (AEST)
Received: by ykdt18 with SMTP id t18so104520300ykd.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2015 01:50:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150917092539.GJ25444@e104818-lin.cambridge.arm.com>
References: <1442431574-4575-1-git-send-email-kda@linux-powerpc.org>
 <20150917092539.GJ25444@e104818-lin.cambridge.arm.com>
Date: Fri, 2 Oct 2015 11:50:21 +0300
Message-ID: <CAOJe8K0BbKdiaMVZa2RDsnJRBT5HAzctRJDg6vd-d3FuYGmJxQ@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc: msi: mark bitmap with kmemleak_not_leak()
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/17/15, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Sep 16, 2015 at 10:26:14PM +0300, Denis Kirjanov wrote:
>> During the MSI bitmap test on boot kmemleak spews the following trace:
>>
>> unreferenced object 0xc00000016e86c900 (size 64):
>>     comm "swapper/0", pid 1, jiffies 4294893173 (age 518.024s)
>>     hex dump (first 32 bytes):
>> 	00 00 01 ff 7f ff 7f 37 00 00 00 00 00 00 00 00
>> 	.......7........
>> 	ff ff ff ff ff ff ff ff 01 ff ff ff ff
>> 	ff ff ff
>> 	................
>> 	backtrace:
>> 	[<c00000000003eebc>] .zalloc_maybe_bootmem+0x3c/0x380
>> 	[<c000000000042d6c>] .msi_bitmap_alloc+0x3c/0xb0
>> 	[<c000000000a9aff8>] .msi_bitmap_selftest+0x30/0x2b4
>> 	[<c0000000000090f4>] .do_one_initcall+0xd4/0x270
>> 	[<c000000000a8e250>] .kernel_init_freeable+0x1a0/0x280
>> 	[<c000000000009b5c>] .kernel_init+0x1c/0x120
>> 	[<c000000000007fbc>] .ret_from_kernel_thread+0x58/0x9c
>>
>> Added a flag to msi_bitmap for tracking allocations
>> from slab and memblock so we can properly free/handle
>> memory in msi_bitmap_free().
>>
>> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
Hi Michael,
could you please apply the patch to fixes branch as well?

Thanks!
