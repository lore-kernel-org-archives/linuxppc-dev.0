Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id 9E316DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jan 2008 17:47:41 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 1A1F653C75
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jan 2008 07:47:36 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: framebuffer swap endianess
References: <217742.24232.qm@web23107.mail.ird.yahoo.com>
In-Reply-To: <217742.24232.qm@web23107.mail.ird.yahoo.com>
MIME-Version: 1.0
Message-ID: <200801250747.35787.roman.fietze@telemotive.de>
Date: Fri, 25 Jan 2008 07:47:35 +0100
Content-Type: text/plain;
  charset="iso-8859-15"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Angelo,

Question to the mailing list readers: is it ok to post an xfree86 or
xorg patch in this mailing list (about 9KiB), or would it be better to
mail that patch to Angelo directly? Thanks.


On Thursday 24 January 2008 15:27:12 Angelo wrote:

> Modify the X server is a good idea.

Sure, if you know where. It took us some time to find "the" correct
place. But see below. :)

> Could you tell me where is the exact place to do this? in some files like
> fbdev.c or other?

The major changes are inside programs/Xserver/miext/shadow/shpacked.c
of either the xorg or xfree86 version of the X server. The swap is
done when copying the data from the shadow buffer to the video memory.

Another place is programs/Xserver/hw/xfree86/drivers/fbdev/fbdev.c,
but here we just setup the Screen correctly, so our new swapping
shadow buffer update route will be used.

> >This was on the 2.4.25 from DENX and with Xfree86.
>
> Sorry but i don't understand this sentence.

We were using Linux 2.4.25 for the PowerPC from DENX and the XFree86 X
Server. The kernel version shouldn't be a problem at all, and I think
the patches should work on either X Server version, Xorg or Xfree86.


Roman

=2D-=20
Roman Fietze Telemotive AG B=FCro M=FChlhausen
