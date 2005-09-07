Return-Path: <broonie@projectcolo.org.uk>
Received: from kerouac.projectcolo.org.uk (kerouac.projectcolo.org.uk
	[80.71.3.114])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "kerouac.projectcolo.org.uk",
	Issuer "projectcolo.org.uk CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A7E8B6816B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 02:34:36 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by kerouac.projectcolo.org.uk (Postfix) with ESMTP id 05E307A002
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 17:34:29 +0100 (BST)
Received: from kerouac.projectcolo.org.uk ([127.0.0.1])
	by localhost (kerouac [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08795-06 for <linuxppc-embedded@ozlabs.org>;
	Wed, 7 Sep 2005 17:34:28 +0100 (BST)
Date: Wed, 7 Sep 2005 17:34:28 +0100
From: Mark Brown <broonie@sirena.org.uk>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050907163428.GA8522@projectcolo.org.uk>
References: <20050831122556.GA474@projectcolo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050831122556.GA474@projectcolo.org.uk>
Subject: Re: Platform devices on MPC8245
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 31, 2005 at 01:26:00PM +0100, Mark Brown wrote:

> I'm having some trouble using the platform device support for the
> MPC8245 using memory map B, set up using mpc10x_bridge_init().  When
> that function registers the host bridge it registers addresses
> 0x80000000-0xfebfffff for the bridge but by default (with EUMB mapped to
> MPC10X_MAPB_EUMB_BASE) the platform devices on the chip are also within
> this address range.  The problem I'm seeing is that when
> platform_device_register() comes to call request_resource() on the
> devices that call fails because the addresses have already been
> allocated to the PCI host bridge.

Does anyone have any suggestions as to what I'm doing wrong with this?
Using kernel 2.6.13 I am currently working around the issue by making
the platform bus use insert_resource() rather than request_resource() as
in the patch below but this really seems like the wrong solution.

--- linux-2.6.13/drivers/base/platform.c        2005-08-29 00:41:01.000000000 +0100
+++ linux/drivers/base/platform.c       2005-09-07 17:26:10.459969600 +0100
@@ -149,7 +149,7 @@
                                p = &ioport_resource;
                }

-               if (p && request_resource(p, r)) {
+               if (p && insert_resource(p, r)) {
                        printk(KERN_ERR
                               "%s: failed to claim resource %d\n",
                               pdev->dev.bus_id, i);


-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
