Message-ID: <3A9A2A9D.8A779B@valinux.com>
Date: Mon, 26 Feb 2001 21:06:21 +1100
From: Gareth Hughes <gareth@valinux.com>
MIME-Version: 1.0
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: "Timothy A. Seufert" <tas@mindspring.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: r128 DRI driver now fully functional on PPC
References: <3A76769B.87242FAA@valinux.com>
		 <v04220800b6bbb8f01525@[10.0.0.42]> <3A963519.C439E7C0@valinux.com> <v04220800b6be6735bfd4@[165.247.215.42]> <3A9A246D.72D1B5BE@iiic.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> "Timothy A. Seufert" wrote:
> >
> > At 9:02 PM +1100 2/23/01, Gareth Hughes wrote:
> >
> > >Run with LIBGL_DEBUG=1 and see what it says.
> >
> > This revealed what was happening.
> >
> > I set the project root to /usr/Xgart to avoid having to overwrite my
> > existing X11 installation.  libGL was trying to load r128_dri.so, but
> > it was looking under /usr/X11R6/lib/modules/dri, which doesn't even
> > exist.
>
> Strange, it should look in <ProjectRoot>/lib/modules/dri/ . Seems it didn't
> pick up the right libGL.

I'd say libGL.so is doing dlopen( "modules/dri/r128_dri.so", ... ) and
thus picking up the first instance of that in the dynamic loader's
path.  Similarly, applications linked with -lGL will pick up the first
instance of libGL.so, not necessarily the one residing under the current
X server's ProjectRoot directory.

It's very important you have ld.so.conf set to pick up the correct
version if you haven't installed the DRI-enabled X server in /usr/X11R6.

-- Gareth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
