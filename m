Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 701881A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 13:04:23 +1000 (EST)
Message-ID: <1401937462.17669.8.camel@concordia>
Subject: Re: [PATCH] powerpc: Remove platforms/wsp and associated pieces
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Bolle <pebolle@tiscali.nl>
Date: Thu, 05 Jun 2014 13:04:22 +1000
In-Reply-To: <1401696244.14959.6.camel@x220>
References: <1401672046-17607-1-git-send-email-mpe@ellerman.id.au>
 <1401696244.14959.6.camel@x220>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jimi Xenidis <jimix@pobox.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-06-02 at 10:04 +0200, Paul Bolle wrote:
> On Mon, 2014-06-02 at 11:20 +1000, Michael Ellerman wrote:
> > __attribute__ ((unused))
> > 
> > WSP is the last user of CONFIG_PPC_A2, so we remove that as well.
> > 
> > Although CONFIG_PPC_ICSWX still exists, it's no longer selectable for
> > any Book3E platform, so we can remove the code in mmu-book3e.h that
> > depended on it.
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >  arch/powerpc/Kconfig.debug             |    5 -
> >  arch/powerpc/configs/chroma_defconfig  |  307 ---------
> >  arch/powerpc/include/asm/mmu-book3e.h  |    4 -
> >  arch/powerpc/include/asm/reg_a2.h      |    9 -
> >  arch/powerpc/include/asm/wsp.h         |   14 -
> >  arch/powerpc/kernel/Makefile           |    1 -
> >  arch/powerpc/kernel/cpu_setup_a2.S     |  120 ----
> >  arch/powerpc/kernel/cputable.c         |   38 --
> >  arch/powerpc/kernel/exceptions-64e.S   |   16 -
> >  arch/powerpc/kernel/udbg.c             |    2 -
> >  arch/powerpc/kernel/udbg_16550.c       |   11 -
> >  arch/powerpc/platforms/Kconfig         |    1 -
> >  arch/powerpc/platforms/Kconfig.cputype |    6 +-
> >  arch/powerpc/platforms/Makefile        |    1 -
> >  arch/powerpc/platforms/wsp/Kconfig     |   30 -
> >  arch/powerpc/platforms/wsp/Makefile    |   10 -
> >  arch/powerpc/platforms/wsp/chroma.c    |   56 --
> >  arch/powerpc/platforms/wsp/h8.c        |  135 ----
> >  arch/powerpc/platforms/wsp/ics.c       |  762 ---------------------
> >  arch/powerpc/platforms/wsp/ics.h       |   25 -
> >  arch/powerpc/platforms/wsp/msi.c       |  102 ---
> >  arch/powerpc/platforms/wsp/msi.h       |   19 -
> >  arch/powerpc/platforms/wsp/opb_pic.c   |  321 ---------
> >  arch/powerpc/platforms/wsp/psr2.c      |   67 --
> >  arch/powerpc/platforms/wsp/scom_smp.c  |  434 ------------
> 
> This (trivially) conflicts with commit 2751b628c97e ("powerpc: Fix SMP
> issues with ppc64le ABIv2") in next-20140530.

Ah thanks. I'll assume Ben can handle it unless he yells at me.

> For what it's worth, according to my scripts this doesn't introduce
> Kconfig related regressions (eg, you've removed all references to the
> Kconfig symbols that were removed). And, of course, that puzzling check
> for CONFIG_WSP_DD1_WORKAROUND_DD1_TCE_BUGS is now gone.

Thanks for checking.

cheers
