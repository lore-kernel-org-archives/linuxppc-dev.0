Date: Tue, 26 Feb 2002 13:05:13 -0800 (PST)
From: "David A. Gatwood" <dgatwood@gatwood.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Nasty ATI/tulip interaction
Message-ID: <Pine.LNX.3.96.1020226125122.28711C-100000@gatwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Weird issue.  I finally got the PowerBase 180, and I've attempted to move
my Linux system from the G4 over to it.  I'm running a heavily patched
2.2.21-pre2 kernel.  It includes the PCI fixup patches, Promise Ultra
ATA/66 patches, and a few (possibly ppc-specific) bug fixes to get around
a problem where it was failing to get the correct drive capacity for my
Maxtor 80 gig drive for the first several warm boots.  (I think it was a
firmware bug in the Maxtor from all indications, as the drive wasn't
jumpered to truncate to 2 gigs, but it was doing it anyway.)

Anyway, everything worked fine until I actually tried to add ethernet to
the system.  When I added a 10/100 Tulip card (Netgear), all manner of
hell broke loose.

First, I tried the tulip.o driver.  Driver loaded.  Tried to ifconfig eth0
up.  My video went black.  Rebooted, video still black.  Power cycled the
monitor, all better.  Tried oldtulip.o.  Same problem.

So I thought maybe it was some weird interaction with the netgear card,
and I tried an old 10-base-T tulip card that worked under MkLinux
way-back-when.  Big mistake, as it apparently changed some card settings
in a way that I can't seem to undo.

Now, I can't even boot into single user mode without the video going black
half-way through boot.  This is with the "no video driver" checkbox in
BootX checked, since without doing that, I was getting scrambled video
half-way through boot even before this whole situation.  If I uncheck the
no video driver box, the screen goes black at the start of boot.

I've tried everything I can think of.  I've removed the ethernet card
entirely now, switched from a fixed sync 13" Apple monitor on the Apple
port to a 1024x768 multisync LCD panel on the VGA port.  I've even held
down the Cuda reset button and power key with the machine unplugged for
thirty seconds.

Does anyone know of any patches for the ATI hardware in these beasts?  If
not, then tonight, I'm going to try to flat-out neuter the entire video
subsystem to treat this card as a dumb framebuffer, since all I need is a
text console anyway.  Any suggestions on where to start?


Later,
David

---------------------------------------------------------------------
                    Check out my weekly web comic:
                     http://www.techmagazine.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
