Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E6361DE04C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 16:05:16 +1000 (EST)
Date: Fri, 12 Oct 2007 16:05:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix iSeries_hpte_insert prototype
Message-Id: <20071012160514.0d61713d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 1189be6508d45183013ddb82b18f4934193de274 ([POWERPC] Use 1TB
segments) added an argument to hpte_insert.

Also make iSeries_hpte_insert static.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/htab.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/htab.c b/arch/powerpc/platforms/iseries/htab.c
index 15a7097..f99c6c4 100644
--- a/arch/powerpc/platforms/iseries/htab.c
+++ b/arch/powerpc/platforms/iseries/htab.c
@@ -39,9 +39,9 @@ static inline void iSeries_hunlock(unsigned long slot)
 	spin_unlock(&iSeries_hlocks[(slot >> 4) & 0x3f]);
 }
 
-long iSeries_hpte_insert(unsigned long hpte_group, unsigned long va,
+static long iSeries_hpte_insert(unsigned long hpte_group, unsigned long va,
 			 unsigned long pa, unsigned long rflags,
-			 unsigned long vflags, int psize)
+			 unsigned long vflags, int psize, int ssize)
 {
 	long slot;
 	struct hash_pte lhpte;
-- 
1.5.3.4
