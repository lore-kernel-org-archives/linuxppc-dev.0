Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x8Hrg4bkHzDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 02:17:07 +1000 (AEST)
Date: Fri, 14 Jul 2017 11:17:01 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Matt Brown <matthew.brown.dev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/5] powerpc/lib/sstep: Add bpermd instruction emulation
Message-ID: <20170714161701.GV13471@gate.crashing.org>
References: <20170713032548.451-1-matthew.brown.dev@gmail.com>
 <20170713032548.451-3-matthew.brown.dev@gmail.com>
 <20170713072821.GB13471@gate.crashing.org>
 <CAPoR37Ymuy95zzshsgwQwsCyMJwdc3MOzneL4=dq_xABY7o_dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPoR37Ymuy95zzshsgwQwsCyMJwdc3MOzneL4=dq_xABY7o_dA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 14, 2017 at 02:19:34PM +1000, Matt Brown wrote:
> >> +static nokprobe_inline void do_bpermd(struct pt_regs *regs, unsigned long v1,
> >> +                             unsigned long v2, int ra)
> >> +{
> >> +     unsigned int idx, i;
> >> +     unsigned char perm;
> >> +
> >> +     perm = 0x0;
> >> +     for (i = 0; i < 8; i++) {
> >> +             idx = (v1 >> (i * 8)) & 0xff;
> >> +             if (idx < 64)
> >> +                     perm |= (v2 & (1 << idx)) >> (idx - i);
> >
> > That doesn't work I think, the bit numbers ("idx") are big-endian?
> 
> Why would it be big-endian? Wouldn't it be in the same endian form as the arch?

Because that is what the ISA says.  Bit ordering is always BE.  If any
instruction behaves differently in LE mode that is explicitly described.

Please somehow test that the emulation works correctly, and describe
how you tested it, to give people the warm fuzzies.


Segher
