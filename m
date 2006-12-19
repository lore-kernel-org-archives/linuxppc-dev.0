Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63F53DDF16
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 07:00:54 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBJK0ZKO002163
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 15:00:35 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBJK0Yhe536020
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 13:00:35 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBJK0YOo011150
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 13:00:34 -0700
Date: Tue, 19 Dec 2006 14:00:34 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc initialize pci device channel state.
Message-ID: <20061219200034.GH5506@austin.ibm.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,
This patch is critical. Even if the last few looked to be 
of low importance, this one is not.

--linas

Initialize the pci device pci channel state. This is critical 
for having the pci_channel_offline() routine (in pci.h) to 
function correctly.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/kernel/pci_64.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.19-git7/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-2.6.19-git7.orig/arch/powerpc/kernel/pci_64.c	2006-12-19 13:50:53.000000000 -0600
+++ linux-2.6.19-git7/arch/powerpc/kernel/pci_64.c	2006-12-19 13:53:29.000000000 -0600
@@ -360,6 +360,7 @@ struct pci_dev *of_create_pci_dev(struct
 	DBG("    class: 0x%x\n", dev->class);
 
 	dev->current_state = 4;		/* unknown power state */
+	dev->error_state = pci_channel_io_normal;
 
 	if (!strcmp(type, "pci") || !strcmp(type, "pciex")) {
 		/* a PCI-PCI bridge */
