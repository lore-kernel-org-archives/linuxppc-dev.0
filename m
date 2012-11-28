Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 331EE2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2012 06:42:46 +1100 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 28 Nov 2012 14:42:42 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AA0A7C90058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 14:42:39 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qASJgRYH37683422
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 14:42:28 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qASJgRgQ008345
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 14:42:27 -0500
Message-ID: <50B66922.9090209@linux.vnet.ibm.com>
Date: Wed, 28 Nov 2012 13:42:26 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] export of_reconfig_notifier_[register,unregister]
References: <20121128140308.abb21ec8f61553a2ed077fe3@canb.auug.org.au>
In-Reply-To: <20121128140308.abb21ec8f61553a2ed077fe3@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The of reconfiguration notification chains should be exported for use
by modules.

Signed-off-by:Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
Index: linux-next/drivers/of/base.c
===================================================================
--- linux-next.orig/drivers/of/base.c	2012-11-28 09:18:02.000000000 -0600
+++ linux-next/drivers/of/base.c	2012-11-28 11:05:00.000000000 -0600
@@ -1282,11 +1282,13 @@
 {
 	return blocking_notifier_chain_register(&of_reconfig_chain, nb);
 }
+EXPORT_SYMBOL_GPL(of_reconfig_notifier_register);
 
 int of_reconfig_notifier_unregister(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_unregister(&of_reconfig_chain, nb);
 }
+EXPORT_SYMBOL_GPL(of_reconfig_notifier_unregister);
 
 int of_reconfig_notify(unsigned long action, void *p)
 {
