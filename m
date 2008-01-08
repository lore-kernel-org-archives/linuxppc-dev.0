Return-Path: <SRS0+1cf899198c2a722d61a5+1598+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85245DDF20
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 18:59:02 +1100 (EST)
Subject: Re: [PATCH 2/4] nand base: Give drivers a chance to do late
	initialization.
From: David Woodhouse <dwmw2@infradead.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20071213171551.GA4459@loki.buserror.net>
References: <20071213171551.GA4459@loki.buserror.net>
Content-Type: text/plain
Date: Tue, 08 Jan 2008 07:57:49 +0000
Message-Id: <1199779069.4111.379.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-12-13 at 11:15 -0600, Scott Wood wrote:
> Some nand controllers, such as the Freescale enhanced local bus controller,
> need to do late initialization based on details of the chip that has been
> probed, such as chip size, large/small pages, etc.  A late_init() callback
> method is added to allow this.

Do you really need this so late? Can't it be done between
nand_scan_ident() and nand_scan_tail()? That's why we split nand_scan()
into two in the first place...

-- 
dwmw2
