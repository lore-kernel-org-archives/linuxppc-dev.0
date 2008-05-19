Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7302FDE38D
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 05:20:58 +1000 (EST)
Message-ID: <4831D312.2050304@freescale.com>
Date: Mon, 19 May 2008 14:20:50 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] CS4270 node is misplaced in the MPC8610 device tree
References: <1210804193-8908-1-git-send-email-timur@freescale.com>
	<4831C4F0.6060000@freescale.com>
	<20080519184238.GA17046@polina.dev.rtsoft.ru>
In-Reply-To: <20080519184238.GA17046@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> Hm... this should be controlled by the PIXIS' BRDCFG0's I2CSPAN and
> SERSEL bits:

Since these pins should not have changed from one kernel version to another, it
doesn't explain how my device "jumped" from I2C2 to I2C1.  I'm debugging this now.

> 1: I2C1 and I2C2 are bridged. MPC8610 SPI functions may be used. All I2C
>    devices may be accessed via I2C1 controller and/or I2C2 (I2C2 depends on
>    SERSEL setting).

I believe this is wrong.  The chip documentation says that the pin controlled by
I2CSPAN selects which of the two inputs to use.  It does not bridge.

-- 
Timur Tabi
Linux kernel developer at Freescale
