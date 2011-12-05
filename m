Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id E48901007D7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 22:44:25 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 12939-02 for <linuxppc-dev@lists.ozlabs.org>;
 Mon,  5 Dec 2011 11:44:20 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Re: [PATCHv5] atomic: add *_dec_not_zero
Date: Mon, 5 Dec 2011 11:44:10 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEFE@saturn3.aculab.com>
In-Reply-To: <20111204221850.GC14542@n2100.arm.linux.org.uk>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
 "Sven Eckelmann" <sven@narfation.org>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergma nn <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
 linux-alpha@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
 Tony Luck <tony.luck@intel.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, linux-m32r@ml.linux-m32r.org,
 linux-parisc@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 "David S. Miller" <davem@davemloft.net>, Kyle McMartin <kyle@mcmartin.ca>,
 Richard Weinberger <richard@nod.at>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Hirokazu Takata <takata@linux-m32r.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looking at this:

> #ifndef atomic_inc_unless_negative
> static inline int atomic_inc_unless_negative(atomic_t *p)
> {
>         int v, v1;
>         for (v =3D 0; v >=3D 0; v =3D v1) {
>                 v1 =3D atomic_cmpxchg(p, v, v + 1);
>                 if (likely(v1 =3D=3D v))
>                         return 1;
>         }
>         return 0;
> }
> #endif

why is it optimised for '*p' being zero??
I'd have though the initial assignment to 'v' should
be made by reading '*p' without any memory barriers (etc).

	David
