MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: FW: kernel hangs at my_console_write
Date: Mon, 6 Aug 2001 14:03:34 -0500
Message-ID: <3A494DE356A49A40B37442E1E0D9F3B506340B@ptah.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-----Original Message-----
From: Navin Boppuri
Sent: Monday, August 06, 2001 2:00 PM
To: 'Michael Scott Shappe'
Subject: RE: kernel hangs at my_console_write



Hello,

I've actually found a simpler workaround for this. I looked into the
PPCBoot code and in the board.c file in common directory, there is an
#ifdef for CFG_CLKS_IN_HZ . I had to define it for 2.4 and undef it for
2.2.x.

I now seem to have other problems. The kernel boot up till it gets to
the serial driver. It shows up the version information for the serial
driver and then gives me a Kernel Panic. I looked up the NIP address
with my dump and found out that the error is in the "serial_in" routine.
It was not able to find something at some address location.

Thank you,
Navin.

-----Original Message-----
From: Michael Scott Shappe [mailto:mshappe@nxnetworks.com]
Sent: Monday, August 06, 2001 1:26 PM
To: Dan Malek
Cc: Elan Feingold; Linuxppc-Embedded (E-mail)
Subject: Re: kernel hangs at my_console_write



> If you take everything from the same kernel baseline, all of this will
> match.  At one point late in the 2.3.xx development, the values
> were changed from MHz to Hz.  People weren't patching/merging
> correctly to get all of the right parts at the same time.

Dan --

I can accept this statement -- it certainly makes sense -- however, it
doesn't
quite fit what we actually did. We took a stock linux 2.4.5, applied a
patch
that was named 'linuxppc2.4_vs_v.2.4.5.patch' (because there wasn't a
2.4.6),
which we found by chasing links from <http://www.linuxppc.org/>, and
went from
there (I'd give you the exact URL, but linuxppc.org isn't answering,
right
now). On the surface, this seems like it should have been the Right
Thing.

I'm willing to accept that it wasn't, however, especially if someone can
tell
us what the Right Thing is :-D When I tried to build an entirely
unmodified
v.2.4.6 kernel, for example, it didn't even build (symbols had changed
names
and only about half the code had the names changed).

Mike Shappe
NxNetworks, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
