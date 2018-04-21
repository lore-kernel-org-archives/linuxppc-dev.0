Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40SkYL5GdMzF20W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2018 17:16:37 +1000 (AEST)
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
To: Mathieu Malaterre <malat@debian.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicolas Pitre <nico@fluxnic.net>
References: <20180420073414.23169-1-npiggin@gmail.com>
 <20180420073414.23169-5-npiggin@gmail.com>
 <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com>
 <20180420204104.6e22b136@roar.ozlabs.ibm.com>
 <CA+7wUsyWu3eweWjwfFoS5FD5yb3OxjLV4-XyErcNA4fJGPCf8Q@mail.gmail.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <738aa4d6-9313-f484-0510-e965f2881869@c-s.fr>
Date: Sat, 21 Apr 2018 09:16:32 +0200
MIME-Version: 1.0
In-Reply-To: <CA+7wUsyWu3eweWjwfFoS5FD5yb3OxjLV4-XyErcNA4fJGPCf8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/04/2018 à 22:08, Mathieu Malaterre a écrit :
> On Fri, Apr 20, 2018 at 12:41 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> On Fri, 20 Apr 2018 12:00:49 +0200
>> Mathieu Malaterre <malat@debian.org> wrote:
>>
>>> On Fri, Apr 20, 2018 at 9:34 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>> This requires further changes to linker script to KEEP some tables
>>>> and wildcard compiler generated sections into the right place. This
>>>> includes pp32 modifications from Christophe Leroy.
>>>>
>>>> When compiling powernv_defconfig with this option:
>>>>
>>>> text       data      bss       dec        filename
>>>> 11827621   4810490   1341080   17979191   vmlinux
>>>> 11752437   4598858   1338776   17690071   vmlinux.dcde
>>>>
>>>> Resulting kernel is almost 400kB smaller (and still boots).
>>>>
>>>> [ppc32 numbers here]
>>>
>>> ^^^
>>>
>>> Do you want somebody else to provide those numbers ?
>>
>> If you have a booting kernel, yes some more numbers would be good.
> 
> I've used /boot/config-4.15.0-2-powerpc from my current debian
> package. Rebuild master with and without option, boot ok, load/unload
> module ok.
> 
> $ size nick/vmlinux.with*
>     text    data     bss     dec     hex filename
> 7386425 2364370 1425432 11176227 aa8923 nick/vmlinux.with
> 7461457 2475122 1428064 11364643 ad6923 nick/vmlinux.without
> 
> This is not clear why with option the size of kernel is slightly bigger:

The file contains also debug symbols, which might differ.
Only the LOAD part of the file is interesting, that's the part you get 
when doing ppc-linux-objcopy vmlinux vmlinux.bin -O binary

You can see it with readelf -l vmlinux

Christophe

> 
> $ du -sk nick/vmlinux.with*
> 124488 nick/vmlinux.with
> 124004 nick/vmlinux.without
> 
> 
>> Thanks,
>> Nick

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
