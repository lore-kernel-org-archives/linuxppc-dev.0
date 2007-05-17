Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 609B6DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 14:46:35 +1000 (EST)
Subject: eeh bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 17 May 2007 14:46:24 +1000
Message-Id: <1179377184.32247.274.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linas !

While debugging some other issues, I had a couple of oopses caused by
what looks like a bug in EEH:

When an RTAS PCI config space call returns all f's, we do an eeh error
check by calling eeh_dn_check_failure(pdn->node, NULL);

The problem is that second argument... NULL for the pci_dev *. It looks
like the EEH code will try to printk pci_name of that and later on
dereference it within eehd, thus causing an oops.

I'm not sure what's the best way to fix it and have no time to dig right
now though I suppose one could walk all PCI devices in the system to
look for a match with the dev node.

Though if for some reason we don't find a match, I think we should still
handle NULL's gracefully.

Cheers,
Ben.
