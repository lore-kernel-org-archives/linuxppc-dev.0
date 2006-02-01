Return-Path: <ak@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C4E1A689F3
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Feb 2006 21:48:28 +1100 (EST)
From: Andi Kleen <ak@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
Date: Wed, 1 Feb 2006 11:24:27 +0100
References: <20060201090224.536581000@localhost.localdomain>
	<200602011006.09596.ak@suse.de> <43E07EB2.4020409@tls.msk.ru>
In-Reply-To: <43E07EB2.4020409@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602011124.29423.ak@suse.de>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>,
	linuxppc-dev@ozlabs.org, Greg Ungerer <gerg@uclinux.org>,
	sparclinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>, linuxsh-dev@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>, Akinobu Mita <mita@miraclelinux.com>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	linuxsh-shmedia-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 01 February 2006 10:26, Michael Tokarev wrote:
> Andi Kleen wrote:
> > On Wednesday 01 February 2006 10:02, Akinobu Mita wrote:
> > 
> >>+static inline unsigned int hweight32(unsigned int w)
> []
> > How large are these functions on x86? Maybe it would be better to not inline them,
> > but put it into some C file out of line.
> 
> hweight8	47 bytes
> hweight16	76 bytes
> hweight32	97 bytes
> hweight64	56 bytes (NOT inlining hweight32)
> hweight64	197 bytes (inlining hweight32)
> 
> Those are when compiled as separate non-inlined functions,
> with pushl %ebp and ret.

This would argue for moving them out of line.

-Andi
