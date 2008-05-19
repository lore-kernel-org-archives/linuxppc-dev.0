Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 46A12DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 04:42:40 +1000 (EST)
Date: Mon, 19 May 2008 22:42:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] CS4270 node is misplaced in the MPC8610 device tree
Message-ID: <20080519184238.GA17046@polina.dev.rtsoft.ru>
References: <1210804193-8908-1-git-send-email-timur@freescale.com>
	<4831C4F0.6060000@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4831C4F0.6060000@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 19, 2008 at 01:20:32PM -0500, Timur Tabi wrote:
> Timur Tabi wrote:
> > The CS4270 is using the second I2C bus, not the first, on the Freescale
> > MPC8610 HPCD, so its node in the device tree belongs under 'i2c@3100'
> > and not 'i2c@3000'.
> > 
> > Signed-off-by: Timur Tabi <timur@freescale.com>
> 
> Please disregard this patch.  It turns out that that both I2C controllers are
> connected to the same bus, so it technically doesn't matter which node a device
> is a child of.  However, tests show that sometimes one parent works, and
> sometimes the other parent works.

Hm... this should be controlled by the PIXIS' BRDCFG0's I2CSPAN and
SERSEL bits:

0: I2C1 and I2C2 buses are separated. System (boot sequencer EEPROM)
   is on I2C1, all others are on I2C2. MPC8610 SPI functions cannot be used.
1: I2C1 and I2C2 are bridged. MPC8610 SPI functions may be used. All I2C
   devices may be accessed via I2C1 controller and/or I2C2 (I2C2 depends on
   SERSEL setting).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
