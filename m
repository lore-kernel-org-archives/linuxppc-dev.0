Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4E82B7C5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  1 Nov 2009 00:31:40 +1100 (EST)
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330E231BE@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>	<200910301556.11349.mb@bu3sch.de>
	<20091030150855.GA15046@mail.gnudd.com>	<200910301624.03989.mb@bu3sch.de>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E231BE@midas.usurf.usu.edu>
Subject: RE: Accessing flash directly from User Space [SOLVED]
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Message-ID: <OF8458219C.9E5B54DB-ONC1257660.0049761D-C1257660.0049DD9C@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 31 Oct 2009 14:26:48 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "scottwood@freescale.com" <scottwood@freescale.com>,
	Alessandro Rubini <rubini@gnudd.com>,
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

>
> > On Friday 30 October 2009 16:08:55 Alessandro Rubini wrote:
> > > > asm("eieio; sync");
> > >
> > > Hmm...
> > >    : : : "memory"
> > >
> > > And, doesn't ";" start a comment in assembly? (no, not on powerpc
> > it seems)
> >
> > Yes, I think the barrier is wrong.
> > Please try with
> >
> > #define mb()   __asm__ __volatile__("eieio\n sync\n" : : :
> > "memory")
>
> That definition worked great.  I must have missed the : : : "memory" bit when
> I was digging through code.
>
> Thanks, that gives me about a 2x speedup over the msync() calls.

Exactly when should you use the barrier? At every access,
every read or when changing from write to read?

 Jocke
