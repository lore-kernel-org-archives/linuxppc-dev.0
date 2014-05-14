Return-Path: <groeck7@gmail.com>
Received: from mail-pb0-x22a.google.com (mail-pb0-x22a.google.com
 [IPv6:2607:f8b0:400e:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 75278140088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 01:34:47 +1000 (EST)
Received: by mail-pb0-f42.google.com with SMTP id md12so1466479pbc.15
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 08:34:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 14 May 2014 08:34:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alan Modra <amodra@gmail.com>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
Message-ID: <20140514153430.GA28553@roeck-us.net>
References: <1399874254.17624.85.camel@pasglop>
 <20140513002846.GA29753@roeck-us.net>
 <1399972601.17624.169.camel@pasglop>
 <20140513171749.GA9440@roeck-us.net>
 <20140514133434.13b66009@canb.auug.org.au>
 <5372FC43.6010707@roeck-us.net>
 <20140514055219.GL5162@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140514055219.GL5162@bubble.grove.modra.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 14, 2014 at 03:22:19PM +0930, Alan Modra wrote:
> On Tue, May 13, 2014 at 10:16:51PM -0700, Guenter Roeck wrote:
> > any idea what might cause this one, by any chance ?
> > 
> > arch/powerpc/kernel/built-in.o: In function `exc_debug_crit_book3e':
> > (.text+0x165ee): relocation truncated to fit: R_PPC64_ADDR16_HI against symbol `interrupt_base_book3e' defined in .text section in arch/powerpc/kernel/built-in.o
> > arch/powerpc/kernel/built-in.o: In function `exc_debug_crit_book3e':
> > (.text+0x16602): relocation truncated to fit: R_PPC64_ADDR16_HI against symbol `interrupt_end_book3e' defined in .text section in arch/powerpc/kernel/built-in.o
> > arch/powerpc/kernel/built-in.o: In function `exc_debug_debug_book3e':
> > 
> > I see this if I try to build powerpc:ppc64e_defconfig or powerpc:chroma_defconfig
> > with gcc 4.8.2 and binutils 2.24.
> 
> Blame me.  I changed the ABI, something that had to be done but
> unfortunately happens to break the booke kernel code.  When building
> up a 64-bit value with lis, ori, shl, oris, ori or similar sequences,
> you now should use @high and @higha in place of @h and @ha.  @h and
> @ha (and their associated relocs R_PPC64_ADDR16_HI and
> R_PPC64_ADDR16_HA) now report overflow if the value is out of 32-bit
> signed range.  ie. @h and @ha assume you're building a 32-bit value.
> This is needed to report out-of-range -mcmodel=medium toc pointer
> offsets in @toc@h and @toc@ha expressions, and for consistency I did
> the same for all other @h and @ha relocs.
> 

Bummer. Confirmed, if I replace "@h" with "@high" in just one place,
the builds pass with binutils 2.24. Unfortunately the same builds then
fails with binutils 2.23.

Any idea how to get it to compile with both old and new versions ?
Is there some predefined constant which I could possibly use for
something like

.if as_version_below_2.24_
	oris    reg,reg,(expr)@h;
.else
	oris    reg,reg,(expr)@high;
.endif

Thanks,
Guenter
