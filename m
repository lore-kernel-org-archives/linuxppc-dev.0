Date: Fri, 21 Sep 2001 11:54:59 -0400 (EDT)
From: <tahoward@ntrnet.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: gatos ati.2 with XClaim VR 128
Message-ID: <Pine.LNX.4.33.0109211151230.929-100000@ranger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone used ati.2 with a pci ati card on a macintosh?  I am trying to
get video in working with an XClaim VR 128 (Rage 128, bt829).  However,
xawtv gets a black screen.  If I change channels, I get a green picture
that doesen't seem to correspond to any actual input(video, composite, or
svideo), and no sound.

I did a little poking in r128_video.c, and it seems the multimedia table
is never being initialized.  According to the XFree86 sources, there is no
video bios under ppc linux.  Once the R128InfoPtr makes it into
R128ReadMM_TABLE, the VBIOS field is null, and an attempt to dereference
it segfaults the server.  Josh Huber's patch allows the code to run, but
now I have a motionless black/green screen, and no sound.

If I just want to get this working and I'm right about this being the
problem, I could just hardcode the relevant info.  But where would I get
the right values for the multimedia table?

The bigger question is where the data for MM_TABLE is actually being
stored on the card, if not in the bios?  I believe initialization is
handled by open firmware, but what about card specific data?  Is it
somewhere else, or do vendors just have to make sure their drivers know
everything they need to know about their cards?

Or have I just missed something simple?

Tony


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
