Return-Path: <MCarey@nearfield.com>
Received: from webmail.nearfield.com (webmail.nearfield.com [63.200.6.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "webmail.nearfield.com", Issuer "NSI" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F195EDDF9D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 07:56:17 +1000 (EST)
Message-Id: <48C53825.9124.0071.0@nearfield.com>
Date: Mon, 08 Sep 2008 14:35:17 -0700
From: "Michael Carey" <MCarey@nearfield.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Re: Help getting USB keyboard active on
	MPC5200B&In-Reply-To=<GPECLCIGPLHEOMGPMCPAGENCFKAA.edjubenville@adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ed,

I have duplicated your problem with the Dell keyboard. =20
I then connected a Logitech keyboard and that worked.
I added a bunch of debug messages to track what was going on and I ended =
up in the function usb_find_interface_driver(...) in usb.c.

As far as I can tell, both keyboards are recognized by usb_match_id(...) =
in usb.c.

In the inner loop of that function;

728   id =3D usb_match_id(dev, interface, id);
729   if (id) {
730      down(&driver->serialize);
731      private =3D driver->probe(dev,ifnum,id);
732      up(&driver->serialize);
733      if (private !=3D NULL)
734         Break;
735   }
736 =20

For the Logitec keyboard, the usb_match_id(...) eventually finds a match =
and then calls driver->probe

- Result of Logitec probe -
keybdev_connect in drivers/usb/keybdev.c
keybdev.c: Adding keyboard: input1
input: USB HID v10.01 Keyboard [Logitech Logitech USB Keyboard] on =
usb1:4.0
usb:   usb_find_interface_driver in drivers/usb/usb.c

... and then claims the interface in usb_driver_claim_interface(...)


For the Dell keyboard,  the usb_match_id(...) eventually finds a match and =
then calls driver->probe.
But in this case, the probe function returns a null and the driver never =
claims an interface.

I got a little bit stuck after that.  I have not figured out how the probe =
function works so I was not able to dig deeper.

I do believe that in both cases, the driver name is 'hid' and the id is =
0xC02315BC.

I was wondering if anyone else knows how to connect a Dell keyboard to =
this driver or why it is not accepted by this driver.
Until then, I'm off to 'Keyboards Etc.' to get a Logitech keyboard.

Regards,
Michael Carey
