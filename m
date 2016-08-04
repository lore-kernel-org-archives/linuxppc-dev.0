Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4q7X2JDvzDrKv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 22:31:52 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y134so17923406pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Aug 2016 05:31:52 -0700 (PDT)
Date: Thu, 4 Aug 2016 22:31:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luis R.
 Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org, Paul Mackerras
 <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>, Guenter Roeck
 <linux@roeck-us.net>, Segher Boessenkool <segher@kernel.crashing.org>,
 Nicolas Pitre <nico@linaro.org>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160804223139.0196b3aa@roar.ozlabs.ibm.com>
In-Reply-To: <4007331.2ypSqpxHsb@wuerfel>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <1880505.MpH3ISbtMJ@wuerfel>
 <20160804214713.4baa832e@roar.ozlabs.ibm.com>
 <4007331.2ypSqpxHsb@wuerfel>
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

On Thu, 04 Aug 2016 14:09:02 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday, August 4, 2016 9:47:13 PM CEST Nicholas Piggin wrote:
> > On Thu, 04 Aug 2016 12:37:41 +0200 Arnd Bergmann <arnd@arndb.de> wrote:  
> > > On Thursday, August 4, 2016 11:00:49 AM CEST Arnd Bergmann wrote:  
> > > > I tried this
> > > > 
> > > > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > > > index b5e40ed86e60..89bca1a25916 100755
> > > > --- a/scripts/link-vmlinux.sh
> > > > +++ b/scripts/link-vmlinux.sh
> > > > @@ -44,7 +44,7 @@ modpost_link()
> > > >         local objects
> > > >  
> > > >         if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> > > > -               objects="--whole-archive ${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN} --no-whole-archive"
> > > > +               objects="${KBUILD_VMLINUX_INIT} ${KBUILD_VMLINUX_MAIN}"
> > > >         else
> > > >                 objects="${KBUILD_VMLINUX_INIT} --start-group ${KBUILD_VMLINUX_MAIN} --end-group"
> > > >         fi
> > > > 
> > > > but that did not seem to change anything, the extra symbols are
> > > > still there. I have not tried to understand what that actually
> > > > does, so maybe I misunderstood your suggestion.
> > > >     
> > > 
> > > On a second attempt, I did the same change for vmlinux instead of the
> > > module (d'oh), and got a link failure instead:
> > > 
> > > 
> > > arch/arm/mm/proc-xscale.o: In function `cpu_xscale_do_resume':
> > > (.text+0x3d4): undefined reference to `cpu_resume_mmu'
> > > arch/arm/kernel/setup.o: In function `setup_arch':
> > > ...
> > > 
> > > However, I also see a link failure in some rare configurations
> > > with just your patch:
> > > 
> > > arch/arm/lib/lib.a(io-acorn.o): In function `outsl':
> > > (.text+0x38): undefined reference to `printk'
> > > 
> > > The problem being a file in a library object that is not referenced,
> > > but that references another symbol that is not defined
> > > (CONFIG_PRINTK=n).  
> > 
> > The first problem is the existing link system is buggy. I think an
> > unconditional switch to --whole-archive (at least for modular kernels)
> > should probably be done anyway. For example, on powerpc when building
> > with --whole-archive, I have:
> > 
> > +dma_noop_alloc
> > +dma_noop_free
> > +dma_noop_map_page
> > +dma_noop_mapping_error
> > +dma_noop_map_sg
> > +dma_noop_ops
> > +dma_noop_supported
> > +fdt_add_reservemap_entry
> > +fdt_begin_node
> > +fdt_create
> > +fdt_create_empty_tree
> > +fdt_end_node
> > +fdt_errtable
> > +find_cpio_data
> > +ioremap_page_range
> > 
> > find_cpio_data is unnecessary and it's a codesize regression to link it.
> > But dma_noop_ops and ioremap_page_range are exported symbols. If I
> > reference dma_noop_ops from some random module with otherwise unpatched
> > kernel:
> > 
> > ERROR: "dma_noop_ops" [drivers/char/bsr.ko] undefined!  
> 
> Right, but only on s390, which is the one architecture using this.
> I think we should just have a Kconfig symbol for this file that
> gets selected by any architecture that needs it.

No, the problem is that the module is being selected and built
but it is missing from the vmlinux despite being exported.


> This is also what we have ended up doing for almost all other
> files in lib/
> 
> > The real problem is that our linkage requirements are like a shared
> > library when we build modular.
> > 
> > We could build a list of exports and make it link objects with those
> > symbols, to solve this, but IMO that's just wasting lipstick on a pig.
> > But I will to propose a patch to always use --whole-archive, thin
> > archives or not, and transition all archs over to it in a few release
> > cycles. It just works by luck right now.
> >
> > Why is it a pig? Because having the linker to notice no external
> > references and just skipping the .o completely is trying to use a hammer
> > as a scalpel. It's just not a very effective way to eliminate dead code
> > --  I pulled in only a handful of unneeded functions by switching it.  
> 
> If we do that, we may just as well get rid of $(lib-y) in the process and
> always use $(obj-y).

Sure, after we switch everybody over.


> > I mean it is a quick simple feature that probably works well enough with
> > simple build systems. But not an advanced one that builds almost
> > everything on demand and also has loadable modules and must act like a
> > shared library.
> > 
> > Real linker DCE is a valid optimisation that can't be replaced by the
> > build system of course, but we need to do it properly. Here's what I'm
> > working on.
> > 
> > It applies on top of the previous patch I sent, plus some powerpc stuff
> > I'm working on that you should be able to just ignore for another arch.
> > it's a WIP, but if you can see if it works for arm that would be cool.
> > 
> > It doesn't actually build allyesconfig after this,
> > ld: .tmp_vmlinux1: Too many sections: 220655 (>= 65280)
> > 
> > But on a more reasonable configuration (ppc64le)
> >     text      data   bss            dec   filename
> > 11191672   1183536   1923820   14299028   vmlinux
> > 10625528    861895   1919707   13407130	  vmlinux.thin+gc
> > 
> > 10M-552K   1M-314K         ~   13M-870K  
> 
> Nice!
> 
> > And it actually boots too, which is fairly astounding considering that
> > it lost half a meg of code and 1/3 of its data. I'm not completely sure
> > I've not done something wrong...  
> 
> Nicolas Pitre has done some related work, adding him to Cc. IIRC we have
> actually had multiple implementations of -ffunction-sections/--gc-sections
> in the past that people have used in production, but none of them
> ever made it upstream.

Well I'll try to get it upstream for powerpc so that Stephen's thin ar
patch does not cause a regression. I don't see the problem -- except
with huge configs (that don't build with mainline powerpc anyway), but
it could be an option for build testers who want to do all(yes|mod)config 

 
> One question is whether we should bother with --gc-sections at all,
> or use full LTO instead.

It's no bother. I'm not even sure lto is a complete superset of
ffunction-sections/gc-sections, but either way it is a huge change to
the build and toolchain, whereas gc sections is relatively unremarkable.
Lto is very interesting but will take a big effort to implement and
prove itself I think.

Thanks,
Nick
