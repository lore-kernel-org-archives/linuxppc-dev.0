Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40SC3C6RBDzF22h
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 20:37:11 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id p15so4096397pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 03:37:11 -0700 (PDT)
Date: Fri, 20 Apr 2018 20:36:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
Message-ID: <20180420203658.73100c8b@roar.ozlabs.ibm.com>
In-Reply-To: <5b495777-311b-ae81-6e07-6ae68f6da2b9@c-s.fr>
References: <20180420073414.23169-1-npiggin@gmail.com>
 <20180420073414.23169-5-npiggin@gmail.com>
 <5b495777-311b-ae81-6e07-6ae68f6da2b9@c-s.fr>
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

On Fri, 20 Apr 2018 12:01:34 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 20/04/2018 à 09:34, Nicholas Piggin a écrit :
> > This requires further changes to linker script to KEEP some tables
> > and wildcard compiler generated sections into the right place. This
> > includes pp32 modifications from Christophe Leroy.
> > 
> > When compiling powernv_defconfig with this option:
> > 
> > text       data      bss       dec        filename
> > 11827621   4810490   1341080   17979191   vmlinux
> > 11752437   4598858   1338776   17690071   vmlinux.dcde
> > 
> > Resulting kernel is almost 400kB smaller (and still boots).
> > 
> > [ppc32 numbers here]
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   arch/powerpc/Kconfig              |  1 +
> >   arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++++++-----------
> >   2 files changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index c32a181a7cbb..ee6dbe2efc8b 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -205,6 +205,7 @@ config PPC
> >   	select HAVE_KPROBES
> >   	select HAVE_KPROBES_ON_FTRACE
> >   	select HAVE_KRETPROBES
> > +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> >   	select HAVE_LIVEPATCH			if HAVE_DYNAMIC_FTRACE_WITH_REGS
> >   	select HAVE_MEMBLOCK
> >   	select HAVE_MEMBLOCK_NODE_MAP
> > diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> > index c8af90ff49f0..89381dc959ce 100644
> > --- a/arch/powerpc/kernel/vmlinux.lds.S
> > +++ b/arch/powerpc/kernel/vmlinux.lds.S
> > @@ -89,7 +89,7 @@ SECTIONS
> >   	 */
> >   	.text BLOCK(0) : AT(ADDR(.text) - LOAD_OFFSET) {
> >   #ifdef CONFIG_LD_HEAD_STUB_CATCH
> > -		*(.linker_stub_catch);
> > +		KEEP(*(.linker_stub_catch));
> >   		. = . ;
> >   #endif
> >   
> > @@ -98,7 +98,7 @@ SECTIONS
> >   		ALIGN_FUNCTION();
> >   #endif
> >   		/* careful! __ftr_alt_* sections need to be close to .text */
> > -		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);
> > +		*(.text.hot .text .text.[0-9a-zA-Z_]* .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);  
> 
> Why not use TEXT_MAIN here instead of .text .text.[0-9a-zA-Z_]* ?

It's from my early patch before we added those in the generic linker
script. Yes your version looks nicer.

Thanks,
Nick
