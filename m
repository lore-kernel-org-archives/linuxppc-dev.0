Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <2262db6d12c4eb44af3653ff65ecc8756dd280c4.1191387123.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Fail early in lmb_remove_region()
Date: Wed,  3 Oct 2007 14:52:29 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There was a query a while back about whether lmb_remove_region() was
correct to unconditionally decrement rgn->cnt:
  http://ozlabs.org/pipermail/linuxppc-dev/2007-March/033261.html

AFAICT there is no bug at the moment because the two callers ensure that
they only pass a value of r which is < rgn->cnt. However there's the
potential for a bug if a caller got that wrong. So to avoid such a bug
in future we should fail in lmb_remove_region() if the r value is out of
range.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/lmb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/lmb.c b/arch/powerpc/mm/lmb.c
index 8f4d2dc..e79e055 100644
--- a/arch/powerpc/mm/lmb.c
+++ b/arch/powerpc/mm/lmb.c
@@ -92,6 +92,8 @@ static void __init lmb_remove_region(struct lmb_region *rgn, unsigned long r)
 {
 	unsigned long i;
 
+	BUG_ON(r >= rgn->cnt);
+
 	for (i = r; i < rgn->cnt - 1; i++) {
 		rgn->region[i].base = rgn->region[i + 1].base;
 		rgn->region[i].size = rgn->region[i + 1].size;
-- 
1.5.1.3.g7a33b
