Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6GdX1bYSzDqYj
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Aug 2016 07:14:23 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Date: Sat, 06 Aug 2016 23:13:17 +0200
Message-ID: <9809460.xqZt1viUce@wuerfel>
In-Reply-To: <20160806141716.4b745b74@roar.ozlabs.ibm.com>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <29606723.2uK9PgjbC3@wuerfel> <20160806141716.4b745b74@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday, August 6, 2016 2:17:16 PM CEST Nicholas Piggin wrote:
> On Fri, 05 Aug 2016 21:16:00 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Saturday, August 6, 2016 2:16:42 AM CEST Nicholas Piggin wrote:
> > > > 
> > > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > > index 0ec807d69f18..7a3ad269fa23 100644
> > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > @@ -433,7 +433,7 @@
> > > >   * during second ld run in second ld pass when generating System.map */
> > > >  #define TEXT_TEXT                                                    \
> > > >               ALIGN_FUNCTION();                                       \
> > > > -             *(.text.hot .text .text.fixup .text.unlikely)           \
> > > > +             *(.text.hot .text .text.* .text.fixup .text.unlikely)   \
> > > >               *(.ref.text)                                            \
> > > >       MEM_KEEP(init.text)                                             \
> > > >       MEM_KEEP(exit.text)                                             \
> > > > 
> > > > 
> > > > It also got much faster again, the link time for an allyesconfig
> > > > kernel is now 18 minutes instead of 10 hours, but it's still
> > > > much worse than the 2 minutes I had earlier or the four minutes
> > > > with the previous patch.  
> > > 
> > > Are you using the patches I just sent?  
> > 
> > Not yet, I was still busy with the older version, and trying to
> > figure out exactly what went wrong in ld.bfd. FWIW, I first tried
> > to see if the hash tables were just too small, but as it turned
> > out that was not the problem. When I tried to change the default
> > hash table sizes, making them bigger only made things slower.
> > 
> > I also found the --hash-size=xxx option, which has a significant
> > impact on runtime speed. Interestingly again, using sizes less
> > than the default made things faster in practice. If we can
> > work out the optimum size for the kernel build, that might
> > shave a few minutes off the total build time.
> > 
> > > Either way, you also need
> > > to do the same for data and bss sections as you are using
> > > -fdata-sections too.  
> > 
> > Right.
> > 
> > > I've found virtually no build time regression on powerpc or x86
> > > when those are taken care of properly (x86 numbers I sent are typo,
> > > it's not 5m20, it's 5m02).  
> > 
> > Interesting. I wonder if it's got something to do with the
> > generation of the branch trampolines on ARM, as we have a lot
> > of them on an allyesconfig.
> 
> Powerpc generates quite a few branch trampolines as well, so
> I'm not sure if that would be the issue. Can you get a profile
> of the link?


CPU: AMD64 family15h, speed 2600 MHz (estimated)
Counted CPU_CLK_UNHALTED events (CPU Clocks not Halted) with a unit mask of 0x00 (No unit mask) count 100000
samples  %        image name               symbol name
1212556  63.6990  ld-new                   bfd_hash_lookup
416050   21.8563  ld-new                   bfd_hash_hash
64861     3.4073  no-vmlinux               /no-vmlinux
59038     3.1014  ld-new                   bfd_hash_traverse
13873     0.7288  ld-new                   bfd_get_next_section_by_name
9880      0.5190  ld-new                   strrevcmp

I've manually marked bfd_hash_hash as __attribute__((noinline))
to see it separately from bfd_hash_lookup.

The vast majority of these calls seem to come from _bfd_elf_strtab_add
and from bfd_get_section_by_name/bfd_get_next_section_by_name.

While I first thought the hash tables were too slow, investigating
further showed that most of the hash tables are really small
(and appropriately sized), we just do a lot of lookups on them.

> Are you linking with archives? Do your input archives have a
> symbol index built?

yes, and don't know. I've moved on to your new patches now, will
see how that goes.

> > Is the 5m20 the total build time for the kernel, the time for
> > rebuilding after a trivial change, or the time to call 'ld.bfd'
> > once?
> 
> 5m02 was the total time for x86 defconfig. With the powerpc
> allyesconfig build, the final link:
> 
> $ time ld -EL -m elf64lppc -pie --emit-relocs --build-id --gc-sections -X -o vmlinux -T ./arch/powerpc/kernel/vmlinux.lds --whole-archive built-in.o .tmp_kallsyms2.o
> 
> real	0m15.556s
> user	0m13.288s
> sys	0m2.240s
> 
> $ ls -lh vmlinux
> -rwxrwxr-x 1 npiggin npiggin 279M Aug  6 14:02 vmlinux
> 
> Without -pie --emit-relocs it's 11.8s and 150M but I'm using
> emit-relocs for a post-link step.

Interesting, that does sound more like an ARM specific bug in ld
then. 

> > Are you using ld.bfd on x86 or ld.gold? For me ld.gold either
> > works and is really fast, or it crashes, depending on the
> > configuration. I also don't think it supports big-endian ARM
> > (which is what allyesconfig ends up using).
> 
> ld.bfd on both. Gold crashed on powerpc and I didn't try it on x86.

Ok.

	Arnd
