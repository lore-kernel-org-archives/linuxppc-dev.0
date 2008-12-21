Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.237])
	by ozlabs.org (Postfix) with ESMTP id 3AF73DDEF7
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 19:06:25 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1605765rvb.3
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 00:06:23 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/4] powerpc/mpc5200: Bugfix on handling variable sized buffer
	descriptors
To: linuxppc-dev@ozlabs.org, hans.lehmann@ritter-elektronik.de,
	matt@genesi-usa.com, olaf@aepfle.de
Date: Sun, 21 Dec 2008 01:06:19 -0700
Message-ID: <20081221080619.29029.11260.stgit@localhost.localdomain>
In-Reply-To: <20081221080213.29029.7646.stgit@localhost.localdomain>
References: <20081221080213.29029.7646.stgit@localhost.localdomain>
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

The buffer descriptors for the ATA BestComm task are larger than the
current definition for bcom_bd.  This causes problems because the
various bcom_... functions dereference the buffer descriptor pointer
by using the array operator which doesn't work when the buffer
descriptors are a different size.

This patch adds the bcom_get_bd() function which uses the value in
bcom_task.bd_size to calculate the offset into the BD table.  This
patch also changes the definition of bcom_bd to specify a data size
of 0 instead of 1 so that it will never work if anyone attempts to
dereference the bd list as an array (as opposed to something that
might work even though it is wrong).

Finally, this patch moves the definition of bcom_bd up in the file
to eliminate a forward declaration.

Based on patch originally written by Tim Yamin.

Signed-off-by: Tim Yamin <plasm@roo.me.uk>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/bestcomm/bestcomm.h |   61 +++++++++++++++++++++----------
 1 files changed, 42 insertions(+), 19 deletions(-)


diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.h b/arch/powerpc/sysdev/bestcomm/bestcomm.h
index c960a8b..23a95f8 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm.h
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.h
@@ -16,8 +16,19 @@
 #ifndef __BESTCOMM_H__
 #define __BESTCOMM_H__
 
-struct bcom_bd; /* defined later on ... */
-
+/**
+ * struct bcom_bd - Structure describing a generic BestComm buffer descriptor
+ * @status: The current status of this buffer. Exact meaning depends on the
+ *          task type
+ * @data: An array of u32 extra data.  Size of array is task dependant.
+ *
+ * Note: Don't dereference a bcom_bd pointer as an array.  The size of the
+ *       bcom_bd is variable.  Use bcom_get_bd() instead.
+ */
+struct bcom_bd {
+	u32	status;
+	u32	data[0];	/* variable payload size */
+};
 
 /* ======================================================================== */
 /* Generic task management                                                   */
@@ -84,17 +95,6 @@ bcom_get_task_irq(struct bcom_task *tsk) {
 /* BD based tasks helpers                                                   */
 /* ======================================================================== */
 
-/**
- * struct bcom_bd - Structure describing a generic BestComm buffer descriptor
- * @status: The current status of this buffer. Exact meaning depends on the
- *          task type
- * @data: An array of u32 whose meaning depends on the task type.
- */
-struct bcom_bd {
-	u32	status;
-	u32	data[1];	/* variable, but at least 1 */
-};
-
 #define BCOM_BD_READY	0x40000000ul
 
 /** _bcom_next_index - Get next input index.
@@ -140,15 +140,31 @@ bcom_queue_full(struct bcom_task *tsk)
 }
 
 /**
+ * bcom_get_bd - Get a BD from the queue
+ * @tsk: The BestComm task structure
+ * index: Index of the BD to fetch
+ */
+static inline struct bcom_bd
+*bcom_get_bd(struct bcom_task *tsk, unsigned int index)
+{
+	/* A cast to (void*) so the address can be incremented by the
+	 * real size instead of by sizeof(struct bcom_bd) */
+	return ((void *)tsk->bd) + (index * tsk->bd_size);
+}
+
+/**
  * bcom_buffer_done - Checks if a BestComm 
  * @tsk: The BestComm task structure
  */
 static inline int
 bcom_buffer_done(struct bcom_task *tsk)
 {
+	struct bcom_bd *bd;
 	if (bcom_queue_empty(tsk))
 		return 0;
-	return !(tsk->bd[tsk->outdex].status & BCOM_BD_READY);
+
+	bd = bcom_get_bd(tsk, tsk->outdex);
+	return !(bd->status & BCOM_BD_READY);
 }
 
 /**
@@ -160,16 +176,21 @@ bcom_buffer_done(struct bcom_task *tsk)
 static inline struct bcom_bd *
 bcom_prepare_next_buffer(struct bcom_task *tsk)
 {
-	tsk->bd[tsk->index].status = 0;	/* cleanup last status */
-	return &tsk->bd[tsk->index];
+	struct bcom_bd *bd;
+
+	bd = bcom_get_bd(tsk, tsk->index);
+	bd->status = 0;	/* cleanup last status */
+	return bd;
 }
 
 static inline void
 bcom_submit_next_buffer(struct bcom_task *tsk, void *cookie)
 {
+	struct bcom_bd *bd = bcom_get_bd(tsk, tsk->index);
+
 	tsk->cookie[tsk->index] = cookie;
 	mb();	/* ensure the bd is really up-to-date */
-	tsk->bd[tsk->index].status |= BCOM_BD_READY;
+	bd->status |= BCOM_BD_READY;
 	tsk->index = _bcom_next_index(tsk);
 	if (tsk->flags & BCOM_FLAGS_ENABLE_TASK)
 		bcom_enable(tsk);
@@ -179,10 +200,12 @@ static inline void *
 bcom_retrieve_buffer(struct bcom_task *tsk, u32 *p_status, struct bcom_bd **p_bd)
 {
 	void *cookie = tsk->cookie[tsk->outdex];
+	struct bcom_bd *bd = bcom_get_bd(tsk, tsk->outdex);
+
 	if (p_status)
-		*p_status = tsk->bd[tsk->outdex].status;
+		*p_status = bd->status;
 	if (p_bd)
-		*p_bd = &tsk->bd[tsk->outdex];
+		*p_bd = bd;
 	tsk->outdex = _bcom_next_outdex(tsk);
 	return cookie;
 }
