Date: Sat, 24 Apr 1999 14:50:32 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Reply-To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: platinumfb in 16 bit?
Message-ID: <Pine.LNX.3.96L.990424140440.3369A-100000@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't suppose I could beg/plead someone into fixing platinumfb for 16 bit
color? The problem has been around for while (I posted about it a while ago,
possibly on -user). Basically, 8 bit works fine in X (with hardware
acceleration, such as there is), but 16 bit gives the standard psychedelic
palette problem. Possibly of interest:

(/var/log/dmseg)
...
MacOS display is /platinu
Total VRAM = 2MB 0011
Monitor sense value = 0x60b, using video mode 17 and color mode 1.
Console: switching to colour frame buffer device 128x48
fb0: platinum frame buffer device
...

I do have 2 MB of VRAM (which can do 16 bit color at 1024x768), but the color
mode should definately not be 1; the Mac OS is set to 16 bit color. But that
color mode doesn't seem to make a difference, because I have a psych. palette
while booting as well (not B&W, as color mode 1 would seem to indicate). I
guess I should mention that I'm using BootX 1.03b2, with a kernel argument of
"video=platinumfb:vmode:17,cmode:8". My kernel is currently 2.2.0pre7 (but
that's likely to change soon).

When starting X, I get the message "kernel: platinum_set_var: Not activating"
in /var/log/messages. From the little bit of poking around I did, I think that
might be unrelated, but I have no idea how platinumfb.c works... one other
person with my problem gets the same message, but so does someone else who can
use 16 bit (if I remember the small conversation correctly).

If I use "no video driver" (which is offb, yes?), X works fine in 16 bit
color, but is significantly slower. =( Oh, and this is the standard Xpmac I'm
talking about, not XF68_dev.

-Hollis



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
