Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f48.google.com (mail-pb0-f48.google.com
 [209.85.160.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C80E2C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 14:44:53 +1000 (EST)
Received: by mail-pb0-f48.google.com with SMTP id ma3so1606060pbc.21
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 21:44:51 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/10] hashtable: add hash_for_each_possible_rcu_notrace()
Date: Thu,  1 Aug 2013 14:44:23 +1000
Message-Id: <1375332272-22176-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1375332272-22176-1-git-send-email-aik@ozlabs.ru>
References: <1375332272-22176-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds hash_for_each_possible_rcu_notrace() which is basically
a notrace clone of hash_for_each_possible_rcu() which cannot be
used in real mode due to its tracing/debugging capability.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/linux/hashtable.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index a9df51f..af8b169 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -174,6 +174,21 @@ static inline void hash_del_rcu(struct hlist_node *node)
 		member)
 
 /**
+ * hash_for_each_possible_rcu_notrace - iterate over all possible objects hashing
+ * to the same bucket in an rcu enabled hashtable in a rcu enabled hashtable
+ * @name: hashtable to iterate
+ * @obj: the type * to use as a loop cursor for each entry
+ * @member: the name of the hlist_node within the struct
+ * @key: the key of the objects to iterate over
+ *
+ * This is the same as hash_for_each_possible_rcu() except that it does
+ * not do any RCU debugging or tracing.
+ */
+#define hash_for_each_possible_rcu_notrace(name, obj, member, key)	\
+	hlist_for_each_entry_rcu_notrace(obj, &name[hash_min(key, HASH_BITS(name))],\
+		member)
+
+/**
  * hash_for_each_possible_safe - iterate over all possible objects hashing to the
  * same bucket safe against removals
  * @name: hashtable to iterate
-- 
1.8.3.2
