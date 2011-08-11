Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4C94B70BF
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 19:44:02 +1000 (EST)
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AE28@saturn3.aculab.com>
References: <OF35FB17D7.41EF05A7-ONC12578E9.0032D316-C12578E9.00338C07@transmode.se>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AE28@saturn3.aculab.com>
Subject: RE: [RFC] Optimize __arch_swab32 and __arch_swab16
To: "David Laight" <David.Laight@ACULAB.COM>
Message-ID: <OF979DFF25.9A9BC066-ONC12578E9.0034FB5C-C12578E9.0035767B@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 11 Aug 2011 11:43:57 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Andreas Schwab <schwab@redhat.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"David Laight" <David.Laight@ACULAB.COM> wrote on 2011/08/11 11:29:33:
>
>
> > > Which is a problem because the compiler could schedule
> > > it be written back to real memory between the instructions.
> >
> > It can? There is no memory here, just registers. Even if it
> > is written to memory, how would that affect the register?
>
> Although the function argument is passed in a register, the
> compiler could generate a store-load sequence before and
> after each __asm__() line.

Ah, I see. Seems strange that the complier would do that for
the register in use(value). Other regs perhaps.

>
> > Assuming you are right, would rewriting it to
> >   __asm__("rlwimi %0,%0,16,0x00ff0000\n\t"
> >        "rlwinm %0,%0,24,0x0000ffff"
> >        : "+r"(value));
> > help?
>
> Except that now you've stopped the compiler scheduling
> another instruction between the two - probably forcing a
> execution stall.

But this should be better than using 2 more insns and an
extra register.

 Jocke
