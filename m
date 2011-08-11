Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D53DAB6F8D
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 18:51:39 +1000 (EST)
In-Reply-To: <m34o1ouyix.fsf@hase.home>
References: <OF9F5D0B06.A12659DA-ONC12578E9.002B23BB-C12578E9.002D304C__34569.7653633126$1313050887$gmane$org@transmode.se>
	<m34o1ouyix.fsf@hase.home>
Subject: Re: [RFC] Optimize __arch_swab32 and __arch_swab16
To: Andreas Schwab <schwab@redhat.com>
Message-ID: <OFA6DEB620.AEA5D453-ONC12578E9.0030425A-C12578E9.0030AA95@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 11 Aug 2011 10:51:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab <schwab@redhat.com> wrote on 2011/08/11 10:45:42:
>
> Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
>
> > unsigned short my__arch_swab16(unsigned short value)
> > {
> >    __asm__("rlwimi %0,%0,16,0x00ff0000"
> >       : "+r" (value));
>
> You are creating a value that does not fit in a short.

Short is passed in a 32 bit register with the upper 16 bits cleared. I just
temporarily use the upper bits and shift it back with the next insn:
__asm__("rlwinm %0,%0,24,0x0000ffff"
    : "+r"(value));
Can I not use the upper 16 bits in this manner?

 Jocke
