Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ADA61A0C0D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 06:46:11 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 10 Feb 2015 12:46:09 -0700
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 41125C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:37:11 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1AJjol529425888
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 19:45:59 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1AJjQ5Z003301
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:45:26 -0500
Received: from [9.41.149.215] (dhcp-9-41-149-215.austin.ibm.com [9.41.149.215])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t1AJjQY2002232
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:45:26 -0500
Message-ID: <54DA5FBD.406@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 13:45:01 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/5] pseries: Export the acquire/release drc index routines
References: <54DA5EC1.2060403@linux.vnet.ibm.com>
In-Reply-To: <54DA5EC1.2060403@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export the routines to acquire and release a drc index.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/pseries.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 1796c54..239bee5 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -60,6 +60,8 @@ extern struct device_node *dlpar_configure_connector(__be32,
 						struct device_node *);
 extern int dlpar_attach_node(struct device_node *);
 extern int dlpar_detach_node(struct device_node *);
+int dlpar_acquire_drc(u32 drc_index);
+int dlpar_release_drc(u32 drc_index);
 
 /* PCI root bridge prepare function override for pseries */
 struct pci_host_bridge;
