Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0139.outbound.protection.outlook.com [157.56.110.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CED2B1A0BFF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2015 10:58:38 +1100 (AEDT)
Message-ID: <1446852296.11597.53.camel@freescale.com>
Subject: Re: [PATCH] powerpc: allow cross-compilation of ppc64 kernel
From: Scott Wood <scottwood@freescale.com>
To: Laurent Vivier <laurent@vivier.eu>
CC: <benh@kernel.crashing.org>, <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Date: Fri, 6 Nov 2015 17:24:56 -0600
In-Reply-To: <563D2813.80302@vivier.eu>
References: <1446724029-10884-1-git-send-email-laurent@vivier.eu>
 <1446844180.11597.13.camel@freescale.com> <563D2813.80302@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-11-06 at 23:22 +0100, Laurent Vivier wrote:
> Le 06/11/2015 22:09, Scott Wood a écrit :
> > On Thu, 2015-11-05 at 12:47 +0100, Laurent Vivier wrote:
> > > When I try to cross compile a ppc64 kernel, it generally
> > > fails on the VDSO stage. This is true for powerpc64 cross-
> > > compiler, but also when I try to build a ppc64le kernel
> > > on a ppc64 host.
> > > 
> > > VDSO64L fails:
> > > 
> > >   VDSO64L arch/powerpc/kernel/vdso64/vdso64.so.dbg
> > > /usr/bin/powerpc64-linux-gnu-ld: arch/powerpc/kernel/vdso64/sigtramp.o:
> > > file class ELFCLASS64 incompatible with ELFCLASS32
> > > /usr/bin/powerpc64-linux-gnu-ld: final link failed: File in wrong format
> > > 
> > > This fails because gcc calls "collect2" with
> > > "--oformat elf32-powerpcle" with ppc64 objects, without the
> > > "--oformat" ld works well because it use the format of the
> > > first object as output format.
> > > 
> > > As this case is correctly managed to build the other kernel
> > > objects, this patch replaces $(GCC) by $(LD) to generate the
> > > VDSO objects.
> > 
> > I cross-compile ppc64 kernels and have not seen this problem.  I do need 
> > to 
> > pass in -m64 as part of $(CC) if it's not the toolchain default, which is 
> > not 
> > nice, but the proper fix for that is to add -m64 in the makefiles -- and 
> > if I 
> > don't it fails way before VDSO.
> > 
> > Why is GCC building ppc64 object files but telling the linker --oformat 
> > elf32-
> > powerpcle?  Are different options somehow being passed to GCC in one case 
> > versus the other?
> 
> In fact, for all the other parts of the kernel, gcc is called with
> "-mlittle-endian -m64", ld with "-EL -m elf64lppc", and thus generates
> the good objects and calls ld with the good options ("elf64lppc"). I
> think gcc is never used to link, only to compile.
> This, I think, comes from:
> 
> arch/powerpc/Makefile:
> 
> ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
> override CC     += -mlittle-endian
> override LD     += -EL
> ...
> ifeq ($(HAS_BIARCH),y)
> override CC     += -m$(CONFIG_WORD_SIZE)
> override LD     += -m elf$(CONFIG_WORD_SIZE)$(LDEMULATION)

OK, that works if I completely remove the CC environment setting rather than 
just remove the -m64 from it.  It looks like that's been there longer than 
I've been building 64-bit kernels, so I wonder what originally prompted me to 
add the environment setting.

Yes, the kernel itself is linked with ld rather than gcc, but that's unusual. 
 There's nothing wrong with using gcc to link.

> So at this point, I can:
> 
> 1- either fix my compiler,
> 2- or fix the vdso64 linker command.

Do #1, as that's where the bug is, and if you work around it you'll have the 
same problem building other projects if they happen to specify the endianness 
explicitly.

-Scott
