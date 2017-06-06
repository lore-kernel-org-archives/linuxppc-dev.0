Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whszv65yQzDqLK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 23:32:11 +1000 (AEST)
Date: Tue, 6 Jun 2017 15:32:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: remove CLASS_ATTR usage
Message-ID: <20170606133203.GA7518@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

There was only 2 remaining users of CLASS_ATTR() so let's finally get
rid of them and force everyone to use the correct RW/RO/WO versions
instead.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

PPC maintainers, can I take this in my driver core tree?  I'm doing some
cleanups of device.h and this was one of the simpler ones at the moment.

thanks,

greg k-h

 arch/powerpc/platforms/pseries/dlpar.c    |    2 +-
 arch/powerpc/platforms/pseries/mobility.c |    7 ++++---
 include/linux/device.h                    |    2 --
 3 files changed, 5 insertions(+), 6 deletions(-)

--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -588,7 +588,7 @@ static ssize_t dlpar_show(struct class *
 	return sprintf(buf, "%s\n", "memory,cpu");
 }
 
-static CLASS_ATTR(dlpar, S_IWUSR | S_IRUSR, dlpar_show, dlpar_store);
+static CLASS_ATTR_RW(dlpar);
 
 static int __init pseries_dlpar_init(void)
 {
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -349,8 +349,9 @@ void post_mobility_fixup(void)
 	return;
 }
 
-static ssize_t migrate_store(struct class *class, struct class_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t migration_store(struct class *class,
+			       struct class_attribute *attr, const char *buf,
+			       size_t count)
 {
 	u64 streamid;
 	int rc;
@@ -380,7 +381,7 @@ static ssize_t migrate_store(struct clas
  */
 #define MIGRATION_API_VERSION	1
 
-static CLASS_ATTR(migration, S_IWUSR, NULL, migrate_store);
+static CLASS_ATTR_WO(migration);
 static CLASS_ATTR_STRING(api_version, S_IRUGO, __stringify(MIGRATION_API_VERSION));
 
 static int __init mobility_sysfs_init(void)
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -465,8 +465,6 @@ struct class_attribute {
 			const char *buf, size_t count);
 };
 
-#define CLASS_ATTR(_name, _mode, _show, _store) \
-	struct class_attribute class_attr_##_name = __ATTR(_name, _mode, _show, _store)
 #define CLASS_ATTR_RW(_name) \
 	struct class_attribute class_attr_##_name = __ATTR_RW(_name)
 #define CLASS_ATTR_RO(_name) \
