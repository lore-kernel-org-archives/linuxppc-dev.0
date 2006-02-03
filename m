Return-Path: <Eckhardt@satorlaser.com>
Received: from vMIMEsweeper.dps.local (mail.domino-uk.com [193.131.116.193])
	by ozlabs.org (Postfix) with ESMTP id 53715689F3
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Feb 2006 19:43:35 +1100 (EST)
From: Ulrich Eckhardt <eckhardt@satorlaser.com>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
Date: Fri, 3 Feb 2006 09:31:42 +0100
References: <20060201090224.536581000@localhost.localdomain>
	<20060201090325.905071000@localhost.localdomain>
In-Reply-To: <20060201090325.905071000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602030931.43686.eckhardt@satorlaser.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	Ian Molton <spyro@f2s.com>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>, linuxsh-dev@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>,
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

On Wednesday 01 February 2006 10:02, Akinobu Mita wrote:
> unsigned int hweight32(unsigned int w);
> unsigned int hweight16(unsigned int w);
> unsigned int hweight8(unsigned int w);
> unsigned long hweight64(__u64 w);

IMHO, this should use explicitly sized integers like __u8, __u16 etc, unless 
there are stringent reasons like better register use - which is hard to tell 
for generic C code. Also, why on earth is the returntype for hweight64 a 
long?

> +static inline unsigned int hweight32(unsigned int w)
> +{
> +        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
> +        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
[...]

Why not use unsigned constants here?

> +static inline unsigned long hweight64(__u64 w)
> +{
[..]
> +	u64 res;
> +	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);

Why not use initialisation here, too?

just my 2c

Uli
