Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF5C5DDE4A
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 23:23:12 +1000 (EST)
Message-ID: <46D81638.6050509@pobox.com>
Date: Fri, 31 Aug 2007 09:23:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/7] Generic bitbanged MDIO library
References: <20070817175357.GA9218@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070817175357.GA9218@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Previously, bitbanged MDIO was only supported in individual
> hardware-specific drivers.  This code factors out the higher level
> protocol implementation, reducing the hardware-specific portion to
> functions setting direction, data, and clock.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  drivers/net/phy/Kconfig        |    9 ++
>  drivers/net/phy/Makefile       |    1 +
>  drivers/net/phy/mdio-bitbang.c |  187 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mdio-bitbang.h   |   42 +++++++++
>  4 files changed, 239 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/phy/mdio-bitbang.c
>  create mode 100644 include/linux/mdio-bitbang.h

I cannot ACK this, nor do I want to see it merged, until users appear 
and have been reviewed alongside this.  I do not see any fs_enet patches 
that actually use this.

five-second-glance comments:

* "mdio_bitbang_" is a long prefix.  consider "mdiobb_" or somesuch

* the delay (where you call ndelay()) is not guaranteed without a flush 
of some sort

* how widely applicable is this "generic" library?  have you converted 
any non-embedded drivers over to it?
