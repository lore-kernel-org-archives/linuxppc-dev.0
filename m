Return-Path: <leitao@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp05.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D70EB7CA1
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 05:44:26 +1100 (EST)
Received: from mailhub1.br.ibm.com (mailhub1.br.ibm.com [9.18.232.109])
	by e24smtp05.br.ibm.com (8.14.3/8.13.1) with ESMTP id o0RIXZ2W031592
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 16:33:35 -0200
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0RIkjCZ967108
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 16:46:45 -0200
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0RIiLVm020398
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 16:44:21 -0200
From: leitao@linux.vnet.ibm.com
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] eeh: fixing pci_dev dependency
Date: Wed, 27 Jan 2010 12:43:05 -0600
Message-Id: <930155d7427ae670cd2add220649c6490f68d0d4.1264617281.git.root@sanx1002.austin.ibm.com>
In-Reply-To: <0642ead63df1b9fdced24750eb0aea940f0408b7.1264617281.git.root@sanx1002.austin.ibm.com>
References: <0642ead63df1b9fdced24750eb0aea940f0408b7.1264617281.git.root@sanx1002.austin.ibm.com>
In-Reply-To: <0642ead63df1b9fdced24750eb0aea940f0408b7.1264617281.git.root@sanx1002.austin.ibm.com>
References: <0642ead63df1b9fdced24750eb0aea940f0408b7.1264617281.git.root@sanx1002.austin.ibm.com>
Cc: Linas Vepstas <linasvepstas@gmail.com>,
	Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently pci_dev can be null when EEH is in action. This patch
just assure that we pci_dev is not NULL before calling pci_dev_put.

Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
---
 arch/powerpc/platforms/pseries/eeh_event.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
index ec5df8f..7956e46 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -85,7 +85,8 @@ static int eeh_event_handler(void * dummy)
 	pdn = handle_eeh_events(event);
 
 	eeh_clear_slot(event->dn, EEH_MODE_RECOVERING);
-	pci_dev_put(event->dev);
+	if (event->dev)
+		pci_dev_put(event->dev);
 	kfree(event);
 	mutex_unlock(&eeh_event_mutex);
 
-- 
1.6.0.2
