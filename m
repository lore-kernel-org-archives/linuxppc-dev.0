Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8E451A0286
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 11:29:37 +1100 (AEDT)
Message-ID: <1447115377.13889.7.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: allow cross-compilation of ppc64 kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Vivier <laurent@vivier.eu>, Scott Wood <scottwood@freescale.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2015 11:29:37 +1100
In-Reply-To: <563DE203.6030001@vivier.eu>
References: <1446724029-10884-1-git-send-email-laurent@vivier.eu>
 <1446844180.11597.13.camel@freescale.com> <563D2813.80302@vivier.eu>
 <1446852296.11597.53.camel@freescale.com> <563DE203.6030001@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-11-07 at 12:35 +0100, Laurent Vivier wrote:
> Le 07/11/2015 00:24, Scott Wood a écrit :
> > On Fri, 2015-11-06 at 23:22 +0100, Laurent Vivier wrote:
> > > Le 06/11/2015 22:09, Scott Wood a écrit :
> > > > On Thu, 2015-11-05 at 12:47 +0100, Laurent Vivier wrote:
> > > > > When I try to cross compile a ppc64 kernel, it generally
> > > > > fails on the VDSO stage. This is true for powerpc64 cross-
> > > > > compiler, but also when I try to build a ppc64le kernel
> > > > > on a ppc64 host.
> > > > > 
> > > > > VDSO64L fails:
> > > > > 
> > > > >   VDSO64L arch/powerpc/kernel/vdso64/vdso64.so.dbg
> > > > > /usr/bin/powerpc64-linux-gnu-ld: arch/powerpc/kernel/vdso64/sigtramp.o:
> > > > > file class ELFCLASS64 incompatible with ELFCLASS32
> > > > > /usr/bin/powerpc64-linux-gnu-ld: final link failed: File in wrong format
> > > > > 
> > > > > This fails because gcc calls "collect2" with
> > > > > "--oformat elf32-powerpcle" with ppc64 objects, without the
> > > > > "--oformat" ld works well because it use the format of the
> > > > > first object as output format.
> > > > > 
> > > > > As this case is correctly managed to build the other kernel
> > > > > objects, this patch replaces $(GCC) by $(LD) to generate the
> > > > > VDSO objects.
> > 
> > > So at this point, I can:
> > > 
> > > 1- either fix my compiler,
> > > 2- or fix the vdso64 linker command.
> > 
> Thank you Scott. With the help of the comment from Segher, I can choose
> #1 now :)

What distro/toolchain did you hit this on?

I actually wrote this same patch a while back, but from memory it broke in some
configurations. So I never merged it. I'll see if I can find my notes and work
out exactly why it didn't work, maybe we should merge it anyway, even though
the real bug is a toolchain bug.

cheers
