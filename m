Message-ID: <3ABC3B04.D6F2F957@ncal.verio.com>
Date: Fri, 23 Mar 2001 22:13:24 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: xine, ppc and illegal instructions
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BTW, a change in 0.4.01 that doesn't seem
to be documented anywere. To play DVD's and
VCD's, you will need to create links to the
dvd and/or cdrom /dev/* devices for
/dev/dvd and /dev/vcd.

Also, if you don't have a disk loaded, don't
hit the dvd or vcd playlist scan buttons and
if the playlist has a DVD/VCD "MRL" -- don't
select play, <<, >>, or anything else that
might result in an I/O. And to eject, select
stop and give the drive a chance to spin-down
before selecting eject. There is virtually no
status or error checking for the IOCTLS and
other I/O functions. This results in requests
for functions that are not valid for the drive's current state and result in long
bus-reset/retry recovery sequences, often with focus grabbed,
giving the appearance of a hung machine (part
of this may be driver problems).

I've uploaded some more patches to
ftp.linuxppc.org's incoming, they fix a nasty
rogue threads problem and some more queuing
problems that are responsible for a lot of the
hangs during playback. Hopefully, they will
get moved to contrib/unpackaged in a few days.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
