Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-x243.google.com (mail-ot0-x243.google.com
 [IPv6:2607:f8b0:4003:c0f::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QWxC4jMtzF20v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 03:11:11 +1000 (AEST)
Received: by mail-ot0-x243.google.com with SMTP id d9-v6so22190682oth.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 10:11:11 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <e49e2296-11f8-a2fa-6b64-db18ba5db641@c-s.fr>
References: <20180417104909.22D416C07D@po15720vm.idsi0.si.c-s.fr>
 <CA+7wUszKbPKu86jSprEBJsxJOmyAc42x5S4XmPce_RFXTsHTfQ@mail.gmail.com>
 <e49e2296-11f8-a2fa-6b64-db18ba5db641@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 17 Apr 2018 19:10:46 +0200
Message-ID: <CA+7wUswJoGnb50y8jbPfsi9ztCO1jZ+O4cirHtXc7gp7MXRm5Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Allow selection of
 CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 17, 2018 at 6:49 PM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 17/04/2018 =C3=A0 18:45, Mathieu Malaterre a =C3=A9crit :
>>
>> On Tue, Apr 17, 2018 at 12:49 PM, Christophe Leroy
>> <christophe.leroy@c-s.fr> wrote:
>>>
>>> This option does dead code and data elimination with the linker by
>>> compiling with -ffunction-sections -fdata-sections and linking with
>>> --gc-sections.
>>>
>>> By selecting this option on mpc885_ads_defconfig,
>>> vmlinux LOAD segment size gets reduced by 10%
>>>
>>> Program Header before the patch:
>>>      LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**=
16
>>>           filesz 0x0036eda4 memsz 0x0038de04 flags rwx
>>>
>>> Program Header after the patch:
>>>      LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**=
16
>>>           filesz 0x00316da4 memsz 0x00334268 flags rwx
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/Kconfig | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index 8fe4353be5e3..e1fac49cf465 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -888,6 +888,14 @@ config PPC_MEM_KEYS
>>>
>>>            If unsure, say y.
>>>
>>> +config PPC_UNUSED_ELIMINATION
>>> +       bool "Eliminate unused functions and data from vmlinux"
>>> +       default n
>>> +       select LD_DEAD_CODE_DATA_ELIMINATION
>>> +       help
>>> +         Select this to do dead code and data elimination with the
>>> linker
>>> +         by compiling with -ffunction-sections -fdata-sections and
>>> linking
>>> +         with --gc-sections.
>>>   endmenu
>>>
>>
>> Just for reference, I cannot boot my Mac Mini G4 anymore (yaboot). The
>> messages I can see (prom_init) are:
>
>
> Which version of GCC do you use ?

$ powerpc-linux-gnu-gcc --version
powerpc-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

this is simply coming from:

$ apt-cache policy crossbuild-essential-powerpc
crossbuild-essential-powerpc:
  Installed: 12.3
  Candidate: 12.3
  Version table:
 *** 12.3 500
        500 http://ftp.fr.debian.org/debian stretch/main amd64 Packages
        500 http://ftp.fr.debian.org/debian stretch/main i386 Packages
        100 /var/lib/dpkg/status


> Can you provide the generated System.map with and without that option act=
ive
> ?

$ du -sh g4/System.map.*
1.7M g4/System.map.with
1.8M g4/System.map.without

Will send them by private emails.

> Thanks
> Christophe
>
>
>>
>> ---
>> done
>> copying OF device tree...
>> Building dt strings...
>> Building dt structure...
>> Device tree strings 0x01100000 -> 0x01100e02
>> Device tree struct   0x01101000 -> 0x01109000
>> Quiescing Open Firmware ...
>> Booting Linux via __start() @ 0x00140000 ...
>> _
>> ---
>>
>>
>>
>>>   config ISA_DMA_API
>>> --
>>> 2.13.3
>>>
>
