To: marsmail@globegate.utm.edu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux? 
In-Reply-To: Your message of "Sun, 6 Dec 1998 19:18:18 -0600 (CST)"
	<Pine.LNX.3.96.981206190751.2542E-100000@globegate.utm.edu>
References: <Pine.LNX.3.96.981206190751.2542E-100000@globegate.utm.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19981209025752W.roikawa@rr.iij4u.or.jp>
Date: Wed, 09 Dec 1998 02:57:52 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: "David A. Gatwood" <marsmail@globegate.utm.edu>
Subject: Re: XF68_FBDev under MkLinux? 
..snip..
> > >      This requires no kernel changes. In XF68_FBDev, the video ioctl
> > >      and mmap stuff has to be changed slightly.
> 
> And the mach kernel has to have a small amount of code added to map that
> physical space into the vmlinux server's address space, I believe, or
> probably more like additional code in the vmlinux server to request it....
> I'm not sure where the line is drawn... I'm still learning the
> Mach/vmlinux io mapping stuff, the hard way... by coding something and
> then poking around to see why it doesn't work.  :-)
 I have an mmap and ioctl stuff patch for MkLinux at:
  ftp://ppc.linux.or.jp/pub/users/oikawa/mklinux/AccelX_interface/981017/AccelX_support.patch
that makes ioctl(, VC_GETMODE, (struct vc_mode *)&mode) be able to fill out
mode.disp_reg_address field with mmappable graphic chip's MMIO address.

Sorry, but you have to apply this patch manually because this is not
to GENERIC ## kernel but to Apple's DR3 and it contains unnecessary
code appended.
 This patch doesn't do any address alignment even if MMIO address is
not page aligned. Please fix it before use such a graphic chip.


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
