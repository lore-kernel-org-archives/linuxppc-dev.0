Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3FF9EDE0C4
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 11:01:28 +1100 (EST)
Date: Wed, 7 Jan 2009 11:01:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/cell: use correct types in beat files
Message-Id: <20090107110123.a3f10ec6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Molnar <mingo@elte.hu>, Ingo,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Ingo Molnar <mingo@elte.hu>

Only pass the address of a u64 if that is what the function requires.

[Split out of a larger patch - sfr]
[update comment - sfr]
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/cell/beat_htab.c |   21 +++++++++++----------
 arch/powerpc/platforms/cell/beat_udbg.c |    4 ++--
 drivers/char/hvc_beat.c                 |    4 ++--
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/cell/beat_htab.c b/arch/powerpc/platforms/cell/beat_htab.c
index 2e67bd8..35b1ec4 100644
--- a/arch/powerpc/platforms/cell/beat_htab.c
+++ b/arch/powerpc/platforms/cell/beat_htab.c
@@ -44,8 +44,8 @@ static DEFINE_SPINLOCK(beat_htab_lock);
 
 static inline unsigned int beat_read_mask(unsigned hpte_group)
 {
-	unsigned long hpte_v[5];
 	unsigned long rmask = 0;
+	u64 hpte_v[5];
 
 	beat_read_htab_entries(0, hpte_group + 0, hpte_v);
 	if (!(hpte_v[0] & HPTE_V_BOLTED))
@@ -93,8 +93,7 @@ static long beat_lpar_hpte_insert(unsigned long hpte_group,
 				  int psize, int ssize)
 {
 	unsigned long lpar_rc;
-	unsigned long slot;
-	unsigned long hpte_v, hpte_r;
+	u64 hpte_v, hpte_r, slot;
 
 	/* same as iseries */
 	if (vflags & HPTE_V_SECONDARY)
@@ -153,8 +152,9 @@ static long beat_lpar_hpte_remove(unsigned long hpte_group)
 
 static unsigned long beat_lpar_hpte_getword0(unsigned long slot)
 {
-	unsigned long dword0, dword[5];
+	unsigned long dword0;
 	unsigned long lpar_rc;
+	u64 dword[5];
 
 	lpar_rc = beat_read_htab_entries(0, slot & ~3UL, dword);
 
@@ -170,7 +170,7 @@ static void beat_lpar_hptab_clear(void)
 	unsigned long size_bytes = 1UL << ppc64_pft_size;
 	unsigned long hpte_count = size_bytes >> 4;
 	int i;
-	unsigned long dummy0, dummy1;
+	u64 dummy0, dummy1;
 
 	/* TODO: Use bulk call */
 	for (i = 0; i < hpte_count; i++)
@@ -189,7 +189,8 @@ static long beat_lpar_hpte_updatepp(unsigned long slot,
 				    int psize, int ssize, int local)
 {
 	unsigned long lpar_rc;
-	unsigned long dummy0, dummy1, want_v;
+	u64 dummy0, dummy1;
+	unsigned long want_v;
 
 	want_v = hpte_encode_v(va, psize, MMU_SEGSIZE_256M);
 
@@ -255,7 +256,8 @@ static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
 					  unsigned long ea,
 					  int psize, int ssize)
 {
-	unsigned long lpar_rc, slot, vsid, va, dummy0, dummy1;
+	unsigned long lpar_rc, slot, vsid, va;
+	u64 dummy0, dummy1;
 
 	vsid = get_kernel_vsid(ea, MMU_SEGSIZE_256M);
 	va = (vsid << 28) | (ea & 0x0fffffff);
@@ -276,7 +278,7 @@ static void beat_lpar_hpte_invalidate(unsigned long slot, unsigned long va,
 {
 	unsigned long want_v;
 	unsigned long lpar_rc;
-	unsigned long dummy1, dummy2;
+	u64 dummy1, dummy2;
 	unsigned long flags;
 
 	DBG_LOW("    inval : slot=%lx, va=%016lx, psize: %d, local: %d\n",
@@ -315,8 +317,7 @@ static long beat_lpar_hpte_insert_v3(unsigned long hpte_group,
 				  int psize, int ssize)
 {
 	unsigned long lpar_rc;
-	unsigned long slot;
-	unsigned long hpte_v, hpte_r;
+	u64 hpte_v, hpte_r, slot;
 
 	/* same as iseries */
 	if (vflags & HPTE_V_SECONDARY)
diff --git a/arch/powerpc/platforms/cell/beat_udbg.c b/arch/powerpc/platforms/cell/beat_udbg.c
index 6b418f6..350735b 100644
--- a/arch/powerpc/platforms/cell/beat_udbg.c
+++ b/arch/powerpc/platforms/cell/beat_udbg.c
@@ -40,8 +40,8 @@ static void udbg_putc_beat(char c)
 }
 
 /* Buffered chars getc */
-static long inbuflen;
-static long inbuf[2];	/* must be 2 longs */
+static u64 inbuflen;
+static u64 inbuf[2];	/* must be 2 u64s */
 
 static int udbg_getc_poll_beat(void)
 {
diff --git a/drivers/char/hvc_beat.c b/drivers/char/hvc_beat.c
index 91cdb35..0afc8b8 100644
--- a/drivers/char/hvc_beat.c
+++ b/drivers/char/hvc_beat.c
@@ -44,7 +44,7 @@ static int hvc_beat_get_chars(uint32_t vtermno, char *buf, int cnt)
 	static unsigned char q[sizeof(unsigned long) * 2]
 		__attribute__((aligned(sizeof(unsigned long))));
 	static int qlen = 0;
-	unsigned long got;
+	u64 got;
 
 again:
 	if (qlen) {
@@ -63,7 +63,7 @@ again:
 		}
 	}
 	if (beat_get_term_char(vtermno, &got,
-		((unsigned long *)q), ((unsigned long *)q) + 1) == 0) {
+		((u64 *)q), ((u64 *)q) + 1) == 0) {
 		qlen = got;
 		goto again;
 	}
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
