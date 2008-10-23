Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58801DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 08:54:31 +1100 (EST)
Date: Thu, 23 Oct 2008 23:41:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: odd change to drivers/net/ibm_newemac/core.c
Message-ID: <20081023214148.GA32322@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

+#ifdef CONFIG_IBM_NEW_EMAC_NO_FLOW_CONTROL
                        dev->features |= EMAC_FTR_NO_FLOW_CONTROL_40x;
+#else
+                       printk(KERN_ERR "%s: Flow control not disabled!\n",
+					np->full_name);
+                       return -ENXIO;
+#endif

What's this trying to do?  CONFIG_IBM_NEW_EMAC_NO_FLOW_CONTROL doesn't
exist anywhere, and it seems like an extremly strange idea for a config
option.  And "Flow control not disabled" is not an extremly useful error
message for users either..
