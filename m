Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5ECCE1A0A81
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:32:15 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 30 Jul 2014 19:31:50 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 22D8F2BB0056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:39 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6U98cOh12386724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:08:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6U9VbB6031205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 19:31:38 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 01/16] rcu: Define notrace version of
 list_for_each_entry_rcu and list_entry_rcu
Date: Wed, 30 Jul 2014 19:31:20 +1000
Message-Id: <1406712695-9491-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
References: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <michael@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This defines list_for_each_entry_rcu_notrace which uses
new list_entry_rcu_notrace which uses rcu_dereference_raw_notrace instead
of rcu_dereference_raw whici allows us using
list_for_each_entry_rcu_notrace when MMU is off (real mode).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/linux/rculist.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 8183b46..a155774 100644
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
2.0.0
