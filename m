Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: asm inline
Date: Mon, 2 Dec 2002 10:08:21 -0500
Cc: Andreas Schwab <schwab@suse.de>, linuxppc-dev@lists.linuxppc.org
References: <jeisycebok.fsf@sykes.suse.de> <5.2.0.9.2.20021202154112.0512a008@mail.lauterbach.com>
In-Reply-To: <5.2.0.9.2.20021202154112.0512a008@mail.lauterbach.com>
MIME-Version: 1.0
Message-Id: <200212021008.21007.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

The Sun JDK 1.3.X source is not strict aliasing safe and that has been
built on a number of platforms and compilers for a long time (I found that
out the hard way a year or two back).

Also OOo used gcc-2.95.4 for a long time (it never supported or used gcc
2.96) and still uses gcc-3.0.4 at -O1 and -O2 for its official binaries
and I do not belive that turns on strict-aliasing at all.

They will stick with gcc-3.0.4 for x86 binaries since they must maintain
c++ compatibilitiy with proprietary binary only components for StarOffice.

Either way, I sent a query to the dev@openoffice.org list to see if anyone
can bring me up to date on any known strict-alising issues.

I have always used -fno-strict-aliasing for all the JDK and OOo binaries
since I was burned by it much earlier and could not find where exactly in
the code the optimization introduced a change.

So the only people who would have any empirical eveidence as to how strict
aliasing safe the OOo code would be are probably Redhat or Mandrake who
have incorporated OOo into their distributions with a later compiler (I
think Debian still uses gcc 2.95.X as their official compiler and I am not
sure what SuSE is using now but Olaf always used gcc 2.95.X for ppc 7.3)

The Apple gcc 3.1 compiler explicitly turns off  strict-aliasing according
to their man page.   So only if the Solaris Forte or the WIN compilers
catch it will those issues already have been fixed.

Kevin


On December 2, 2002 09:51, Franz Sirl wrote:
> At 15:37 02.12.2002, Kevin B. Hendricks wrote:
> >Hi,
> >
> > > |> Is there any warning flag that can be enabled to help find these
> > > |> cases (the OOo source base is simply huge)?
> > >
> > > gcc 3.3 implements such a warning, but it may give many false
> > > positives.
> >
> >Any chance we can get this flag backported so that it appears in gcc
> > 3.2.2?
> >
> >False positives are a whole lot better than code that quietly does the
> > an unexpected thing.
>
> Well, are you sure OO is really affected? strict-aliasing is the default
> since gcc-2.96 which means that everything since redhat-7.0 would be
> affected on x86 for example. Also GCC has been very late to make this
> the default at all, I think that Sun and MS compilers do this for years
> already. I would be very surprised if a multiplatform project like OO
> still contained reasonable amounts of aliasing-unsafe code.
>
> Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
