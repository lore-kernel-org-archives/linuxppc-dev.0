Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AAADCDDEE3
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 02:48:41 +1000 (EST)
Date: Thu, 26 Jul 2007 11:48:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] mpc832x_rdb.c: prevent using uninitialized variable
Message-ID: <20070726164833.GC28491@ld0162-tx32.am.freescale.net>
References: <20070726140139.GA5709@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070726140139.GA5709@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 26, 2007 at 06:01:39PM +0400, Anton Vorontsov wrote:
> If CONFIG_PCI undefined, np will be used uninitialized, thereby
> find_node_by_name(np, "par_io") will fail.

This is the wrong fix -- you should be passing NULL to the par_io call
rather than np.  Otherwise, if the par_io is earlier in the tree than the
pci, you won't find it.

-Scott
