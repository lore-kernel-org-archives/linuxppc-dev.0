Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 613911A0D84
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2015 10:12:54 +1100 (AEDT)
Message-ID: <1446851564.14282.40.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: allow cross-compilation of ppc64 kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>, Laurent Vivier <laurent@vivier.eu>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2015 10:12:44 +1100
In-Reply-To: <1446844180.11597.13.camel@freescale.com>
References: <1446724029-10884-1-git-send-email-laurent@vivier.eu>
 <1446844180.11597.13.camel@freescale.com>
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

On Fri, 2015-11-06 at 15:09 -0600, Scott Wood wrote:
> On Thu, 2015-11-05 at 12:47 +0100, Laurent Vivier wrote:
> > When I try to cross compile a ppc64 kernel, it generally
> > fails on the VDSO stage. This is true for powerpc64 cross-
> > compiler, but also when I try to build a ppc64le kernel
> > on a ppc64 host.
> > 
> > VDSO64L fails:
> > 
> >   VDSO64L arch/powerpc/kernel/vdso64/vdso64.so.dbg
> > /usr/bin/powerpc64-linux-gnu-ld:
> > arch/powerpc/kernel/vdso64/sigtramp.o:
> > file class ELFCLASS64 incompatible with ELFCLASS32
> > /usr/bin/powerpc64-linux-gnu-ld: final link failed: File in wrong
> > format
> > 
> > This fails because gcc calls "collect2" with
> > "--oformat elf32-powerpcle" with ppc64 objects, without the
> > "--oformat" ld works well because it use the format of the
> > first object as output format.
> > 
> > As this case is correctly managed to build the other kernel
> > objects, this patch replaces $(GCC) by $(LD) to generate the
> > VDSO objects.

This is LE ? I think that's a bug in binutils or gcc ... I remember we
fought that a while ago for the openpower builds. It might have been
fixed in upstream toolchain.

Cheers,
Ben.
