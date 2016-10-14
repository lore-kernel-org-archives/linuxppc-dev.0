Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swGb43CRkzDt2b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 16:37:52 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id r16so6481042pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 22:37:52 -0700 (PDT)
Date: Fri, 14 Oct 2016 16:37:45 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: link error on orphan sections
Message-ID: <20161014163745.11bcb772@roar.ozlabs.ibm.com>
In-Reply-To: <14286beb-d100-5877-7725-37402d7ac38d@gmail.com>
References: <20161012070020.30170-1-npiggin@gmail.com>
 <14286beb-d100-5877-7725-37402d7ac38d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 14 Oct 2016 13:35:54 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> On 12/10/16 18:00, Nicholas Piggin wrote:
> > Add --orphan-handling=error to final link flags. This ensures we have to
> > handle all sections. This would have caught subtle breakage such as
> > 7de3b27bac47da9de08409df1d69664acbb72197 at build-time.
> > 
> > Also bring some wayward sections into the fold:
> > - .text.hot and .text.unlikely are compiler generated sections.
> > - .sfpr is a linker generated section for register save functions.
> > - .sdata2, .dynsbss, .plt are used by PPC32
> > - We previously did not specify DWARF_DEBUG or STABS_DEBUG
> > - DWARF_DEBUG did not include DWARF3 .debug_ranges
> > - A number of sections are unused.
> > 
> > I don't know if I've exactly got everything right here, particularly
> > with ppc32, so would appreciate people casting their eye over it.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/Makefile             |  2 +-
> >  arch/powerpc/kernel/vmlinux.lds.S | 16 ++++++++++++++--
> >  include/asm-generic/vmlinux.lds.h |  3 +++
> >  3 files changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 50d020a..a3f2784 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -90,7 +90,7 @@ endif
> >  
> >  LDFLAGS_vmlinux-y := -Bstatic
> >  LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
> > -LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
> > +LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y) --orphan-handling=error
> >  
> >  ifeq ($(CONFIG_PPC64),y)
> >  ifeq ($(call cc-option-yn,-mcmodel=medium),y)
> > diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> > index 8295f51..9f4d85e 100644
> > --- a/arch/powerpc/kernel/vmlinux.lds.S
> > +++ b/arch/powerpc/kernel/vmlinux.lds.S
> > @@ -97,7 +97,7 @@ SECTIONS
> >  	.text : AT(ADDR(.text) - LOAD_OFFSET) {
> >  		ALIGN_FUNCTION();
> >  		/* careful! __ftr_alt_* sections need to be close to .text */
> > -		*(.text .fixup __ftr_alt_* .ref.text)
> > +		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text .sfpr) \
> >  		SCHED_TEXT  
> 
> Is the "\" to pack the sched_text with the rest of .text?

Actually it looks like a typo that slipped in. Good catch.


> > @@ -256,7 +256,9 @@ SECTIONS
> >  	.data : AT(ADDR(.data) - LOAD_OFFSET) {
> >  		DATA_DATA
> >  		*(.sdata)
> > +		*(.sdata2)
> >  		*(.got.plt) *(.got)
> > +		*(.plt)
> >  	}
> >  #else
> >  	.data : AT(ADDR(.data) - LOAD_OFFSET) {
> > @@ -317,6 +319,16 @@ SECTIONS
> >  	_end = . ;
> >  	PROVIDE32 (end = .);
> >  
> > -	/* Sections to be discarded. */
> > +	STABS_DEBUG
> > +
> > +	DWARF_DEBUG
> > +  
> 
> Are the debug sections discarded or is the above
> comment misplaced? I guess they are discarded because of them
> being outside of _end at relocation.

I just got rid of the comment. Having it right above "DISCARDS" seemed
redundant.

I believe the debug sections will be linked into the file, because they
were not put in the /DISCARD/ output. But they will be outside the _end
symbol.

Thanks,
Nick
