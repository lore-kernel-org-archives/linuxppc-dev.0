Return-Path: <sdbrady@ntlworld.com>
Received: from mta08-winn.ispmail.ntl.com (mta08-winn.ispmail.ntl.com
	[81.103.221.48]) by ozlabs.org (Postfix) with ESMTP id BEF3668A0F
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2006 06:49:04 +1100 (EST)
Date: Mon, 30 Jan 2006 19:50:04 +0000
From: Stuart Brady <sdbrady@ntlworld.com>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of
	include/asm-*/bitops.h
Message-ID: <20060130195004.GA25860@miranda.arrow>
References: <20060125113206.GD18584@miraclelinux.com>
	<20060125200250.GA26443@flint.arm.linux.org.uk>
	<20060126000618.GA5592@twiddle.net>
	<20060126085540.GA15377@flint.arm.linux.org.uk>
	<20060126161849.GA13632@colo.lackof.org>
	<20060126164020.GA27222@flint.arm.linux.org.uk>
	<20060126230443.GC13632@colo.lackof.org>
	<20060126230353.GC27222@flint.arm.linux.org.uk>
	<20060129071242.GA24624@miranda.arrow>
	<20060130170647.GC3816@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060130170647.GC3816@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, Ian Molton <spyro@f2s.com>,
	Andi Kleen <ak@suse.de>, David Howells <dhowells@redhat.com>,
	linuxppc-dev@ozlabs.org, Greg Ungerer <gerg@uclinux.org>,
	sparclinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Stuart Brady <sdbrady@ntlworld.com>,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	Grant Grundler <grundler@parisc-linux.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Akinobu Mita <mita@miraclelinux.com>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Hirokazu Takata <takata@linux-m32r.org>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 30, 2006 at 05:06:47PM +0000, Ralf Baechle wrote:
> On Sun, Jan 29, 2006 at 07:12:42AM +0000, Stuart Brady wrote:
> 
> > On MIPS, fls() and flz() should probably use CLO.
> 
> It actually uses clz.

I know.  flz(x) is basically __ilog2(~x), and I still say clo would be
better.  Removing flz() sounds reasonable, though.

> > Curiously, MIPS is the only arch with a flz() function.
> 
> No longer.  The fls implementation was based on flz and fls was the only
> user of flz.  So I cleaned that, once I commit flz will be gone.  Not
> only a cleanup but also a minor optimization.

I'd got that slightly wrong.  Yeah, fls(x) returned flz(~x) + 1, which
is __ilog2(~~x) + 1.  So obviously clz was fine for that, but it needed
cleaning up.

Shame about popc on SPARC.  However, ffz is cheese, regardless of pops.
(On sparc64, ffs is too.)  I'll wait for the generic bitops patches to
be dealt with (or not) and then submit a patch fixing this if needed.

Thanks,
-- 
Stuart Brady

By the way, I really hope nobody gets ten copies of this, as happened
with my last post.  It does not seem to be my fault, AFAICS.
