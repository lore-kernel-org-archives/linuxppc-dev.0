Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfssP0Kx1zDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 17:19:36 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id n23so14920176pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Jun 2017 00:19:36 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 rashmica.g@gmail.com, labbott@redhat.com,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 9/9] powerpc/mm/ptdump: Dump the first entry of the linear
 mapping as well
Date: Sat,  3 Jun 2017 17:18:43 +1000
Message-Id: <20170603071843.11966-10-bsingharora@gmail.com>
In-Reply-To: <20170603071843.11966-1-bsingharora@gmail.com>
References: <20170603071843.11966-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The check in hpte_find() should be < and not <= for PAGE_OFFSET

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/dump_hashpagetable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/dump_hashpagetable.c b/arch/powerpc/mm/dump_hashpagetable.c
index c6b900f..b1c144b 100644
--- a/arch/powerpc/mm/dump_hashpagetable.c
+++ b/arch/powerpc/mm/dump_hashpagetable.c
@@ -335,7 +335,7 @@ static unsigned long hpte_find(struct pg_state *st, unsigned long ea, int psize)
 	unsigned long rpn, lp_bits;
 	int base_psize = 0, actual_psize = 0;
 
-	if (ea <= PAGE_OFFSET)
+	if (ea < PAGE_OFFSET)
 		return -1;
 
 	/* Look in primary table */
-- 
2.9.3
