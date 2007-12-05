Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (pip10.gyao.ne.jp [61.122.117.248])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33F37DE0B6
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 11:57:08 +1100 (EST)
Date: Wed, 5 Dec 2007 09:56:43 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 4/4] [libata] pata_platform: s/ioport_shift/reg_shift/g
Message-ID: <20071205005643.GA28860@linux-sh.org>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204170745.GD15599@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204170745.GD15599@localhost.localdomain>
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 08:07:45PM +0300, Anton Vorontsov wrote:
> This patch renames ioport_shift member of pata_platform_info
> structure to reg_shift. Users of pata_platform are followed
> appropriately.
> 
> Rationale of that change is: shifting applies to the whole memory
> mapped region, not only to the command block of the ATA registers,
> despite the fact that shifting is meaningless for ctl register.
> 
It's called ioport_shift because of the fact it shifts an ioport, namely
a struct ata_ioport *. We could rename it, but I really don't see the
point. If you don't like the choice of name on your platform, add a
comment to your platform-specific code noting this particular outrage so
it can be grepped for by future generations ;-)

Nacked-by: Paul Mundt <lethal@linux-sh.org>
