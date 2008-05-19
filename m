Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CFB25DDEF3
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 06:17:47 +1000 (EST)
Message-ID: <4831E046.6000001@freescale.com>
Date: Mon, 19 May 2008 15:17:10 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] CS4270 node is misplaced in the MPC8610 device tree
References: <1210804193-8908-1-git-send-email-timur@freescale.com>	<4831C4F0.6060000@freescale.com>	<20080519184238.GA17046@polina.dev.rtsoft.ru>
	<4831D312.2050304@freescale.com>
In-Reply-To: <4831D312.2050304@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	Sun York-R58495 <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
>> Hm... this should be controlled by the PIXIS' BRDCFG0's I2CSPAN and
>> SERSEL bits:
> 
> Since these pins should not have changed from one kernel version to another, it
> doesn't explain how my device "jumped" from I2C2 to I2C1.  I'm debugging this now.

I found the problem.  Your patch "86xx: mpc8610_hpcd: fix second serial port"
fixes it.

The original code moved the I2C devices from I2C1 to I2C2.  On R1 boards, the
default for I2CSPAN was 1 because the chip used on those boards would bridge the
two buses together if I2CSPAN==1.  On R3 boards, a different chip is used, and
I2CSPAN==1 means to use I2C2 instead of I2C1.  On R1 boards, the default for
BRDCFG0 is 0xBD, but on R3 boards it's 0xB8.  So when
mpc8610hpcd_set_monitor_port() wrote 0xBD to BRDCFG0, it moved the I2C devices
from I2C1 to I2C2.

I also had a hard time pinpointing this code because
mpc8610hpcd_set_monitor_port() is called only when the DIU is enabled.  Since I
don't have anything attached to my DIU port, I don't always enable the DIU.  So
some of my kernels had DIU support, and some of them didn't!  Those kernels that
have DIU enabled but not your patch will move the devices to I2C2.  I was
running one of those kernels when I posted my patch.

So in summary, this patch "CS4270 node is misplaced in the MPC8610 device tree"
should not be applied.  The I2C devices should stay on I2C1.

-- 
Timur Tabi
Linux kernel developer at Freescale
