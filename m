Message-ID: <3B8C16EF.17ECBBD0@iiic.ethz.ch>
Date: Wed, 29 Aug 2001 00:10:55 +0200
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: mlan@cpu.lu
Cc: DebianPPC <debian-powerpc@lists.debian.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Xvideo acceleration: GATOS for PPC?
References: <200108282111.XAA00990@piglet.grunz.lu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> During my quest for improved performance in such goodies as xine and
> vlc, I came across the fact that currently on PPC, the X server eats
> between 20 and 40 percent of the cpu cycles, whereas on i386 (with GATOS
> drivers), it just sleeps doing nothing....
>
> Although I found no evidence documented evicende of this, I suppose this
> is because XFree (plain), although implementing Xvideo, doesn't use the
> hardware acceleration in the ATI chips, whereas the GATOS drivers do
> just that.

Not quite. Plain XFree86 uses the frontend scaler, which also does the
colorspace conversion. The reason for the CPU load is that the data is
transferred to the card with regular memcpy. If the GATOS drivers use
(virtually) no CPU for the transfer, that hints at that they use bus mastering
for the transfer. Very interesting, I'll have to look at the code.


> Anyway, I tried to use teh GATOS drivers on PPC; but unfortunately hit
> two problems:
>
> - XFree doesn't autoload the i2c module of which some symbols are
>   referenced by the r128 driver. Solved by adding 'Module "i2c"' to
>   XF86Config-4.

Driver bug, it should load the module if needed.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
