Message-Id: <v03110701b4e8411b4220@[209.183.132.206]>
In-Reply-To: <Pine.LNX.4.21.0003051757150.11636-100000@idd-01.imbc.gr>
References: <38C26453.3668A644@iiic.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 5 Mar 2000 11:58:13 -0500
To: Kostas Gewrgiou <gewrgiou@imbc.gr>, Michel Dänzer <michdaen@iiic.ethz.ch>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
  cwith  r128
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

> The hwcursor in aty128 lives in the framebuffer so since writes in the
>framebuffer get byteswapped differently depending on the depth we need to
>write the cursor with differnt byteswapping depending on the depth.
>The other solution is to disable the be mode in the framebuffer before
>writing the cursor and then reenable it.
>
>It might be also possible to let the hwcursor layer know about this and do
>the right thing (that will be the best way to handle it).

Given that changes in cursor images are in no way performance sensitive, I
think the current patch is just fine, don't you especially if we want
something in before xf 4.0 final.

>> > By the way, true 16 bit depth (565) does not work on my machine. The
>>screen
>> > comes up but everything is very very green!
>> >
>> > Reverting to 16bpp and 15 depth (555) works fine.

>  The problem here is that aty128fb doesn't support 16 bit depth,
>asking for 16 bit will give you 15 bit but fbdevhw fails to detect
>this.

Is this true even under x86?  What about in the very latest aty128fb from
the latest 2.3.XX kernel?

I would think true 16 bit (565) would be desirable given it seems to be the
default in the x86 world.

I will look at the aty128fb.c code to see if there is anything easily found.

By the way,  I can not get the Xserver to work if I specifify more than 1
mode in the XF86Config file.  In fact whatever mode I put there is actually
ignored and the mode used by the frame buffer is inherited instead.

So to change resolutions, I have to use fbset (with /etc/fb.modes filled in
properly) and then start of the XFree86 Xserver.

Is this the resolution switching problem you mentioned to me previously?

Should we be using fbset to change resolutions of should the mode line in
/etc/X11/XF86Config actually be used?

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
