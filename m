Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 83B46B7C2D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Oct 2009 02:33:23 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Michael Buesch <mb@bu3sch.de>, Alessandro Rubini <rubini@gnudd.com>
Date: Fri, 30 Oct 2009 09:33:16 -0600
Subject: RE: Accessing flash directly from User Space [SOLVED]
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330E231BE@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>
	<200910301556.11349.mb@bu3sch.de>
	<20091030150855.GA15046@mail.gnudd.com>
	<200910301624.03989.mb@bu3sch.de>
In-Reply-To: <200910301624.03989.mb@bu3sch.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "scottwood@freescale.com" <scottwood@freescale.com>,
	"bgat@billgatliff.com" <bgat@billgatliff.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Friday 30 October 2009 16:08:55 Alessandro Rubini wrote:
> > > asm("eieio; sync");
> >
> > Hmm...
> > 	: : : "memory"
> >
> > And, doesn't ";" start a comment in assembly? (no, not on powerpc
> it seems)
>=20
> Yes, I think the barrier is wrong.
> Please try with
>=20
> #define mb()	__asm__ __volatile__("eieio\n sync\n" : : :
> "memory")

That definition worked great.  I must have missed the : : : "memory" bit wh=
en I was digging through code.

Thanks, that gives me about a 2x speedup over the msync() calls.

Thanks for the help!
