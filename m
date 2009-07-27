Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3517DB70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 08:07:58 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0C3ADDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 08:07:57 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6RM7sK3011672
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 15:07:55 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n6RM84gJ008473
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 17:08:04 -0500 (CDT)
Date: Mon, 27 Jul 2009 17:07:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: vijay sharma <vjai22@gmail.com>
Subject: Re: PPCboot and latest kernel
Message-ID: <20090727220754.GB19572@b07421-ec1.am.freescale.net>
References: <e571380d0907191132u3985423aiacc7ec8c75c0534b@mail.gmail.com>
	<e571380d0907191136j37d341d7k514f46396a38abc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e571380d0907191136j37d341d7k514f46396a38abc3@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 20, 2009 at 12:06:42AM +0530, vijay sharma wrote:
> 2)Built cuImage and loaded it into memory. I am not seeing any output once
> control passes from wrapper to kernel. As you can see from logs mentioned
> above.

Try enabling early udbg console output.  Also, make sure that Linux is
using the correct baud rate (either with console= or by putting a
current-speed property in the serial node), and that your board file
matches the device tree's root compatible (i.e. the probe function will
succeed).

> While going through mail achieves I found two possible reasons for this
> 1) Wrong entries inside dts file
> I am sure serial attributes are correctly defined inside the file. Also it
> works for wrapper. It should work for linux also.

That does not follow.  There are many things that Linux depends on in the
tree that the wrapper does not care about.

> 2) PPCboot not providing information.
> I have built cuImage . Shouldn't kernel be getting its attributes from dtb
> file rather then depending on bd_info structure.
> I cannot upgrade to uboot. Is there some way I can make my board come up?

If you cannot upgrade to u-boot, then no, it should not be passing a
device tree since it is too old.  Dealing with old firmware that only
passes bd_t is what cuImage is for.

How about:

3) Something is wrong with the kernel port to this platform? :-)

-Scott
