Date: Sun, 5 Mar 2000 18:43:47 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Dänzer <michdaen@iiic.ethz.ch>
cc: khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
 cwith  r128
In-Reply-To: <38C26453.3668A644@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.21.0003051757150.11636-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 5 Mar 2000, Michel Dänzer wrote:

>
>
> Kevin Hendricks wrote:
>
> > Here is the patch to fix the cursor for 16bpp and 8bpp for XFree 4.0 r128.
> > (It is attached). It is almost exactly what you sent to me earlier.
>
> This looks a bit complicated to me.
>
> Doesn't it help adding BIT_ORDER_IN_BYTE_MSB_FIRST to the HW cursor flags or
> something? It works in the glint driver (look at pm2_accel.c or pm2_dac.c)
>

 The hwcursor in aty128 lives in the framebuffer so since writes in the
framebuffer get byteswapped differently depending on the depth we need to
write the cursor with differnt byteswapping depending on the depth.
The other solution is to disable the be mode in the framebuffer before
writing the cursor and then reenable it.

It might be also possible to let the hwcursor layer know about this and do
the right thing (that will be the best way to handle it).

>
> > By the way, true 16 bit depth (565) does not work on my machine. The screen
> > comes up but everything is very very green!
> >
> > Reverting to 16bpp and 15 depth (555) works fine.
>
> Does it report the correct RGB weight?

  The problem here is that aty128fb doesn't support 16 bit depth,
asking for 16 bit will give you 15 bit but fbdevhw fails to detect
this.

>
>
> Michel


  Kostas Gewrgiou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
