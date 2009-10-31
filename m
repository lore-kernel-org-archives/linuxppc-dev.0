Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (bu3sch.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0A98B7C3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  1 Nov 2009 07:36:17 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Accessing flash directly from User Space [SOLVED]
Date: Sat, 31 Oct 2009 21:35:31 +0100
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>
	<200910311742.56280.mb@bu3sch.de>
	<OF7FB0F99B.2962ECBA-ONC1257660.006EDDB5-C1257660.006F2808@transmode.se>
In-Reply-To: <OF7FB0F99B.2962ECBA-ONC1257660.006EDDB5-C1257660.006F2808@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200910312135.34196.mb@bu3sch.de>
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

On Saturday 31 October 2009 21:14:07 Joakim Tjernlund wrote:
> Michael Buesch <mb@bu3sch.de> wrote on 31/10/2009 17:42:54:
> >
> > On Saturday 31 October 2009 14:26:48 Joakim Tjernlund wrote:
> > > >
> > > > > On Friday 30 October 2009 16:08:55 Alessandro Rubini wrote:
> > > > > > > asm("eieio; sync");
> > > > > >
> > > > > > Hmm...
> > > > > >    : : : "memory"
> > > > > >
> > > > > > And, doesn't ";" start a comment in assembly? (no, not on powerpc
> > > > > it seems)
> > > > >
> > > > > Yes, I think the barrier is wrong.
> > > > > Please try with
> > > > >
> > > > > #define mb()   __asm__ __volatile__("eieio\n sync\n" : : :
> > > > > "memory")
> > > >
> > > > That definition worked great.  I must have missed the : : : "memory" bit when
> > > > I was digging through code.
> > > >
> > > > Thanks, that gives me about a 2x speedup over the msync() calls.
> > >
> > > Exactly when should you use the barrier? At every access,
> > > every read or when changing from write to read?
> >
> > Well, it depends on the device you are accessing. I'll give you a small pseudo example.
> >
> > mmio[0] = address;
> > mmio[1] = data;
> > mb();
> > mmio[3] |= 0x01; /* This triggers an operation -> address=data */
> > /* probably also need an mb() here, if the following code
> >  * depends on the operation to be triggered. */
> 
> So anything that depends on the previous accesses needs a mb()

No, not really. I would always put an mb() where the comment is.
Imagine you have two instances of the above (probably in a loop):

mmio[0] = address;
mmio[1] = data;
mb();
mmio[3] |= 0x01; /* This triggers an operation -> address=data */
mb();

mmio[0] = address;
mmio[1] = data;
mb();
mmio[3] |= 0x01; /* This triggers an operation -> address=data */
mb();

> hmm, the mmio[0] and mmio[1] are written in order I hope?

We do not care in this example, as the write to [3] does trigger
the device operation. We do only care that [0] and [1] are set
when [3] is written. We do not care in what order [0] and [1] are written.

This is just an artificial example, but I think you get my point.
My point just being is that an mb() does only belong where it matters.
And what matters is defined by your device specifications.

-- 
Greetings, Michael.
