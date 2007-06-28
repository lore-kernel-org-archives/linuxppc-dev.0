Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 9A3C4DDF7E
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 20:20:18 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id E924F14314
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 12:20:13 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14728-08 for <linuxppc-dev@ozlabs.org>;
	Thu, 28 Jun 2007 12:20:13 +0200 (CEST)
Message-ID: <46838B54.2010806@semihalf.com>
Date: Thu, 28 Jun 2007 12:20:04 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: PCI IO range limitation
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

Trying to change PCI IO window base for 52xx target I found that
we are pretty much limited to a "0" offset only.

pci_process_bridge_OF_ranges() will not process any IO range that has
addresses set to anything else.

956:      case 1:         /* I/O space */
957:               if (ranges[2] != 0)
958:                       break;

When this range[2] checking is removed from
pci_process_bridge_OF_ranges() kernel boots ok with the non-zero PCI IO
base, but the PCI device I am using (e100) will not work.

I guess that with the above dropping of non-zero based PCI IO ranges
this is not supposed to be working. But does anyone know why?

Thanks,
Marian
