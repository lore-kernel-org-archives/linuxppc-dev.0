Message-ID: <39A85A74.54F05060@ncal.verio.com>
Date: Sat, 26 Aug 2000 17:01:56 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Endiness and sideffect fixes for XMMS
Content-Type: multipart/mixed;
 boundary="------------80CA3E0007A23B933755109A"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------80CA3E0007A23B933755109A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Attached are bzip2'd diffs for xmms-1.2.2 to fix some endiness
and macro side-effect problems needed on the LinuxPPC platform.
Included:

xmms/input.c and Output/diskwriter/diskwriter.c

  Various glib byteswap macros called with an argument having
  side-effects (pointer post-increment). The macros expand
  the argument multiple times resulting in the pointer
  being incremented well beyond the end of the buffer. On x86
  these macros expand to asm code that may not have the
  problem, and of course won't even be invoked for common
  LE .wav and CD data formats. Causes seg faults in
  some cases and corrupt visualzation data in others.

  Also, a statement in diskwriter makes order of evaluation
  assumptions not guaranteed by C.

esd output plugin

  Patches from Takashi Oe <toe@unlserve.unl.edu> add
  endiness and sign corrections for esd. I changed the byte
  swap routines to use the glib macros generally used in
  xmms. Sign conversions and 8-bit data haven't had any
  real testing as the wav and sndfile input plugins
  aren't working well (sndfile plugin/lib exhibits
  endiness problems on all formats and the wav plugin
  doesn't recognize many 8-bit wavs on either PPC or
  x86 -- an input plugin using the mature multi-platform
  audiofile lib would sure be useful, for testing if
  nothing else).


Notes for LinuxPPC users:

Dependencies on xmms1.2.2 will require updating the
Gnome related libs to the 1.2.2+ level. On LinuxPPC
these have been very unstable, but 1.2.8 (Helix)
seems to finally be pretty stable (xmms CPU load
is also cut significantly and the memory leaks appear
to be tamed -- 1.2.7 was really bad). These patches
could probably be adapted without too much effort to
earlier versions of xmms if you want to minimize updates.

These dependencies will also drag in the later esound
packages which don't work well with the dmasound drivers
(playing only 1-in-n blocks for a very fast playback --
even with esdplay). The backport of Ian Sandoe's new
dmasound drivers seems to fix, or more likely cover-up,
the problem (see his call for testers on the linuxppc-dev
list). The alternative is to use OSS output (won't work
currently on Pismo with LE data -- e.g. CD's and .wav's)
or try forcing the use of the older (pre-ALSA?) esd.

With these patches -- and if you can get a stable
combination of Gnome libs, esound, and dmasound...
-- the xmms-cdread input plugin
<ftp://mud.stack.nl/pub/OuterSpace/willem/> will work
reliably instead of seg-faulting in xmms/input.c and
the LE CD data will be converted to NE for esd. This
provides a CDDA GUI player for the newer Mac models
that lack analog connections to the CD/DVD (the
alternative is command-line use of cdparanoia with
the -Z option piped into play).

Henry
--------------80CA3E0007A23B933755109A
Content-Type: application/octet-stream;
 name="xmms.diff2.bz2"
Content-Disposition: attachment;
 filename="xmms.diff2.bz2"
Content-Transfer-Encoding: base64

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
IDO0BbY=
--------------80CA3E0007A23B933755109A--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
