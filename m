Mime-Version: 1.0
Message-Id: <v04220800b6be6735bfd4@[165.247.215.42]>
In-Reply-To: <3A963519.C439E7C0@valinux.com>
References: <3A76769B.87242FAA@valinux.com>
 <v04220800b6bbb8f01525@[10.0.0.42]> <3A963519.C439E7C0@valinux.com>
Date: Sun, 25 Feb 2001 00:32:40 -0800
To: Gareth Hughes <gareth@valinux.com>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: r128 DRI driver now fully functional on PPC
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:02 PM +1100 2/23/01, Gareth Hughes wrote:

>Run with LIBGL_DEBUG=1 and see what it says.

This revealed what was happening.

I set the project root to /usr/Xgart to avoid having to overwrite my
existing X11 installation.  libGL was trying to load r128_dri.so, but
it was looking under /usr/X11R6/lib/modules/dri, which doesn't even
exist.

Since then, I've been trying a number of things, with partial success:


1. Tried to replace /usr/X11R6/lib in /etc/ld.so.conf with
/usr/Xgart/lib.  Result: X server won't start because the DRI tree
isn't building most of the various X shared libraries like Xmu, ICE,
etc.


2. Tried to work around #1 by leaving both /usr/Xgart/lib and
/usr/X11R6/lib in ld.so.conf (Xgart first so it gets priority).

Result: 3D acceleration works!  However, there are a couple major
problems.  First, window titles aren't drawn (the borders are, but
the title text is not), and second, upon running a GL program (I've
been using gears and gloss from Mesa 3.3), I lose keyboard and mouse
input.  Sometimes the mouse cursor is still visible, but clicks do
nothing.  Even pressing caps lock doesn't toggle the capslock light.
I have to telnet into the machine and kill the GL program to get
control back.


3. As an alternate to #2, I went back to just /usr/X11R6/lib in
ld.so.conf, and added symlinks under /usr/X11R6/lib to the missing GL
and DRI libs in the Xgart tree.  I got the window titles back this
way (must be a busted non-3D library somewhere in the DRI tree
causing that), but the input device problems persist.


4. Tried to do the right thing by figuring out how to build the
missing libraries in the DRI tree.  The source code for all the
relevant libs seems to be there, but I can't decipher the X11 build
system enough to figure out exactly why they aren't being built.

I think it's the "#define BuildServersOnly YES" line in host.def, but
commenting it out breaks the build because the DRI tree is not a full
XFree86 source tree.


I'm guessing that this is really the way to go.  Does anybody know of
a way to force building more of the libraries without actually
building everything?  Or do I need to download the remaining chunks
of the Xfree86 source tree and do a full build of everything?

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
