Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 6979BDDDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 15:21:27 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so207565waf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 21:21:25 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/cpm2: fix building fs_enet driver as a module.
To: galak@kernel.crashing.org, benh@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Date: Wed, 18 Mar 2009 22:21:23 -0600
Message-ID: <20090319041752.8666.46540.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Building the fs_enet driver as a modules fails because it cannot
access the global cpm2_immr symbol.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Hey Ben and Kumar,

Just found this while testing some unrelated changes.  Technically
this is a bug fix that should go into 2.6.29, but it looks like an
old problem and probably nobody is getting bitten by it.  I don't
think the world is going to end if it misses the 2.6.29 release.

g.

 arch/powerpc/sysdev/cpm2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index f1c3395..021480e 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -52,6 +52,7 @@ cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor space */
  * the communication processor devices.
  */
 cpm2_map_t __iomem *cpm2_immr;
+EXPORT_SYMBOL(cpm2_immr);
 
 #define CPM_MAP_SIZE	(0x40000)	/* 256k - the PQ3 reserve this amount
 					   of space for CPM as it is larger
