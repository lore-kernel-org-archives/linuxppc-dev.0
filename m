Date: Tue, 27 Mar 2001 00:30:28 -0500 (EST)
From: Bill Fink <billfink@capu.net>
To: linuxppc-dev@lists.linuxppc.org
Cc: billfink@capu.net
Subject: Re: xine, ppc and illegal instructions
Message-ID: <Pine.LNX.4.21.0103262330001.19578-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yup, I got the same illegal instructions in xine 0.4.01, and it would
sorta work running under gdb.  It seems to be dying in dlopen, which
is part of /lib/libdl.so.2.  On my system:

gwiz% rpm -q -f /lib/libdl.so.2
glibc-2.1.3-15f

A theory why xine 0.4.01 would work on Henry's system but not on mine
was that Henry was running with a newer glibc (2.2.something).  I was
going to try upgrading my glibc, but that turned out it was going to
require updating in excess of 60 RPMs to satisfy all the dependencies,
so I've temporarily shelved that idea.  YDL 2.0 is supposed to be
released RSN, which includes a 2.2 glibc, so I'll be upgrading to
that once it's available to see if it makes a difference (I may even
try using the 2.0 beta RPMs in advance of the official release).

If you want to try the stable 0.3.7 version of xine, I have a patch
to build it for PPC, and the 0.3.7 version doesn't encounter the
illegal instruction problem.  See my message from March 8 on the
xine-user e-mail archive for the patch (start at http://xine.sourceforge.net/).

There are two minor changes to that patch.

	*  In audio_out/audio_oss_out.c, the patch changed the constant
	   90000 to 88200.  It has since been pointed out to me that
	   this was incorrect and the constant should be left as 90000.

	*  In configure, there's a case check for "powerpc-*-linux*)".
	   This should be changed to "powerpc-*-linux* | ppc-*-linux*)".

Of course I really want to get to use 0.4.01 for its new functionality
such as audio/video synchronization and reported performance improvements,
but I'm stuck for the moment until I can upgrade to YDL 2.0.

						-Bill



> On Sat, 24 Mar 2001, Henry Worth wrote:
>
> > Stefan Berndtsson <stefan@nocrew.org> wrote:
>
> > I'll wait for the new patches and see if that changes >anything though.
>
> Nothing in the patches for this problem, which is
> quite recreatable, Bill Fink was looking into
> this. If the esd daemon is running (just disabling desktop sounds is not enough, kill the
> daemon) and
> you run without -A esd, you will get ill. instr.
> on ppc, unless running in gdb. ESD is useless
> for this anyway, no hope of syncing A/V, at
> least till they fix the esd_get_latency() call
> which just hangs on both PPC and x86.
>
> BTW - the xine user maillists would be a better
> forum for this - <http://xine.sourceforge.net/>
> I'm mailing you the cummalative patch.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
