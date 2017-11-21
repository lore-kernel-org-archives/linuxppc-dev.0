Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x22f.google.com (mail-ua0-x22f.google.com
 [IPv6:2607:f8b0:400c:c08::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygqJs1ykmzDrLx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 13:28:45 +1100 (AEDT)
Received: by mail-ua0-x22f.google.com with SMTP id s28so7288003uag.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Nov 2017 18:28:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171118153602.Horde.MI0OsGbVxajNC565sIjEmw4@messagerie.c-s.fr>
References: <20171116202839.Horde.gP0ycbGMQpT2Ragrd4TEog1@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711162146260.3639@math.ut.ee>
 <20171117090609.Horde.DBRyYUc0XYQixQKoV-_Luw1@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711171606540.28670@math.ut.ee>
 <20171117161249.Horde.si1lm_DoTH5_kKAdDjlB8Q5@messagerie.c-s.fr>
 <alpine.LRH.2.21.1711171727120.29817@math.ut.ee>
 <20171118153602.Horde.MI0OsGbVxajNC565sIjEmw4@messagerie.c-s.fr>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 21 Nov 2017 13:28:41 +1100
Message-ID: <CAKTCnz=sQAhOqR0SzNt6SSqGsAz5=uieDdZLfL37dYOms99ODg@mail.gmail.com>
Subject: Re: STRICT_KERNEL_RWX on PPC32 is broken on PowerMac G4
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: Meelis Roos <mroos@linux.ee>, Michael Ellerman <mpe@ellerman.id.au>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 19, 2017 at 1:36 AM, LEROY Christophe
<christophe.leroy@c-s.fr> wrote:
> Meelis Roos <mroos@linux.ee> a =C3=A9crit :
>
>>> > > How early does it hang ? Any oops or trace ?
>>> >
>>> > Very early - instead oif kernel emssages, I see some repeated gibberi=
sh
>>> > of some characteers, and the background turns white.
>>> > I am booting from yaboot, background is normally black.
>>>
>>> Ok, could you try by replacing #ifdef CONFIG_STRICT_KERNEL_RWX by #if 0
>>> in arch/powerpc/lib/code-patching.c
>>
>>
>> With this change and CONFIG_STRICT_KERNEL_RWX=3Dy, it still boots.
>>
>> BTW, I get these warnings (sorry for the word wrap from screen paste) -
>> may they be related or rather not?
>>
>>   WRAP    arch/powerpc/boot/zImage.pmac
>>   WRAP    arch/powerpc/boot/zImage.coff
>>   WRAP    arch/powerpc/boot/zImage.miboot
>> INFO: Uncompressed kernel (size 0x5d4c3c) overlaps the address of the
>> wrapper(0x400000)
>> INFO: Fixing the link_address of wrapper to (0x600000)
>>
>
> Then i believe there is something wrong with commit
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?h=3Dnext-20171115&id=3D37bc3e5fd764fb258ff4fcbb90b6d1b67fb466c1
>
> Balbir, do you have any idea ?
>

Hmm.. interesting, so nobats works, but code-patching has issues? Any
chance you can boot with xmon=3Don on the command line
when you drop into the xmon> prompt, type dl to get the kernel log.

Balbir Singh.
