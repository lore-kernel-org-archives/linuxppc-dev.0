Message-ID: <398A522C.77172439@ncal.verio.com>
Date: Thu, 03 Aug 2000 22:18:36 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: CDDA playback on Pismo (and other newer models)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As most of you know, the newer Mac models lack analog CD playback
capabilities. So I've been experimenting with using cdparanoia
piped through play for CD playback on my Pismo with
2.2.17pre15-ben1 (btw, very stable so far).

Using the ATAPI CD drivers there are underruns with significant
dropouts every couple of seconds. Various hdparms and cdparanoia
parms were tried with no significant change. These include various
transfers modes and cdparanoia's buffer (-n) and speed (-S)
parms and various data formats. Piping cdparanoia out to /dev/null
showed data rates of 46 sectors/sec at -S1, 65sps at -S8, and
133sps at -S12 and above (also the default and no significant
changes with different transfer modes and -n values). At the higher
speeds (>-S11) there is a high-level of continuous head-seek noise,
suggesting a lot of overruns and reseeks on the CD i/f side.

Rebuilding the kernel to use SCSI generic devices with IDE SCSI
emulation produced much better, even usable, results. At startup
there are still a couple of dropouts in the first few seconds,
but after that the playback is clean across multiple tracks (even
with a concurrent kernel compile). Piping cdparanoia to /dev/null
shows data rates of 187sectors/sec at all -S settings (and default).
>From the the drive's spin-up sounds it seems to always be in
high-speed mode, but unlike the ATAPI driver, there is little
head movement noise.

So, any thoughts as to whether this a lack of sufficent buffering
in the CDDA path of the ATAPI CD driver? Or, more general
performance problems in the ATAPI CD or low-level drivers?

I'll also be looking at cdparanoia (v9.7), it does diffentiate
between ATAPI and SCSI interfaces, so it might not be reading
ATAPI devices in an optimal manner. I'll also be giving cdda2wav
a try now that I have SCSI emulation built in (btw, you don't
need to leave the ATAPI cd driver out of the build, just use
the hd[n]=ide-scsi boot parm to switch).

Additionally there seems to be some clipping occuring somewhere
in the A/D or mixer/preamp. It's independent of output
volume on either the internal speakers or external port, and
only occurs, consistently, on a few tracks I've tried. But in
general using .aiff format instead of .wav seems to sound a
bit better, with perhaps a bit less clipping (haven't tried
the latest damsound patches).

I'd like to give XMMS a try, but the XMMS in LPPC2K and updates
and builds of newer versions all generate white noise on .wav
files (endiness?). Has anyone been able to get XMMS to work on
a Pismo? And where can I find the XMMS CDDA playback plugin?

TIA,
Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
