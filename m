Return-Path: <mjt@tls.msk.ru>
Received: from hobbit.corpit.ru (hobbit.corpit.ru [81.13.94.6])
	by ozlabs.org (Postfix) with ESMTP id 19B32689D9
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Feb 2006 20:52:24 +1100 (EST)
Message-ID: <43E07EB2.4020409@tls.msk.ru>
Date: Wed, 01 Feb 2006 12:26:10 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
References: <20060201090224.536581000@localhost.localdomain>
	<20060201090325.905071000@localhost.localdomain>
	<200602011006.09596.ak@suse.de>
In-Reply-To: <200602011006.09596.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
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

Andi Kleen wrote:
> On Wednesday 01 February 2006 10:02, Akinobu Mita wrote:
> 
>>+static inline unsigned int hweight32(unsigned int w)
[]
> How large are these functions on x86? Maybe it would be better to not inline them,
> but put it into some C file out of line.

hweight8	47 bytes
hweight16	76 bytes
hweight32	97 bytes
hweight64	56 bytes (NOT inlining hweight32)
hweight64	197 bytes (inlining hweight32)

Those are when compiled as separate non-inlined functions,
with pushl %ebp and ret.

/mjt
