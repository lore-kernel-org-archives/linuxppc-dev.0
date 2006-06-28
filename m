Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4265867A3E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 11:49:35 +1000 (EST)
Date: Wed, 28 Jun 2006 11:49:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] Clean up it_lp_queue.h
Message-Id: <20060628114910.46edad2d.sfr@canb.auug.org.au>
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

No more StudlyCaps.
Remove from a couple of places it is no longer needed.
Use C style comments.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/paca.c                |    1 -
 arch/powerpc/platforms/iseries/lpevents.c |   55 +++++++++++++++--------------
 arch/powerpc/platforms/iseries/proc.c     |    1 -
 include/asm-powerpc/iseries/it_lp_queue.h |   40 +++++++++++----------
 4 files changed, 48 insertions(+), 49 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index f505a88..a0bb354 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -16,7 +16,6 @@ #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/page.h>
 #include <asm/lppaca.h>
-#include <asm/iseries/it_lp_queue.h>
 #include <asm/iseries/it_lp_reg_save.h>
 #include <asm/paca.h>
 
diff --git a/arch/powerpc/platforms/iseries/lpevents.c b/arch/powerpc/platforms/iseries/lpevents.c
index 8ca7b93..2a9f81e 100644
--- a/arch/powerpc/platforms/iseries/lpevents.c
+++ b/arch/powerpc/platforms/iseries/lpevents.c
@@ -51,20 +51,21 @@ static unsigned lpEventHandlerPaths[HvLp
 static struct HvLpEvent * get_next_hvlpevent(void)
 {
 	struct HvLpEvent * event;
-	event = (struct HvLpEvent *)hvlpevent_queue.xSlicCurEventPtr;
+	event = (struct HvLpEvent *)hvlpevent_queue.hq_current_event;
 
 	if (hvlpevent_is_valid(event)) {
 		/* rmb() needed only for weakly consistent machines (regatta) */
 		rmb();
 		/* Set pointer to next potential event */
-		hvlpevent_queue.xSlicCurEventPtr += ((event->xSizeMinus1 +
-				LpEventAlign) / LpEventAlign) * LpEventAlign;
+		hvlpevent_queue.hq_current_event += ((event->xSizeMinus1 +
+				IT_LP_EVENT_ALIGN) / IT_LP_EVENT_ALIGN) *
+					IT_LP_EVENT_ALIGN;
 
 		/* Wrap to beginning if no room at end */
-		if (hvlpevent_queue.xSlicCurEventPtr >
-				hvlpevent_queue.xSlicLastValidEventPtr) {
-			hvlpevent_queue.xSlicCurEventPtr =
-				hvlpevent_queue.xSlicEventStackPtr;
+		if (hvlpevent_queue.hq_current_event >
+				hvlpevent_queue.hq_last_event) {
+			hvlpevent_queue.hq_current_event =
+				hvlpevent_queue.hq_event_stack;
 		}
 	} else {
 		event = NULL;
@@ -82,10 +83,10 @@ int hvlpevent_is_pending(void)
 	if (smp_processor_id() >= spread_lpevents)
 		return 0;
 
-	next_event = (struct HvLpEvent *)hvlpevent_queue.xSlicCurEventPtr;
+	next_event = (struct HvLpEvent *)hvlpevent_queue.hq_current_event;
 
 	return hvlpevent_is_valid(next_event) ||
-		hvlpevent_queue.xPlicOverflowIntPending;
+		hvlpevent_queue.hq_overflow_pending;
 }
 
 static void hvlpevent_clear_valid(struct HvLpEvent * event)
@@ -95,18 +96,18 @@ static void hvlpevent_clear_valid(struct
 	 * ie. on 64-byte boundaries.
 	 */
 	struct HvLpEvent *tmp;
-	unsigned extra = ((event->xSizeMinus1 + LpEventAlign) /
-						 LpEventAlign) - 1;
+	unsigned extra = ((event->xSizeMinus1 + IT_LP_EVENT_ALIGN) /
+				IT_LP_EVENT_ALIGN) - 1;
 
 	switch (extra) {
 	case 3:
-		tmp = (struct HvLpEvent*)((char*)event + 3 * LpEventAlign);
+		tmp = (struct HvLpEvent*)((char*)event + 3 * IT_LP_EVENT_ALIGN);
 		hvlpevent_invalidate(tmp);
 	case 2:
-		tmp = (struct HvLpEvent*)((char*)event + 2 * LpEventAlign);
+		tmp = (struct HvLpEvent*)((char*)event + 2 * IT_LP_EVENT_ALIGN);
 		hvlpevent_invalidate(tmp);
 	case 1:
-		tmp = (struct HvLpEvent*)((char*)event + 1 * LpEventAlign);
+		tmp = (struct HvLpEvent*)((char*)event + 1 * IT_LP_EVENT_ALIGN);
 		hvlpevent_invalidate(tmp);
 	}
 
@@ -120,7 +121,7 @@ void process_hvlpevents(struct pt_regs *
 	struct HvLpEvent * event;
 
 	/* If we have recursed, just return */
-	if (!spin_trylock(&hvlpevent_queue.lock))
+	if (!spin_trylock(&hvlpevent_queue.hq_lock))
 		return;
 
 	for (;;) {
@@ -148,17 +149,17 @@ void process_hvlpevents(struct pt_regs *
 				printk(KERN_INFO "Unexpected Lp Event type=%d\n", event->xType );
 
 			hvlpevent_clear_valid(event);
-		} else if (hvlpevent_queue.xPlicOverflowIntPending)
+		} else if (hvlpevent_queue.hq_overflow_pending)
 			/*
 			 * No more valid events. If overflow events are
 			 * pending process them
 			 */
-			HvCallEvent_getOverflowLpEvents(hvlpevent_queue.xIndex);
+			HvCallEvent_getOverflowLpEvents(hvlpevent_queue.hq_index);
 		else
 			break;
 	}
 
-	spin_unlock(&hvlpevent_queue.lock);
+	spin_unlock(&hvlpevent_queue.hq_lock);
 }
 
 static int set_spread_lpevents(char *str)
@@ -184,20 +185,20 @@ void setup_hvlpevent_queue(void)
 {
 	void *eventStack;
 
-	spin_lock_init(&hvlpevent_queue.lock);
+	spin_lock_init(&hvlpevent_queue.hq_lock);
 
 	/* Allocate a page for the Event Stack. */
-	eventStack = alloc_bootmem_pages(LpEventStackSize);
-	memset(eventStack, 0, LpEventStackSize);
+	eventStack = alloc_bootmem_pages(IT_LP_EVENT_STACK_SIZE);
+	memset(eventStack, 0, IT_LP_EVENT_STACK_SIZE);
 
 	/* Invoke the hypervisor to initialize the event stack */
-	HvCallEvent_setLpEventStack(0, eventStack, LpEventStackSize);
+	HvCallEvent_setLpEventStack(0, eventStack, IT_LP_EVENT_STACK_SIZE);
 
-	hvlpevent_queue.xSlicEventStackPtr = (char *)eventStack;
-	hvlpevent_queue.xSlicCurEventPtr = (char *)eventStack;
-	hvlpevent_queue.xSlicLastValidEventPtr = (char *)eventStack +
-					(LpEventStackSize - LpEventMaxSize);
-	hvlpevent_queue.xIndex = 0;
+	hvlpevent_queue.hq_event_stack = eventStack;
+	hvlpevent_queue.hq_current_event = eventStack;
+	hvlpevent_queue.hq_last_event = (char *)eventStack +
+		(IT_LP_EVENT_STACK_SIZE - IT_LP_EVENT_MAX_SIZE);
+	hvlpevent_queue.hq_index = 0;
 }
 
 /* Register a handler for an LpEvent type */
diff --git a/arch/powerpc/platforms/iseries/proc.c b/arch/powerpc/platforms/iseries/proc.c
index e68b6b5..c241413 100644
--- a/arch/powerpc/platforms/iseries/proc.c
+++ b/arch/powerpc/platforms/iseries/proc.c
@@ -24,7 +24,6 @@ #include <asm/paca.h>
 #include <asm/processor.h>
 #include <asm/time.h>
 #include <asm/lppaca.h>
-#include <asm/iseries/it_lp_queue.h>
 #include <asm/iseries/hv_call_xm.h>
 
 #include "processor_vpd.h"
diff --git a/include/asm-powerpc/iseries/it_lp_queue.h b/include/asm-powerpc/iseries/it_lp_queue.h
index b7c6fc1..284c5a7 100644
--- a/include/asm-powerpc/iseries/it_lp_queue.h
+++ b/include/asm-powerpc/iseries/it_lp_queue.h
@@ -29,20 +29,20 @@ #include <asm/ptrace.h>
 
 struct HvLpEvent;
 
-#define ITMaxLpQueues	8
+#define IT_LP_MAX_QUEUES	8
 
-#define NotUsed		0	// Queue will not be used by PLIC
-#define DedicatedIo	1	// Queue dedicated to IO processor specified
-#define DedicatedLp	2	// Queue dedicated to LP specified
-#define Shared		3	// Queue shared for both IO and LP
+#define IT_LP_NOT_USED		0	/* Queue will not be used by PLIC */
+#define IT_LP_DEDICATED_IO	1	/* Queue dedicated to IO processor specified */
+#define IT_LP_DEDICATED_LP	2	/* Queue dedicated to LP specified */
+#define IT_LP_SHARED		3	/* Queue shared for both IO and LP */
 
-#define LpEventStackSize	4096
-#define LpEventMaxSize		256
-#define LpEventAlign		64
+#define IT_LP_EVENT_STACK_SIZE	4096
+#define IT_LP_EVENT_MAX_SIZE	256
+#define IT_LP_EVENT_ALIGN	64
 
 struct hvlpevent_queue {
 /*
- * The xSlicCurEventPtr is the pointer to the next event stack entry
+ * The hq_current_event is the pointer to the next event stack entry
  * that will become valid.  The OS must peek at this entry to determine
  * if it is valid.  PLIC will set the valid indicator as the very last
  * store into that entry.
@@ -52,23 +52,23 @@ struct hvlpevent_queue {
  * location again.
  *
  * If the event stack fills and there are overflow events, then PLIC
- * will set the xPlicOverflowIntPending flag in which case the OS will
+ * will set the hq_overflow_pending flag in which case the OS will
  * have to fetch the additional LP events once they have drained the
  * event stack.
  *
  * The first 16-bytes are known by both the OS and PLIC.  The remainder
  * of the cache line is for use by the OS.
  */
-	u8	xPlicOverflowIntPending;// 0x00 Overflow events are pending
-	u8	xPlicStatus;		// 0x01 DedicatedIo or DedicatedLp or NotUsed
-	u16	xSlicLogicalProcIndex;	// 0x02 Logical Proc Index for correlation
-	u8	xPlicRsvd[12];		// 0x04
-	char	*xSlicCurEventPtr;	// 0x10
-	char	*xSlicLastValidEventPtr; // 0x18
-	char	*xSlicEventStackPtr;	// 0x20
-	u8	xIndex;			// 0x28 unique sequential index.
-	u8	xSlicRsvd[3];		// 0x29-2b
-	spinlock_t	lock;
+	u8		hq_overflow_pending;	/* 0x00 Overflow events are pending */
+	u8		hq_status;		/* 0x01 DedicatedIo or DedicatedLp or NotUsed */
+	u16		hq_proc_index;		/* 0x02 Logical Proc Index for correlation */
+	u8		hq_reserved1[12];	/* 0x04 */
+	char		*hq_current_event;	/* 0x10 */
+	char		*hq_last_event;		/* 0x18 */
+	char		*hq_event_stack;	/* 0x20 */
+	u8		hq_index;		/* 0x28 unique sequential index. */
+	u8		hq_reserved2[3];	/* 0x29-2b */
+	spinlock_t	hq_lock;
 };
 
 extern struct hvlpevent_queue hvlpevent_queue;
-- 
1.4.0
