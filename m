Return-Path: <nico@cam.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by ozlabs.org (Postfix) with ESMTP id B139868A94
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jan 2006 03:30:46 +1100 (EST)
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR002.ip.videotron.ca
	(Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
	with ESMTP id <0ITP00AITKJ7Q4H0@VL-MH-MR002.ip.videotron.ca> for
	linuxppc-dev@ozlabs.org; Thu, 26 Jan 2006 11:30:44 -0500 (EST)
Date: Thu, 26 Jan 2006 11:30:43 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of
	include/asm-*/bitops.h
In-reply-to: <20060126161849.GA13632@colo.lackof.org>
To: Grant Grundler <grundler@parisc-linux.org>
Message-id: <Pine.LNX.4.64.0601261128280.16649@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113206.GD18584@miraclelinux.com>
	<20060125200250.GA26443@flint.arm.linux.org.uk>
	<20060126000618.GA5592@twiddle.net>
	<20060126085540.GA15377@flint.arm.linux.org.uk>
	<20060126161849.GA13632@colo.lackof.org>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, Ian Molton <spyro@f2s.com>,
	Andi Kleen <ak@suse.de>, David Howells <dhowells@redhat.com>,
	linuxppc-dev@ozlabs.org, Greg Ungerer <gerg@uclinux.org>,
	sparclinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Akinobu Mita <mita@miraclelinux.com>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
	linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Jan 2006, Grant Grundler wrote:

> On Thu, Jan 26, 2006 at 08:55:41AM +0000, Russell King wrote:
> > Unfortunately that's not correct.  You do not appear to have checked
> > the compiler output like I did - this code does _not_ generate
> > constant shifts.
> 
> Russell,
> By "written stupidly", I thought Richard meant they could have
> used constants instead of "s".  e.g.:
> 	if (word << 16 == 0) { b += 16; word >>= 16); }
> 	if (word << 24 == 0) { b +=  8; word >>=  8); }
> 	if (word << 28 == 0) { b +=  4; word >>=  4); }
> 
> But I prefer what Edgar Toernig suggested.

It is just as bad on ARM since it requires large constants that cannot 
be expressed with immediate litteral values.  The constant shift 
approach is really the best on ARM.


Nicolas
