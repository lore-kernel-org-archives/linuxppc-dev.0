Return-Path: <jyoung5@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA159DDF2B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 04:16:19 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l98IHkbi009724
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 14:17:46 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l98IGGvd079210
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 14:16:16 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l98IG6H7019425
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Oct 2007 14:16:06 -0400
Subject: Re: [PATCH 0/3] usb: ehci ppc device-tree-aware driver
From: Jerone Young <jyoung5@us.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <fd46qj$s6r$1@sea.gmane.org>
References: <20070917125039.GA29525@ru.mvista.com> <fd46qj$s6r$1@sea.gmane.org>
Content-Type: text/plain
Date: Mon, 08 Oct 2007 13:15:53 -0500
Message-Id: <1191867353.5618.17.camel@laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So the issue here with the Sequoia board is that if you load a kernel or
initrd from usb stick while under u-boot environment, when Linux boots
it will see the network adapter & even set an ip for it. But no matter
what it is unable to access any outside ip.

The way we recreated this scenario was:

- Have a USB stick with
    - partition 1 is fat partition with our kernel & initrd
    - partition 2 is ext3 with our root filesystem

1) Boot Sequoia board with USB stick plugged in. Go to u-boot prompt.
2) start usb using "usb start"
3) Load kernel off usb stick using "fatload" command in uboot
   * Optionally load initrd off of usb stick
   * Example:
      fatload usb 0:1 4000000 cuImage.sequoia
    
4) stop usb using "usb stop"
5) Then boot kernel using bootm

Now from this point linux loads and will mount the filesystem on the usb
stick.  But if you want to use networking in anyway you have a problem.
You can start the telnet daemon and access from the board using
127.0.0.1 address (loopback). Trying to access the telnet from an
outside ip is unsuccessful.

Also, if you have it setup so that the root filesystem is on a nfs root,
the kernel is never able to get to the nfs root. Basically something is
really borked.

I'm a little late getting back to this email :-0

On Sat, 2007-09-22 at 23:00 +0000, Hollis Blanchard wrote:
> On Mon, 17 Sep 2007 16:50:39 +0400, Valentine Barshak wrote:
> 
> > Some PowerPC systems have a built-in EHCI controller.
> > This is a device tree aware version of the EHCI controller driver.
> > Currently it's been tested on the PowerPC 440EPx Sequoia board.
> > Other platforms can be added later.
> > The code is based on the ehci-ppc-soc driver by Stefan Roese <sr@denx.de>.
> 
> We're having a strange issue on our Sequoia where the network stops
> functioning when USB is active. Jerone can supply more detail...
> 
> Have you seen anything like that?
> 
