Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: asm inline
Date: Mon, 2 Dec 2002 10:11:55 -0500
Cc: Andreas Schwab <schwab@suse.de>, linuxppc-dev@lists.linuxppc.org
References: <jeisycebok.fsf@sykes.suse.de> <5.2.0.9.2.20021202154112.0512a008@mail.lauterbach.com>
In-Reply-To: <5.2.0.9.2.20021202154112.0512a008@mail.lauterbach.com>
MIME-Version: 1.0
Message-Id: <200212021011.55105.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Here is what Sun's Hamburg developers wrote in reply...

> Hi Kevin,
>
> -fstrict-aliasing is in -O2 optimization since gcc-3.0.x. And no, our
> code is not strict alias safe. You'll get some problems, I know of at
> least one place in sc. I bet there are more.
>
> I recommend to use -O2 -fno-strict-aliasing. This is what Hamburg
> release engineering currently uses.
>
> If someone is able to identify all strict alias violating places I would
> be more than happy to propose that we change these (or add the
> -fno-strict-alias to just these files).
>
> Heiner

So it looks like Solaris and Win must not detect these issues already.
So a backport of the gcc 3.3 warning flag would certainly be a big help to
the OOo project as well.

Thanks,

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
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
