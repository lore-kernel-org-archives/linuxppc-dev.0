Message-ID: <399E9C66.A51074C7@the-rileys.net>
Date: Sat, 19 Aug 2000 09:40:44 -0500
From: David Riley <oscar@the-rileys.net>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Control fb problem on 8500
References: <Pine.LNX.4.21.0008151339190.734-100000@pegmatite.iu13.k12.pa.us> <200008182102.XAA00828@piglet.grunz.lu> <20000818234749.A7999@drow.them.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz wrote:
>
> On Fri, Aug 18, 2000 at 11:02:25PM +0200, Michel Lanners wrote:
> > I've also had a look at what changed on control from earlier versions,
> > and found only the pitch of the lines that changed.
> >
> > In fact, before, the line length was exactly hpixels * bytes/pixel,
> > whereas now there's an additional 0x20 bytes in each line. I have not
> > been able to boot a 2.4.0 kernel with any fix applied, but you could try
> > and build a version without those 0x20 bytes added (they are found in a
> > few spots inside controlfb.c).
> >
> > As to why these 0x20 bytes were added, anybody know an explanation? And,
> > if they do serve a purpose (I suppose so ;-), it would be better to add
> > the exact number of bytes as a #define somewhere...
>
> *sigh*
>
> I have no idea where this came from, but 0x20 means it has something to
> do with cursor support, I'd bet.  I seem to recall someone talking
> about that a few months ago... that is how hardware cursor is generally
> implemented, by a 32 pixel block at the end of the scanline.

The extra 32 bytes are indeed for a hardware cursor.  On the Mac OS,
when any of the programs I write that write directly to the screen go
awry (the address offset messes up and sends gobblety-gook all over the
screen) there is a column of scrambled pixels that follows cursor motion
(horizontally, anyway; when I move the cursor up and down, the random
bits get overwritten with clear space).  This is highly suggestive of a
hardware cursor.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
