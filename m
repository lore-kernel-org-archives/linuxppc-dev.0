Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RRrh55qRzF21k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 15:10:28 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id m7-v6so2514699plt.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 22:10:28 -0700 (PDT)
Date: Thu, 19 Apr 2018 15:10:08 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Allow selection of
 CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20180419150955.6c2ae486@roar.ozlabs.ibm.com>
In-Reply-To: <b098dd58-d8d3-0d42-6947-ea476bd2719d@c-s.fr>
References: <20180417104909.22D416C07D@po15720vm.idsi0.si.c-s.fr>
 <CA+7wUszKbPKu86jSprEBJsxJOmyAc42x5S4XmPce_RFXTsHTfQ@mail.gmail.com>
 <e49e2296-11f8-a2fa-6b64-db18ba5db641@c-s.fr>
 <CA+7wUswJoGnb50y8jbPfsi9ztCO1jZ+O4cirHtXc7gp7MXRm5Q@mail.gmail.com>
 <48cdb73c-f0c4-0c8a-19f5-8fce000e7050@c-s.fr>
 <CA+7wUszJzG4CyfO2_Tvmc_u9oMPxLQMaiP+HnhpEex6KCRgSYw@mail.gmail.com>
 <b098dd58-d8d3-0d42-6947-ea476bd2719d@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 Apr 2018 15:11:24 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 18/04/2018 à 10:36, Mathieu Malaterre a écrit :
> > Christophe,
> > 
> > On Wed, Apr 18, 2018 at 8:34 AM, Christophe LEROY
> > <christophe.leroy@c-s.fr> wrote:  
> >>
> >>
> >> Le 17/04/2018 à 19:10, Mathieu Malaterre a écrit :  
> >>>
> >>> On Tue, Apr 17, 2018 at 6:49 PM, Christophe LEROY
> >>> <christophe.leroy@c-s.fr> wrote:  
> >>>>
> >>>>
> >>>>
> >>>> Le 17/04/2018 à 18:45, Mathieu Malaterre a écrit :  
> >>>>>
> >>>>>
> >>>>> On Tue, Apr 17, 2018 at 12:49 PM, Christophe Leroy
> >>>>> <christophe.leroy@c-s.fr> wrote:  
> >>>>>>
> >>>>>>
> >>>>>> This option does dead code and data elimination with the linker by
> >>>>>> compiling with -ffunction-sections -fdata-sections and linking with
> >>>>>> --gc-sections.
> >>>>>>
> >>>>>> By selecting this option on mpc885_ads_defconfig,
> >>>>>> vmlinux LOAD segment size gets reduced by 10%
> >>>>>>
> >>>>>> Program Header before the patch:
> >>>>>>        LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align
> >>>>>> 2**16
> >>>>>>             filesz 0x0036eda4 memsz 0x0038de04 flags rwx
> >>>>>>
> >>>>>> Program Header after the patch:
> >>>>>>        LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align
> >>>>>> 2**16
> >>>>>>             filesz 0x00316da4 memsz 0x00334268 flags rwx
> >>>>>>
> >>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>>>>> ---
> >>>>>>     arch/powerpc/Kconfig | 8 ++++++++
> >>>>>>     1 file changed, 8 insertions(+)
> >>>>>>
> >>>>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> >>>>>> index 8fe4353be5e3..e1fac49cf465 100644
> >>>>>> --- a/arch/powerpc/Kconfig
> >>>>>> +++ b/arch/powerpc/Kconfig
> >>>>>> @@ -888,6 +888,14 @@ config PPC_MEM_KEYS
> >>>>>>
> >>>>>>              If unsure, say y.
> >>>>>>
> >>>>>> +config PPC_UNUSED_ELIMINATION
> >>>>>> +       bool "Eliminate unused functions and data from vmlinux"
> >>>>>> +       default n
> >>>>>> +       select LD_DEAD_CODE_DATA_ELIMINATION
> >>>>>> +       help
> >>>>>> +         Select this to do dead code and data elimination with the
> >>>>>> linker
> >>>>>> +         by compiling with -ffunction-sections -fdata-sections and
> >>>>>> linking
> >>>>>> +         with --gc-sections.
> >>>>>>     endmenu
> >>>>>>  
> >>>>>
> >>>>> Just for reference, I cannot boot my Mac Mini G4 anymore (yaboot). The
> >>>>> messages I can see (prom_init) are:  
> >>>>
> >>>>
> >>>>
> >>>> Which version of GCC do you use ?  
> >>>
> >>>
> >>> $ powerpc-linux-gnu-gcc --version
> >>> powerpc-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516
> >>> Copyright (C) 2016 Free Software Foundation, Inc.
> >>> This is free software; see the source for copying conditions.  There is NO
> >>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> >>> PURPOSE.
> >>>
> >>> this is simply coming from:
> >>>
> >>> $ apt-cache policy crossbuild-essential-powerpc
> >>> crossbuild-essential-powerpc:
> >>>     Installed: 12.3
> >>>     Candidate: 12.3
> >>>     Version table:
> >>>    *** 12.3 500
> >>>           500 http://ftp.fr.debian.org/debian stretch/main amd64 Packages
> >>>           500 http://ftp.fr.debian.org/debian stretch/main i386 Packages
> >>>           100 /var/lib/dpkg/status
> >>>
> >>>  
> >>>> Can you provide the generated System.map with and without that option
> >>>> active
> >>>> ?  
> >>>
> >>>
> >>> $ du -sh g4/System.map.*
> >>> 1.7M g4/System.map.with
> >>> 1.8M g4/System.map.without  
> >>
> >>
> >> Here below is the list of objects removed with the option selected. I can't
> >> see anything suspect at first.  
> > 
> > Does this help:
> > 
> > $ grep orphan /tmp/g4.log|grep prom_init
> > powerpc-linux-gnu-ld: warning: orphan section `.sbss.of_workarounds'
> > from `arch/powerpc/kernel/prom_init.o' being placed in section
> > `.sbss.of_workarounds'.
> > powerpc-linux-gnu-ld: warning: orphan section `.sbss.of_workarounds'
> > from `arch/powerpc/kernel/prom_init.o' being placed in section
> > `.sbss.of_workarounds'.
> > powerpc-linux-gnu-ld: warning: orphan section `.sbss.of_workarounds'
> > from `arch/powerpc/kernel/prom_init.o' being placed in section
> > `.sbss.of_workarounds'.  
> 
> Well, in a way yes. I initially thought that all those warnings where
> normal, but indeed not. We were missing some things in powerpc linker 
> script, and most likely some sections ended up in the wrong place.
> 
> Last week I tested on an 8xx and it was booting without any issue.
> I tested today on an 83xx and it was not booting.
> 
> I will soon send new patches with the fixes in the linker scripts.

Yeah there needs to be a bit more work for powerpc before we can enable
this. I have some old patches I will dust off and re-send. I never got
modules working properly, I'll see if I can figure it out.

Thanks,
Nick
