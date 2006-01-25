Return-Path: <kenneth.w.chen@intel.com>
Received: from scsfmr002.sc.intel.com (fmr22.intel.com [143.183.121.14])
	by ozlabs.org (Postfix) with ESMTP id CA5CD68A8B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2006 04:13:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 5/6] fix warning on test_ti_thread_flag()
Date: Wed, 25 Jan 2006 09:08:15 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB509780224@scsmsx401.amr.corp.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
	"Akinobu Mita" <mita@miraclelinux.com>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
	Ian Molton <spyro@f2s.com>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote on Wednesday, January 25, 2006 4:29 AM
> On Wed, 25 Jan 2006, Akinobu Mita wrote:
> > If the arechitecture is
> > - BITS_PER_LONG =3D=3D 64
> > - struct thread_info.flag 32 is bits
> > - second argument of test_bit() was void *
> >=20
> > Then compiler print error message on test_ti_thread_flags()
> > in include/linux/thread_info.h
> >=20
> > Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
> > ---
> >  thread_info.h |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Index: 2.6-git/include/linux/thread_info.h
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- 2.6-git.orig/include/linux/thread_info.h	2006-01-25
19:07:12.000000000 +0900
> > +++ 2.6-git/include/linux/thread_info.h	2006-01-25
19:14:26.000000000 +0900
> > @@ -49,7 +49,7 @@
> > =20
> >  static inline int test_ti_thread_flag(struct thread_info *ti, int
flag)
> >  {
> > -	return test_bit(flag,&ti->flags);
> > +	return test_bit(flag, (void *)&ti->flags);
> >  }
>=20
> This is not safe. The bitops are defined to work on unsigned long
only, so
> flags should be changed to unsigned long instead, or you should use a
> temporary.
>=20
> Affected platforms:
>   - alpha: flags is unsigned int
>   - ia64, sh, x86_64: flags is __u32
>=20
> The only affected 64-platforms are little endian, so it will silently
work
> after your change, though...

I thought test_bit can operate on array beyond unsigned long.
It's perfectly legitimate to do: test_bit(999, bit_array) as
long as bit_array is indeed big enough to hold 999 bits.  It
is the responsibility of the caller to make sure that the
underlying array is big enough for the bit that is being tested.

I don't think you need to change the flags size.

- Ken
