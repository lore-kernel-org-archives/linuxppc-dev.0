Return-Path: <romieu@fr.zoreil.com>
Received: from fr.zoreil.com (electric-eye.fr.zoreil.com [213.41.134.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2068967D9A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 05:56:59 +1000 (EST)
Date: Wed, 27 Jul 2005 21:56:03 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andy Fleming <afleming@freescale.com>
Message-ID: <20050727195603.GA29148@electric-eye.fr.zoreil.com>
References: <1122487708.20267@shark.he.net>
	<EDA214E7-5655-4900-AF1A-FC736681DC74@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EDA214E7-5655-4900-AF1A-FC736681DC74@freescale.com>
Cc: Netdev <netdev@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC PATCH 1/4] PHY Abstraction Layer III (now with more
	splitiness)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andy Fleming <afleming@freescale.com> :
[kcalloc]
> Should we move the function, then, to include/linux/slab.h?  Or  
> somewhere else?

It is already in mm/slab.c

[rc = request_irq(...)]

It appears in drivers/net/*c. Jeff Garzik used to suggest something
similar but it does not matter as long as you do not need to return
an error status (KERN_ERR is probably a bit too strong then).

[initialization of struct phy_setting settings]

#define	NITZ(d,t,s)	{ .speed = s, .duplex = d, .setting = t }

static struct phy_setting settings[] = {
       NITZ(DUPLEX_FULL, SUPPORTED_10000baseT_Full,	10000),
       NITZ(DUPLEX_FULL, SUPPORTED_1000baseT_Full,	SPEED_1000),
       NITZ(DUPLEX_HALF, SUPPORTED_1000baseT_Half,	SPEED_1000),
       NITZ(DUPLEX_FULL, SUPPORTED_100baseT_Full,	SPEED_100),
       NITZ(DUPLEX_HALF, SUPPORTED_100baseT_Half,	SPEED_100),
       NITZ(DUPLEX_FULL, SUPPORTED_10baseT_Full,	SPEED_10),
       NITZ(DUPLEX_HALF, SUPPORTED_10baseT_Half,	SPEED_10),
};

#undef NITZ

--
Ueimor
