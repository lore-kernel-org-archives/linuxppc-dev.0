Date: Fri, 18 Aug 2000 23:47:49 -0700
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Control fb problem on 8500
Message-ID: <20000818234749.A7999@drow.them.org>
References: <Pine.LNX.4.21.0008151339190.734-100000@pegmatite.iu13.k12.pa.us> <200008182102.XAA00828@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200008182102.XAA00828@piglet.grunz.lu>; from mlan@cpu.lu on Fri, Aug 18, 2000 at 11:02:25PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 18, 2000 at 11:02:25PM +0200, Michel Lanners wrote:
> I've also had a look at what changed on control from earlier versions,
> and found only the pitch of the lines that changed.
>
> In fact, before, the line length was exactly hpixels * bytes/pixel,
> whereas now there's an additional 0x20 bytes in each line. I have not
> been able to boot a 2.4.0 kernel with any fix applied, but you could try
> and build a version without those 0x20 bytes added (they are found in a
> few spots inside controlfb.c).
>
> As to why these 0x20 bytes were added, anybody know an explanation? And,
> if they do serve a purpose (I suppose so ;-), it would be better to add
> the exact number of bytes as a #define somewhere...

*sigh*

I have no idea where this came from, but 0x20 means it has something to
do with cursor support, I'd bet.  I seem to recall someone talking
about that a few months ago... that is how hardware cursor is generally
implemented, by a 32 pixel block at the end of the scanline.

Dan
the underactive and out of touch controlfb maintainer

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
