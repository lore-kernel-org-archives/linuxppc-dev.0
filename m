Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00DA6B7BFC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  1 Nov 2009 07:17:14 +1100 (EST)
In-Reply-To: <200910311742.56280.mb@bu3sch.de>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E231BE@midas.usurf.usu.edu>
	<OF8458219C.9E5B54DB-ONC1257660.0049761D-C1257660.0049DD9C@transmode.se>
	<200910311742.56280.mb@bu3sch.de>
Subject: Re: Accessing flash directly from User Space [SOLVED]
To: Michael Buesch <mb@bu3sch.de>
Message-ID: <OF7FB0F99B.2962ECBA-ONC1257660.006EDDB5-C1257660.006F2808@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 31 Oct 2009 21:14:07 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "scottwood@freescale.com" <scottwood@freescale.com>,
	Alessandro Rubini <rubini@gnudd.com>,
	"bgat@billgatliff.com" <bgat@billgatliff.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Buesch <mb@bu3sch.de> wrote on 31/10/2009 17:42:54:
>
> On Saturday 31 October 2009 14:26:48 Joakim Tjernlund wrote:
> > >
> > > > On Friday 30 October 2009 16:08:55 Alessandro Rubini wrote:
> > > > > > asm("eieio; sync");
> > > > >
> > > > > Hmm...
> > > > >    : : : "memory"
> > > > >
> > > > > And, doesn't ";" start a comment in assembly? (no, not on powerpc
> > > > it seems)
> > > >
> > > > Yes, I think the barrier is wrong.
> > > > Please try with
> > > >
> > > > #define mb()   __asm__ __volatile__("eieio\n sync\n" : : :
> > > > "memory")
> > >
> > > That definition worked great.  I must have missed the : : : "memory" bit when
> > > I was digging through code.
> > >
> > > Thanks, that gives me about a 2x speedup over the msync() calls.
> >
> > Exactly when should you use the barrier? At every access,
> > every read or when changing from write to read?
>
> Well, it depends on the device you are accessing. I'll give you a small pseudo example.
>
> mmio[0] = address;
> mmio[1] = data;
> mb();
> mmio[3] |= 0x01; /* This triggers an operation -> address=data */
> /* probably also need an mb() here, if the following code
>  * depends on the operation to be triggered. */

So anything that depends on the previous accesses needs a mb()
hmm, the mmio[0] and mmio[1] are written in order I hope?

 Jocke
