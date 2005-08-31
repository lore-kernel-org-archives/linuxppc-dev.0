Return-Path: <broonie@projectcolo.org.uk>
Received: from kerouac.projectcolo.org.uk (kerouac.projectcolo.org.uk
	[80.71.3.114])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "kerouac.projectcolo.org.uk",
	Issuer "projectcolo.org.uk CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 726BA6810D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 22:47:00 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by kerouac.projectcolo.org.uk (Postfix) with ESMTP id 74E3379D9D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 13:26:00 +0100 (BST)
Received: from kerouac.projectcolo.org.uk ([127.0.0.1])
	by localhost (kerouac [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04035-04 for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 13:26:00 +0100 (BST)
Date: Wed, 31 Aug 2005 13:26:00 +0100
From: Mark Brown <broonie@sirena.org.uk>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050831122556.GA474@projectcolo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Platform devices on MPC8245
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm having some trouble using the platform device support for the
MPC8245 using memory map B, set up using mpc10x_bridge_init().  When
that function registers the host bridge it registers addresses
0x80000000-0xfebfffff for the bridge but by default (with EUMB mapped to
MPC10X_MAPB_EUMB_BASE) the platform devices on the chip are also within
this address range.  The problem I'm seeing is that when
platform_device_register() comes to call request_resource() on the
devices that call fails because the addresses have already been
allocated to the PCI host bridge.

I'm sure I must be missing something really obvious about how this is
supposed to work but I can't for the life of me see what.  Changing the
platform code to use insert_resource() rather than request_resource()
allows the devices to register and be used but that seems rather too
drastic to be it.

Thanks for any help.

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
