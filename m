Return-Path: <amodra@gmail.com>
Received: from mail-pb0-x22c.google.com (mail-pb0-x22c.google.com
 [IPv6:2607:f8b0:400e:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8FCAB1400DD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 15:52:27 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id rq2so1242997pbb.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 22:52:24 -0700 (PDT)
Date: Wed, 14 May 2014 15:22:19 +0930
From: Alan Modra <amodra@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
Message-ID: <20140514055219.GL5162@bubble.grove.modra.org>
References: <1399874254.17624.85.camel@pasglop>
 <20140513002846.GA29753@roeck-us.net>
 <1399972601.17624.169.camel@pasglop>
 <20140513171749.GA9440@roeck-us.net>
 <20140514133434.13b66009@canb.auug.org.au>
 <5372FC43.6010707@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5372FC43.6010707@roeck-us.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 13, 2014 at 10:16:51PM -0700, Guenter Roeck wrote:
> any idea what might cause this one, by any chance ?
> 
> arch/powerpc/kernel/built-in.o: In function `exc_debug_crit_book3e':
> (.text+0x165ee): relocation truncated to fit: R_PPC64_ADDR16_HI against symbol `interrupt_base_book3e' defined in .text section in arch/powerpc/kernel/built-in.o
> arch/powerpc/kernel/built-in.o: In function `exc_debug_crit_book3e':
> (.text+0x16602): relocation truncated to fit: R_PPC64_ADDR16_HI against symbol `interrupt_end_book3e' defined in .text section in arch/powerpc/kernel/built-in.o
> arch/powerpc/kernel/built-in.o: In function `exc_debug_debug_book3e':
> 
> I see this if I try to build powerpc:ppc64e_defconfig or powerpc:chroma_defconfig
> with gcc 4.8.2 and binutils 2.24.

Blame me.  I changed the ABI, something that had to be done but
unfortunately happens to break the booke kernel code.  When building
up a 64-bit value with lis, ori, shl, oris, ori or similar sequences,
you now should use @high and @higha in place of @h and @ha.  @h and
@ha (and their associated relocs R_PPC64_ADDR16_HI and
R_PPC64_ADDR16_HA) now report overflow if the value is out of 32-bit
signed range.  ie. @h and @ha assume you're building a 32-bit value.
This is needed to report out-of-range -mcmodel=medium toc pointer
offsets in @toc@h and @toc@ha expressions, and for consistency I did
the same for all other @h and @ha relocs.

-- 
Alan Modra
Australia Development Lab, IBM
