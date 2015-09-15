Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D79171A2C32
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:43 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Sep 2015 20:50:42 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B4FEF357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:38 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8FAoLJS63045822
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:29 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8FAo6SJ026327
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:50:06 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 1/9] rcu: Define notrace version of
 list_for_each_entry_rcu
Date: Tue, 15 Sep 2015 20:49:31 +1000
Message-Id: <1442314179-9706-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This defines list_for_each_entry_rcu_notrace and list_entry_rcu_notrace
which use rcu_dereference_raw_notrace instead of rcu_dereference_raw.
This allows using list_for_each_entry_rcu_notrace in real mode (MMU is off).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/linux/rculist.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 17c6b1f..439c4d7 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -253,6 +253,25 @@ static inline void list_splice_init_rcu(struct list_head *list,
 })
 
 /**
+ * list_entry_rcu_notrace - get the struct for this entry
+ * @ptr:        the &struct list_head pointer.
+ * @type:       the type of the struct this is embedded in.
+ * @member:     the name of the list_struct within the struct.
+ *
+ * This primitive may safely run concurrently with the _rcu list-mutation
+ * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
+ *
+ * This is the same as list_entry_rcu() except that it does
+ * not do any RCU debugging or tracing.
+ */
+#define list_entry_rcu_notrace(ptr, type, member) \
+({ \
+	typeof(*ptr) __rcu *__ptr = (typeof(*ptr) __rcu __force *)ptr; \
+	container_of((typeof(ptr))rcu_dereference_raw_notrace(__ptr), \
+			type, member); \
+})
+
+/**
  * Where are list_empty_rcu() and list_first_entry_rcu()?
  *
  * Implementing those functions following their counterparts list_empty() and
@@ -308,6 +327,25 @@ static inline void list_splice_init_rcu(struct list_head *list,
 		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
 
 /**
+ * list_for_each_entry_rcu_notrace - iterate over rcu list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ *
+ * This list-traversal primitive may safely run concurrently with
+ * the _rcu list-mutation primitives such as list_add_rcu()
+ * as long as the traversal is guarded by rcu_read_lock().
+ *
+ * This is the same as list_for_each_entry_rcu() except that it does
+ * not do any RCU debugging or tracing.
+ */
+#define list_for_each_entry_rcu_notrace(pos, head, member) \
+	for (pos = list_entry_rcu_notrace((head)->next, typeof(*pos), member); \
+		&pos->member != (head); \
+		pos = list_entry_rcu_notrace(pos->member.next, typeof(*pos), \
+				member))
+
+/**
  * list_for_each_entry_continue_rcu - continue iteration over list of given type
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
-- 
2.4.0.rc3.8.gfb3e7d5
