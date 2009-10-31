Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (bu3sch.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3D68B7C2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  1 Nov 2009 03:43:06 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Accessing flash directly from User Space [SOLVED]
Date: Sat, 31 Oct 2009 17:42:54 +0100
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E231BE@midas.usurf.usu.edu>
	<OF8458219C.9E5B54DB-ONC1257660.0049761D-C1257660.0049DD9C@transmode.se>
In-Reply-To: <OF8458219C.9E5B54DB-ONC1257660.0049761D-C1257660.0049DD9C@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200910311742.56280.mb@bu3sch.de>
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

On Saturday 31 October 2009 14:26:48 Joakim Tjernlund wrote:
> >
> > > On Friday 30 October 2009 16:08:55 Alessandro Rubini wrote:
> > > > > asm("eieio; sync");
> > > >
> > > > Hmm...
> > > >    : : : "memory"
> > > >
> > > > And, doesn't ";" start a comment in assembly? (no, not on powerpc
> > > it seems)
> > >
> > > Yes, I think the barrier is wrong.
> > > Please try with
> > >
> > > #define mb()   __asm__ __volatile__("eieio\n sync\n" : : :
> > > "memory")
> >
> > That definition worked great.  I must have missed the : : : "memory" bit when
> > I was digging through code.
> >
> > Thanks, that gives me about a 2x speedup over the msync() calls.
> 
> Exactly when should you use the barrier? At every access,
> every read or when changing from write to read?

Well, it depends on the device you are accessing. I'll give you a small pseudo example.

mmio[0] = address;
mmio[1] = data;
mb();
mmio[3] |= 0x01; /* This triggers an operation -> address=data */
/* probably also need an mb() here, if the following code
 * depends on the operation to be triggered. */

-- 
Greetings, Michael.
