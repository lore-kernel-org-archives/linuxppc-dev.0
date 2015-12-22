Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9ADB91A11B4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 16:14:15 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	benh@kernel.crashing.org,
	bharata@linux.vnet.ibm.com
Cc: thuth@redhat.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC 3/3] pseries: sysfs hack to trigger a hash page table resize
Date: Tue, 22 Dec 2015 16:14:58 +1100
Message-Id: <1450761298-12172-4-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
References: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a special file in /sys/kernel/mm which can be used to view
the current size of the hash page table (as a bit shift) and to trigger
a resize of the hash table on PAPR guests.

Logically this would make more sense as a debugfs file, but that doesn't
see to provide an obvious way to have a "store" function that has an effect
other than updating a variable.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/platforms/pseries/lpar.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index aadb242..2759767 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -903,3 +903,44 @@ int pSeries_lpar_resize_hpt(unsigned long shift)
 
 	return 0;
 }
+
+static ssize_t ppc64_pft_size_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%llu\n", (unsigned long long)ppc64_pft_size);
+}
+
+static ssize_t ppc64_pft_size_store(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    const char *buf, size_t count)
+{
+	unsigned long new_shift;
+	int rc;
+
+	pr_err("lpar: ppc64_pft_size_store() count=%zd\n", count);
+
+	if (kstrtoul(buf, 0, &new_shift))
+		return -EINVAL;
+
+	rc = pSeries_lpar_resize_hpt(new_shift);
+	if (rc < 0)
+		return rc;
+
+	return count;
+}
+
+static struct kobj_attribute ppc64_pft_size_attr =
+	__ATTR(ppc64_pft_size, 0600, ppc64_pft_size_show, ppc64_pft_size_store);
+
+static int __init pseries_lpar_sysfs(void)
+{
+	int rc;
+
+	rc = sysfs_create_file(mm_kobj, &ppc64_pft_size_attr.attr);
+	if (rc)
+		pr_err("lpar: unable to create ppc64_pft_size sysfs file (%d)\n",
+		       rc);
+
+	return 0;
+}
+machine_device_initcall(pseries, pseries_lpar_sysfs);
-- 
2.5.0
