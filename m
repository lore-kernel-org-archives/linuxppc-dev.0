Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yh1Hw31wTzDrNl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 20:58:36 +1100 (AEDT)
Subject: Re: STRICT_KERNEL_RWX on PPC32 is broken on PowerMac G4
To: Balbir Singh <bsingharora@gmail.com>
Cc: Meelis Roos <mroos@linux.ee>, Michael Ellerman <mpe@ellerman.id.au>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
References: <20171116202839.Horde.gP0ycbGMQpT2Ragrd4TEog1@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711162146260.3639@math.ut.ee>
 <20171117090609.Horde.DBRyYUc0XYQixQKoV-_Luw1@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711171606540.28670@math.ut.ee>
 <20171117161249.Horde.si1lm_DoTH5_kKAdDjlB8Q5@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711171727120.29817@math.ut.ee>
 <20171118153602.Horde.MI0OsGbVxajNC565sIjEmw4@messagerie.c-s.fr>
 <CAKTCnz=sQAhOqR0SzNt6SSqGsAz5=uieDdZLfL37dYOms99ODg@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7e1cf4a7-47a5-9763-545e-1157f9b2f91a@c-s.fr>
Date: Tue, 21 Nov 2017 10:58:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAKTCnz=sQAhOqR0SzNt6SSqGsAz5=uieDdZLfL37dYOms99ODg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 21/11/2017 à 03:28, Balbir Singh a écrit :
> On Sun, Nov 19, 2017 at 1:36 AM, LEROY Christophe
> <christophe.leroy@c-s.fr> wrote:
>> Meelis Roos <mroos@linux.ee> a écrit :
>>
>>>>>> How early does it hang ? Any oops or trace ?
>>>>>
>>>>> Very early - instead oif kernel emssages, I see some repeated gibberish
>>>>> of some characteers, and the background turns white.
>>>>> I am booting from yaboot, background is normally black.
>>>>
>>>> Ok, could you try by replacing #ifdef CONFIG_STRICT_KERNEL_RWX by #if 0
>>>> in arch/powerpc/lib/code-patching.c
>>>
>>>
>>> With this change and CONFIG_STRICT_KERNEL_RWX=y, it still boots.
>>>
>>> BTW, I get these warnings (sorry for the word wrap from screen paste) -
>>> may they be related or rather not?
>>>
>>>    WRAP    arch/powerpc/boot/zImage.pmac
>>>    WRAP    arch/powerpc/boot/zImage.coff
>>>    WRAP    arch/powerpc/boot/zImage.miboot
>>> INFO: Uncompressed kernel (size 0x5d4c3c) overlaps the address of the
>>> wrapper(0x400000)
>>> INFO: Fixing the link_address of wrapper to (0x600000)
>>>
>>
>> Then i believe there is something wrong with commit
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20171115&id=37bc3e5fd764fb258ff4fcbb90b6d1b67fb466c1
>>
>> Balbir, do you have any idea ?
>>
> 
> Hmm.. interesting, so nobats works, but code-patching has issues? Any
> chance you can boot with xmon=on on the command line
> when you drop into the xmon> prompt, type dl to get the kernel log.

I have the same issue with a 83xx board allthought it is booting well on 
my 8xx boards.

Indeed the issue is that patch_instruction() is called from 
early_init(), therefor all static data must be addressed using PTRRELOC()

I have submitted a fixup patch, can you review it ?
slab_is_available() cannot be called that early for the same reason but 
I believe it is not needed.

Christophe


> 
> Balbir Singh.
> 
