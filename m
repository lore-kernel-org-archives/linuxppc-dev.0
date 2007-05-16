Return-Path: <tnt@246tNt.com>
Received: from outmx013.isp.belgacom.be (outmx013.isp.belgacom.be
	[195.238.5.64])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EA84DDF1B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 18:19:04 +1000 (EST)
Received: from outmx013.isp.belgacom.be (localhost [127.0.0.1])
	by outmx013.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l4G8IeEb003968
	for <linuxppc-embedded@ozlabs.org>; Wed, 16 May 2007 10:18:41 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <464ABE97.7090603@246tNt.com>
Date: Wed, 16 May 2007 10:19:35 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Domen Puncer <domen@coderock.org>
Subject: Re: [PATCH] mpc52xx_psc_spi: fix it for CONFIG_PPC_MERGE
References: <20070516073707.GD9667@nd47.coderock.org>
In-Reply-To: <20070516073707.GD9667@nd47.coderock.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	Dragos Carp <dragos.carp@toptica.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Well, this comment is not about the patch but about the driver it self,
I didn't see it before today.
So here's a few things I see from a quick glance at the code :

 - Chaning port_config in the driver is just wrong ... you should _not_
do that. That should have been setup by the bootloader or at worse in
the platform setup code.
 - You do read/write/modify operation on CDM shared register
(clk_enables) from a driver, you should have added something in common
52xx code to do theses with proper locking.
 - MPC52xx_PA(MPC52xx_PSCx_OFFSET(...)) ??? You should get that from the
resource of the platform_device. This macro is just there for early
console stuff.
 - You can get f_system from the device tree instead of just assuming
it's 512 MHz. It probably need to be done the same way it's done to find
ipb_freq.
 - Would have been nice to be able to somehow configure MCLK rather than
#define it
 - I hope to remove all arch/ppc stuff by 2.6.23 if I can make the
cuimage stuff work in arch/powerpc so just including the platform code
stuff for 1 kernel version ...


    Sylvain
