To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linux-fbdev-devel@lists.sourceforge.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: gpm selection vs VGA console & fbcon
References: <20010709150924.21124@smtp.adsl.oleane.com>
From: Daniel Berlin <dan@cgsoftware.com>
Date: Mon, 09 Jul 2001 11:15:56 -0400
In-Reply-To: <20010709150924.21124@smtp.adsl.oleane.com> (Benjamin Herrenschmidt's message of "Mon, 9 Jul 2001 17:09:24 +0200")
Message-ID: <87zoaep1zn.fsf@cgsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> There's an endian bug that have been around for some time causing
> text & attributes to be flipped when doing selections with gpm
> in console mode with VGA console enabled & running on an fbdev.
>
> I didn't follow that closely, but since it's popping up again for
> users I beleive a fix was never merged in the main tree. Is there
> such a patch available or it's still on the list of "things to
> look into one day"  ?

I have a patch still that fixes it, and i keep inserting it into my
tree.

3 liner to include/asm-ppc/vga.h
4 liner to drivers/video/fbcon.c
(this is really two seperate patches, I wasn't about to set up two
trees simply to get 20 lines worth of diff. :P)

*** vga.h	Wed Jul  4 10:58:40 2001
--- /root/linux/include/asm-ppc/vga.h	Thu Jun 28 14:22:02 2001
*************** extern inline u16 scr_readw(volatile con
*** 37,42 ****
--- 37,45 ----

  #define VT_BUF_HAVE_MEMCPYW
  #define scr_memcpyw	memcpy
+ #define VT_BUF_HAVE_MEMCPYF
+ #define scr_memcpyw_to memcpy
+ #define scr_memcpyw_from memcpy

  #endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */

*** fbcon.c	Tue Jul  3 17:58:41 2001
--- /root/linux/drivers/video/fbcon.c	Wed Jun 27 14:52:59 2001
*************** static void fbcon_invert_region(struct v
*** 1954,1966 ****
  	if (!conp->vc_can_do_color)
  	    *p++ ^= 0x0800;
  	else if (conp->vc_hi_font_mask == 0x100) {
! 	    u16 a = *p;
  	    a = ((a) & 0x11ff) | (((a) & 0xe000) >> 4) | (((a) & 0x0e00) << 4);
! 	    *p++ = a;
  	} else {
! 	    u16 a = *p;
  	    a = ((a) & 0x88ff) | (((a) & 0x7000) >> 4) | (((a) & 0x0700) << 4);
! 	    *p++ = a;
  	}
  	if (p == (u16 *)softback_end)
  	    p = (u16 *)softback_buf;
--- 1954,1966 ----
  	if (!conp->vc_can_do_color)
  	    *p++ ^= 0x0800;
  	else if (conp->vc_hi_font_mask == 0x100) {
! 	    u16 a = scr_readw(p);
  	    a = ((a) & 0x11ff) | (((a) & 0xe000) >> 4) | (((a) & 0x0e00) << 4);
! 	    scr_writew(a, p++);
  	} else {
! 	    u16 a = scr_readw(p);
  	    a = ((a) & 0x88ff) | (((a) & 0x7000) >> 4) | (((a) & 0x0700) << 4);
! 	    scr_writew(a, p++);
  	}
  	if (p == (u16 *)softback_end)
  	    p = (u16 *)softback_buf;


> ;)
>
> Ben.
>
>

--
"Last night, I walked up to this beautiful woman in a bar and
asked her, "Do you live around here often?"  She said, "You're
wearing two different colored socks."  I said, "Yes, but to me
they're the same because I go by thickness."  Then she asked,
"How do you feel?"  and I said, "Well, you know when you're
sitting on a chair and you lean back so you're just on two legs
then you lean too far and you almost fall over but at the last
second you catch yourself?  I feel like that all the time."
"-Steven Wright

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
