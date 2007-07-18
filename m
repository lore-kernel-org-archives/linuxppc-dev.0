Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE588DEF47
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:51 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1Zk7B027640
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:46 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1Zj7c001514
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:45 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1B4Pg007935
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:05 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id ED657AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:44 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZiK4015395
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:44 -0500
Date: Tue, 17 Jul 2007 20:35:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 34/61] cpm2: Use the global cpm2_immr rather than
	ioremapping() all over the place.
Message-ID: <20070718013544.GF15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 include/asm-powerpc/fs_pd.h |   19 +++----------------
 1 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index c624915..2179a5a 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -23,22 +23,9 @@
 #include <asm/mpc85xx.h>
 #endif
 
-#define cpm2_map(member)						\
-({									\
-	u32 offset = offsetof(cpm2_map_t, member);			\
-	void *addr = ioremap (CPM_MAP_ADDR + offset,			\
-			      sizeof( ((cpm2_map_t*)0)->member));	\
-	addr;								\
-})
-
-#define cpm2_map_size(member, size)					\
-({									\
-	u32 offset = offsetof(cpm2_map_t, member);			\
-	void *addr = ioremap (CPM_MAP_ADDR + offset, size);		\
-	addr;								\
-})
-
-#define cpm2_unmap(addr)	iounmap(addr)
+#define cpm2_map(member) (&cpm2_immr->member)
+#define cpm2_map_size(member, size) (&cpm2_immr->member)
+#define cpm2_unmap(addr) do {} while(0)
 #endif
 
 #ifdef CONFIG_8xx
-- 
1.5.0.3
