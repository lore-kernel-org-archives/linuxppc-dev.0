Message-Id: <v02140b08b299f56c55fd@[209.157.72.95]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 13 Dec 1998 15:03:02 -0800
To: linux-pmac@samba.anu.edu.au, linuxppc-dev-digest@lists.linuxppc.org
From: daver@idiom.com (David Ray)
Subject: Complete fix for PB 2400 16-bit video problem
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry it's taken me a few days to get back to the list with a status on the chipsfb.c driver.

I want to thank Tim for his enormous help with the Chips 65550 video driver on the Powerbook 2400. I confirmed what a couple other readers already posted. The diff that Tim develped definitely fixes all vodeo problems in X at all depths, and improves the video problem while in 16-bit mode on the console. Thanks, Tim!

I'm booting from quik, not using anything special in my boot settings and not using BootX. I compiled the 2.1.130 kernel to use the custom fb8 and fb16 values. The startup messages indicate it is recognizing the driver as Chips 65550. Xpmac that was developed for the pb2400/3400 now works fine in all depths.

It appears that the 16-bit in the console still has some problems. The color balance is off, but useable. Red is too bright and blue is too dim. I use a custom prompt that uses ansi colors so the color balance at the console is more apparent on my system than on one that just uses white characters.

The new XF68_FBDev just released from the xfree86 site still fails in 16 bit mode. This is not a color balance problem, but something more serious. It looks like only half the screen is trying to be initialized while the bottom half still shows a "compressed" display of the console. After about a second, X fails and exits.

As usual, let me know if there is any information I can collect that would be useful in debugging these problems.

Cheers-

Dave
daver@idiom.com



> Date: Tue, 8 Dec 1998 00:38:39 -0800
> From: "Timothy A. Seufert" <tas@mindspring.com>
> Subject: Complete fix for PB 2400 16-bit video problem
> 
> I figured out why 16-bit doesn't work in the console today.  I wasn't
> checking "Advanced driver options" in the console setup screen (I use make
> menuconfig).  This resulted in CONFIG_FBCON_CFB16 (I think that's the name)
> not getting set, which .  Perhaps the CONFIG_FBCON_CFBxx settings should
> default to Y?
> 
> 
> Also, since I proved in my earlier message that I didn't know how to use
> diff, and got told about it :), here is a better diff for
> drivers/video/chipsfb.c.  This will patch it to correctly change bitdepth.
> 
> 



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
