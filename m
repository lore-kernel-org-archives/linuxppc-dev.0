Return-Path: <laurent@vivier.eu>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B0431A026E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 18:54:45 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: allow cross-compilation of ppc64 kernel
To: Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <scottwood@freescale.com>
References: <1446724029-10884-1-git-send-email-laurent@vivier.eu>
 <1446844180.11597.13.camel@freescale.com> <563D2813.80302@vivier.eu>
 <1446852296.11597.53.camel@freescale.com> <563DE203.6030001@vivier.eu>
 <1447115377.13889.7.camel@ellerman.id.au>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5641A2A7.9060004@vivier.eu>
Date: Tue, 10 Nov 2015 08:54:15 +0100
MIME-Version: 1.0
In-Reply-To: <1447115377.13889.7.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/11/2015 01:29, Michael Ellerman a écrit :
> On Sat, 2015-11-07 at 12:35 +0100, Laurent Vivier wrote:
>> Le 07/11/2015 00:24, Scott Wood a écrit :
>>> On Fri, 2015-11-06 at 23:22 +0100, Laurent Vivier wrote:
>>>> Le 06/11/2015 22:09, Scott Wood a écrit :
>>>>> On Thu, 2015-11-05 at 12:47 +0100, Laurent Vivier wrote:
>>>>>> When I try to cross compile a ppc64 kernel, it generally
>>>>>> fails on the VDSO stage. This is true for powerpc64 cross-
>>>>>> compiler, but also when I try to build a ppc64le kernel
>>>>>> on a ppc64 host.
>>>>>>
>>>>>> VDSO64L fails:
>>>>>>
>>>>>>   VDSO64L arch/powerpc/kernel/vdso64/vdso64.so.dbg
>>>>>> /usr/bin/powerpc64-linux-gnu-ld: arch/powerpc/kernel/vdso64/sigtramp.o:
>>>>>> file class ELFCLASS64 incompatible with ELFCLASS32
>>>>>> /usr/bin/powerpc64-linux-gnu-ld: final link failed: File in wrong format
>>>>>>
>>>>>> This fails because gcc calls "collect2" with
>>>>>> "--oformat elf32-powerpcle" with ppc64 objects, without the
>>>>>> "--oformat" ld works well because it use the format of the
>>>>>> first object as output format.
>>>>>>
>>>>>> As this case is correctly managed to build the other kernel
>>>>>> objects, this patch replaces $(GCC) by $(LD) to generate the
>>>>>> VDSO objects.
>>>
>>>> So at this point, I can:
>>>>
>>>> 1- either fix my compiler,
>>>> 2- or fix the vdso64 linker command.
>>>
>> Thank you Scott. With the help of the comment from Segher, I can choose
>> #1 now :)
> 
> What distro/toolchain did you hit this on?

fedora 23.

> I actually wrote this same patch a while back, but from memory it broke in some
> configurations. So I never merged it. I'll see if I can find my notes and work
> out exactly why it didn't work, maybe we should merge it anyway, even though
> the real bug is a toolchain bug.

On fedora, there is also a bug in binutils configuration where ld is not
able to manage ppc64le binaries on ppc64 host, but I've already sent a
fix for that and it is now in rawhide (will be in fedora 24).

https://bugzilla.redhat.com/show_bug.cgi?id=1275709

Laurent
