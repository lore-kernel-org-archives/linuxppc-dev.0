Content-Type: text/plain;
  charset="iso-8859-1"
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Message-Id: <200112052130.15258@enzo.bigblue.local>
To: Daniel Jacobowitz <dmj+@andrew.cmu.edu>,
	Tom Rini <trini@kernel.crashing.org>
Subject: Re: Changes to PPC Linux required for GCC 3.1
Date: Wed, 5 Dec 2001 21:30:37 +0100
Cc: Corey Minyard <minyard@acm.org>,
	Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org
References: <5.1.0.14.2.20011205134825.024d8ed8@mail.lauterbach.com> <20011205173728.GB27936@cpe-24-221-152-185.az.sprintbbd.net> <20011205151721.A18191@nevyn.them.org>
In-Reply-To: <20011205151721.A18191@nevyn.them.org>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday 05 December 2001 21:17, Daniel Jacobowitz wrote:
> On Wed, Dec 05, 2001 at 10:37:28AM -0700, Tom Rini wrote:
> > On Wed, Dec 05, 2001 at 10:18:26AM -0600, Corey Minyard wrote:
> > > Franz Sirl wrote:
> > > >I've done
> > > >
> > > >-#define RELOC(x)       (*PTRRELOC(&(x)))
> > > >+#define RELOC(x)       (*({ typeof(x) * __ptr  = PTRRELOC(&(x));
> > > >__asm__ ("" : "=r" (__ptr) : "0" (__ptr)); __ptr;}))
> > > >
> > > >a while ago in
> > > ><http://source.mvista.com/pipermail/linuxppc-commit/2001-September/000
> > > >729.html>, seems nobody applied it so far.
> > >
> > > Ok.  It needs to be propped.
> >
> > I think the reason this wasn't applied is that Paul said something about
> > thiws being horriyingly ugly.  Corey, can you post a patch that changes
> > RELOC(x) into a function and nothing else? :)
>
> Has either of you tried to boot a kernel in which RELOC is a function?
> If I'm following any of what's going on here, function symbols are
> global.  To call the function you would need to use RELOC.

RELOC is only used to relocate data.

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
