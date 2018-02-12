Return-Path: <richard@nod.at>
Received: from lilium.sigma-star.at (lilium.sigma-star.at [109.75.188.150])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgKSm2F6kzF0sV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:04:08 +1100 (AEDT)
From: Richard Weinberger <richard@nod.at>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, linux-mtd@lists.infradead.org,
 Joern Engel <joern@lazybastard.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 Edward Cree <ecree@solarflare.com>, Bert Kenward <bkenward@solarflare.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, devel@driverdev.osuosl.org,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/5] mtd: Unconditionally update ->fail_addr and ->addr in
 part_erase()
Date: Mon, 12 Feb 2018 23:05:19 +0100
Message-ID: <1548497.hsdsyCj9Tz@blindfold>
In-Reply-To: <20180212210311.23244-5-boris.brezillon@bootlin.com>
References: <20180212210311.23244-1-boris.brezillon@bootlin.com>
 <20180212210311.23244-5-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Montag, 12. Februar 2018, 22:03:10 CET schrieb Boris Brezillon:
> ->fail_addr and ->addr can be updated no matter the result of
> parent->_erase(), we just need to remove the code doing the same thing
> in mtd_erase_callback() to avoid adjusting those fields twice.
> 
> Note that this can be done because all MTD users have been converted to
> not pass an erase_info->callback() and are thus only taking the
> ->addr_fail and ->addr fields into account after part_erase() has
> returned.
> 
> While we're at it, get rid of the erase_info->mtd field which was only
> needed to let mtd_erase_callback() get the partition device back.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
