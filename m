Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 08E322C00F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 18:38:13 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id xa7so5989225pbc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 01:38:11 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v9 02/13] hashtable: add hash_for_each_possible_rcu_notrace()
Date: Wed, 28 Aug 2013 18:37:39 +1000
Message-Id: <1377679070-3515-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1377679070-3515-1-git-send-email-aik@ozlabs.ru>
References: <1377679070-3515-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
Changes:
v8:
* fixed warnings from check_patch.pl
---
 include/linux/hashtable.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index a9df51f..519b6e2 100644
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
+#define hash_for_each_possible_rcu_notrace(name, obj, member, key) \
+	hlist_for_each_entry_rcu_notrace(obj, \
+		&name[hash_min(key, HASH_BITS(name))], member)
+
+/**
  * hash_for_each_possible_safe - iterate over all possible objects hashing to the
  * same bucket safe against removals
  * @name: hashtable to iterate
-- 
1.8.4.rc4
