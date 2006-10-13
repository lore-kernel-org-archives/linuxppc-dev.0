Return-Path: <mgreer@mvista.com>
Date: Thu, 12 Oct 2006 20:59:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: change bad ptr handling in simple_alloc
Message-ID: <20061013035946.GB32327@mag.az.mvista.com>
References: <20061012013223.GA9143@mag.az.mvista.com>
	<20061012013544.GE9143@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061012013544.GE9143@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some minor changes to simple_alloc.c:
 - Make simple_realloc return NULL if the ptr passed to it wasn't from a
   previous simple_malloc or simple_realloc.
 - Change tracking of base of unused memory.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 simple_alloc.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)
---

diff --git a/arch/powerpc/boot/simple_alloc.c b/arch/powerpc/boot/simple_alloc.c
index 478a381..7cc3389 100644
--- a/arch/powerpc/boot/simple_alloc.c
+++ b/arch/powerpc/boot/simple_alloc.c
@@ -26,6 +26,7 @@ static struct alloc_info {
 
 static u32 tbl_entries;
 static u32 alloc_min;
+static u32 next_base;
 static u32 space_left;
 
 /*
@@ -36,20 +37,20 @@ static u32 space_left;
 static void *simple_malloc(u32 size)
 {
 	u32 i;
-	struct alloc_info *p = alloc_tbl, *prevp = NULL;
+	struct alloc_info *p = alloc_tbl;
 
 	if (size == 0)
 		goto err_out;
 
 	size = _ALIGN_UP(size, alloc_min);
 
-	for (i=0; i<tbl_entries; i++) {
+	for (i=0; i<tbl_entries; i++, p++)
 		if (!(p->flags & ENTRY_BEEN_USED)) { /* never been used */
 			if (size <= space_left) {
-				if (i > 0)
-					p->base = prevp->base + prevp->size;
+				p->base = next_base;
 				p->size = size;
 				p->flags = ENTRY_BEEN_USED | ENTRY_IN_USE;
+				next_base += size;
 				space_left -= size;
 				return (void *)p->base;
 			}
@@ -60,8 +61,6 @@ static void *simple_malloc(u32 size)
 			p->flags |= ENTRY_IN_USE;
 			return (void *)p->base;
 		}
-		prevp = p++;
-	}
 err_out:
 	return NULL;
 }
@@ -103,10 +102,12 @@ static void *simple_realloc(void *ptr, u
 		return NULL;
 	}
 
-	/* also malloc if ptr didn't come from simple_malloc/realloc */
-	if ((ptr == NULL) || ((p = simple_find_entry(ptr)) == NULL))
+	if (ptr == NULL)
 		return simple_malloc(size);
 
+	p = simple_find_entry(ptr);
+	if (p == NULL) /* ptr not from simple_malloc/simple_realloc */
+		return NULL;
 	if (size <= p->size) /* fits in current block */
 		return ptr;
 
@@ -136,7 +137,7 @@ void *simple_alloc_init(char *base, u32 
 
 	heap_base = _ALIGN_UP((u32)alloc_tbl + tbl_size, alloc_min);
 
-	alloc_tbl[0].base = heap_base;
+	next_base = heap_base;
 	space_left = heap_size;
 
 	platform_ops.malloc = simple_malloc;
