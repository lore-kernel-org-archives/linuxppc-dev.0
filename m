Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 721FB685AC
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Oct 2005 07:46:25 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joerg Dorchain <joerg@dorchain.net>
In-Reply-To: <20051017183443.GB28756@Redstar.dorchain.net>
References: <20051014123823.GA9477@Redstar.dorchain.net>
	<1129327105.21765.39.camel@gaston>
	<20051016081759.GA2609@Redstar.dorchain.net>
	<1129452167.7620.34.camel@gaston>
	<20051017183443.GB28756@Redstar.dorchain.net>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 07:44:26 +1000
Message-Id: <1129585466.7620.90.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.13 ati (ibook) frambuffer problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I selected
> 
> CONFIG_FB
> CONFIG_FB_RADEON
> CONFIG_FB_RADEON_I2C
> CONFIG_BACKLIGHT_LCD_SUPPORT
> FRAMEBUFFER_CONSOLE
> 
> The 2.6.12 version worked. Would it make sense to post the complete
> .config?

Nope. What may help is a bit more debugging. For example, does the
kernel actually boots if you add "video=ofonly" to the kernel command
line.

Next would be to hack kernel/printk.c to call btext_drawstring() on the
printk buffer, though you'd have to add a global variable "foo" that you
test before doing that, and only set it to 1 from pmac_setup_arch() in
arch/ppc/platforms/pmac_setup.c

Ben.
