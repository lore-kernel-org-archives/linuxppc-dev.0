Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3A9BDDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 11:47:31 +1000 (EST)
Subject: Re: [PATCH] add correct interrupt property for pegasos ide
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200704042042.15108.bzolnier@gmail.com>
References: <20070404111635.GA1855@aepfle.de>
	<200704042010.50088.bzolnier@gmail.com>
	<20070404181138.GA6050@aepfle.de>
	<200704042042.15108.bzolnier@gmail.com>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 11:47:18 +1000
Message-Id: <1175737638.30879.107.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Paul Mackeras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> There might be also the another issue here - the chipset claims fully native
> mode (prog-if 8f - taken from your previous mail) so driver takes IRQ value
> from dev->irq (which your patch fixes to be 14 instead of 20 if I'm reading
> it correctly) but in reality chipset seems to be still using legacy IRQs
> (14 for the primary port and 15 for the secondary one).  What IRQ value is
> reported by the libata for the secondary port?  Does the second port work?

It's a crackpot VIA chipset... it claims to be fully native but uses legacy
IRQs... go figure. So yes, we need a quirk. I don't have chipset specs
so I don't know if the driver can "detect" that though.

Ben.
