Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f178.google.com (mail-yk0-f178.google.com
 [209.85.160.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B19031A092B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 19:19:50 +1100 (AEDT)
Received: by ykba4 with SMTP id a4so35688272ykb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:19:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <29528945.sG1Zff2dkQ@wuerfel>
References: <1445407004-6439-1-git-send-email-kda@linux-powerpc.org>
 <29528945.sG1Zff2dkQ@wuerfel>
Date: Wed, 21 Oct 2015 11:19:48 +0300
Message-ID: <CAOJe8K0KOjLRoboKNvKneF_p1q6B6qQMHRAL1rHtPhAx-bs8bg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/msi: fix section mismatch warning
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/21/15, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 21 October 2015 08:56:44 Denis Kirjanov wrote:
>> Building with CONFIG_DEBUG_SECTION_MISMATCH
>> gives the following warning:
>>
>> WARNING: vmlinux.o(.text+0x41fa8): Section mismatch in reference from
>> the function .msi_bitmap_alloc() to the function
>> .init.text:.memblock_virt_alloc_try_nid()
>> The function .msi_bitmap_alloc() references
>> the function __init .memblock_virt_alloc_try_nid().
>> This is often because .msi_bitmap_alloc lacks a __init
>> annotation or the annotation of .memblock_virt_alloc_try_nid is wrong.
>>
>> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
>>
>
> A patch like this usually requires an explanation why the warning is
> a false positive and why there is no way to solve it besides suppressing
> the warning.

Because memory allocation in msi_bitmap_alloc use either slab allocator or
memblock boot-time allocator so that's why we need the __init_refok
for the latter case. I'll add it to the patch description

>
> 	Arnd
>
