Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C25C5DDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 02:35:34 +1100 (EST)
Date: Wed, 21 Nov 2007 16:35:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: apw@shadowen.org
Subject: annoying prinkts during vmemmap initialization
Message-ID: <20071121153526.GA23589@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andi,

your patch 'ppc64: SPARSEMEM_VMEMMAP support' adds the following two lines:

+               printk(KERN_WARNING "vmemmap %08lx allocated at %p, "
+                                       "physical %p.\n", start, p, __pa(p));

in a loop around basically every page.  That's a lot of flooding (with
the wrong printk level, btw) and really slows down booting my cell blade
a lot (these only have a very slow serial over lan console).

Any reason to keep this?  And if yes can we please make it conditional
on some kind of vmemmap_debug boot option?
