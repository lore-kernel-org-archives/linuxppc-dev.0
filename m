Message-Id: <200008182102.XAA00828@piglet.grunz.lu>
Date: Fri, 18 Aug 2000 23:02:25 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Control fb problem on 8500
To: kevin_myer@iu13.k12.pa.us
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.21.0008151339190.734-100000@pegmatite.iu13.k12.pa.us>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On  15 Aug, this message from Kevin M. Myer echoed through cyberspace:
> A couple of issues have cropped up with my PowerMac 8500.  I am running
> Paulus' 2.4.0-test6 kernel and my console has developed a sort of mirror
> image on the far right one-eighth of the screen.  Basically, everything on
> the screen is mirrored in that eighth of the screen albeit much
> smaller.  For example, as I type this, tiny white lines are being drawn to
> my right.  If I were to `ls --color` a directory, different color lines
> show up.  This behaviour wasn't there in Paulus' 2.4.0-test1-ac21 kernel
> of a few rsyncs ago.

I was able to boot a 2.4.0-t6 kernel tonight (it's like once in a
million boots for me right now with 2.4.0) and experienced the same
problem; although I had only like 6-8 pairs of single-pixel horizontal
lines, maybe 150 or so pixels long, on the right edge of the screen.

Those lines mirrored image content from the left side of the screen, at
the same height, and around 150 pixels inside the screen. I could also
verify that those 'lines' are not part of the pixel data in VRAM, but
are only added on-screen by control.

I've also had a look at what changed on control from earlier versions,
and found only the pitch of the lines that changed.

In fact, before, the line length was exactly hpixels * bytes/pixel,
whereas now there's an additional 0x20 bytes in each line. I have not
been able to boot a 2.4.0 kernel with any fix applied, but you could try
and build a version without those 0x20 bytes added (they are found in a
few spots inside controlfb.c).

As to why these 0x20 bytes were added, anybody know an explanation? And,
if they do serve a purpose (I suppose so ;-), it would be better to add
the exact number of bytes as a #define somewhere...

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
