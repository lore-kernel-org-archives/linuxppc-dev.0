Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s73S95hsmzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 13:54:01 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id cf3so23125003pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Aug 2016 20:54:01 -0700 (PDT)
Date: Mon, 8 Aug 2016 13:53:51 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicolas Pitre <nico@linaro.org>, Segher Boessenkool
 <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Subject: Re: [RFC][PATCH 0/5] kbuild changes, thin archives, --gc-sections
Message-ID: <20160808135351.19413e49@roar.ozlabs.ibm.com>
In-Reply-To: <8649964.jra1Y5q7Kz@wuerfel>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <8649964.jra1Y5q7Kz@wuerfel>
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

On Sun, 07 Aug 2016 22:23:02 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday, August 5, 2016 10:11:58 PM CEST Nicholas Piggin wrote:
> > Hello,
> > 
> > I have 3 different things in this patchset. All arch specific, but all
> > involve kbuild changes, so I'd like to discuss them with kbuild
> > maintainers. The goal has been to improve long standing linking
> > difficulties with the powerpc kernel.
> > 
> > * First, building kernel using thin archives rather than incremental
> >   linking. This seems quite clean and is per-arch, so I hope it should
> >   not be too controversial.
> > 
> > * Second, building kernel using -ffunction-sections -fdata-sections,
> >   --gc-sections. Yes, I'm spinning the wheel again. It was motivated
> >   by tiny codesize regression in the first patch, but the results seem
> >   too good to ignore.
> > 
> > * Third, allowing architecture to run a tool over module after it has
> >   been linked. Powerpc wants to use it in order to relocate "alternate
> >   code" instructions that get don't get linked at their runtime
> >   address. No idea if this is the right approach wrt kbuild, but it
> >   seems to work.
> > 
> > I have included the powerpc code for the first two as a reference. The
> > third is much bigger and mostly uninteresting for this cc list, but it
> > can be found here:
> > 
> >  https://patchwork.ozlabs.org/patch/651006/
> > 
> > Comments appreciated.
> > 
> >   
> 
> I've started tested this a bit on ARM now. The first things I noticed
> are:
> 
> 1. /home/arnd/cross-gcc/bin/arm-linux-gnueabi-ld: warning: drivers/xen/efi.o uses 2-byte wchar_t yet the output is to use 4-byte wchar_t; use of wchar_t values across objects may fail
> 
> (actually this one has been present since the first version that
> stopped using recursive linking, I did 971a69db7dc0 ("Xen: don't
> warn about 2-byte wchar_t in efi") when I first saw the bug, but
> that fix no longer works and we have to do this differently
> 
> 2. big-endian builds on ARM stopped working, I now get
> 
> 22:53:02   CC      init/do_mounts_md.o
> 22:53:02   LD      init/mounts.o
> /home/arnd/cross-gcc/bin/arm-linux-gnueabi-ld: init/do_mounts.o: compiled for a big endian system and target is little endian
> /home/arnd/cross-gcc/bin/arm-linux-gnueabi-ld: failed to merge target specific data of file init/do_mounts.o
> 
> The problem seems to be that we don't pass the correct linker
> flags any more, it should be using --be8 from
> 
> arch/arm/Makefile:LDFLAGS_vmlinux       += --be8
> arch/arm/Makefile:LDFLAGS_MODULE        += --be8
> 
> but that somehow is lost.

These both seem like linker flags are being lost for some reason, but I
don't really know why. Maybe ARM's Makefile. I don't have an ARM build setup
but I'll try to help track it down when I get some time.


> 3. drivers/firmware/efi/libstub/lib.a: error adding symbols: Archive has no index; run ranlib to add one
> 
> haven't investigated at all, turned off EFI for now.

Okay this looks like a bug in patch 2 (caused by me, not Stephen!)

For thin archives, cmd_link_l_target should be:

cmd_link_l_target = rm -f $@; $(AR) rcT$(KBUILD_ARFLAGS) $@ $(lib-y)

(note no "S" option).

Thanks,
Nick
