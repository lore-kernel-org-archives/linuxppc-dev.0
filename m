Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401msb1rs8zDrDB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 09:41:06 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2EMf5rj072807
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:41:05 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gqcmm082f-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 18:41:05 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 14 Mar 2018 18:41:03 -0400
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
Subject: [TESTS] Create 'enabled_flush_types' boot option,
 and short-circuit LPM
Date: Wed, 14 Mar 2018 19:40:43 -0300
In-Reply-To: <1521067243-19520-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1521067243-19520-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1521067243-19520-7-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fallback -> fallback:

    # dmesg -c | grep rfi-flush
    [    0.000000] rfi-flush (debug): enabled flush types: 0x0
    [    0.000000] rfi-flush: fallback displacement flush available
    [    0.000000] rfi-flush: patched 8 locations (fallback displacement flush)

    # echo > /sys/kernel/mobility/migration 

    # dmesg -c | grep rfi-flush
    [   32.525443] rfi-flush: fallback displacement flush available
    [   32.526269] rfi-flush: patched 8 locations (fallback displacement flush)

fallback -> instructions:

    # dmesg -c | grep rfi-flush
    [    0.000000] rfi-flush (debug): enabled flush types: 0x0
    [    0.000000] rfi-flush: fallback displacement flush available
    [    0.000000] rfi-flush: patched 8 locations (fallback displacement flush)

    # echo 24 > /sys/kernel/debug/powerpc/rfi_flush 

    # dmesg -c | grep rfi-flush
    [   30.984247] rfi-flush (debug): enabled flush types: 0xc

    # echo > /sys/kernel/mobility/migration 

    # dmesg -c | grep rfi-flush
    [   51.554357] rfi-flush: fallback displacement flush available
    [   51.554360] rfi-flush: ori type flush available
    [   51.554361] rfi-flush: mttrig type flush available
    [   51.554366] rfi-flush: patched 8 locations (ori+mttrig type flush)

instructions -> instructions:

    # dmesg -c | grep rfi-flush
    [    0.000000] rfi-flush (debug): enabled flush types: 0xc
    [    0.000000] rfi-flush: fallback displacement flush available
    [    0.000000] rfi-flush: ori type flush available
    [    0.000000] rfi-flush: mttrig type flush available
    [    0.000000] rfi-flush: patched 8 locations (ori+mttrig type flush)

    # echo > /sys/kernel/mobility/migration 

    # dmesg -c | grep rfi-flush
    [   55.100566] rfi-flush: fallback displacement flush available
    [   55.100570] rfi-flush: ori type flush available
    [   55.100571] rfi-flush: mttrig type flush available
    [   55.100575] rfi-flush: patched 8 locations (ori+mttrig type flush)

instructions -> fallback:

    # dmesg -c | grep rfi-flush
    [    0.000000] rfi-flush (debug): enabled flush types: 0xc
    [    0.000000] rfi-flush: fallback displacement flush available
    [    0.000000] rfi-flush: ori type flush available
    [    0.000000] rfi-flush: mttrig type flush available
    [    0.000000] rfi-flush: patched 8 locations (ori+mttrig type flush)

    # echo 1111 > /sys/kernel/debug/powerpc/rfi_flush

    # dmesg -c | grep rfi-flush
    [   18.730782] rfi-flush (debug): enabled flush types: 0x0

    # echo > /sys/kernel/mobility/migration                                                                                                                                                    

    # dmesg -c | grep rfi-flush
    [   27.120071] rfi-flush: fallback displacement flush available
    [   27.120078] rfi-flush: patched 8 locations (fallback displacement flush)

debugfs switch:

    # echo 0 > /sys/kernel/debug/powerpc/rfi_flush 
    # echo 1 > /sys/kernel/debug/powerpc/rfi_flush 

    # dmesg -c | grep rfi-flush
    [  106.031993] rfi-flush: patched 8 locations (no flush)
    [  109.670966] rfi-flush: patched 8 locations (fallback displacement flush)

ori type only:

    # echo 8 > /sys/kernel/debug/powerpc/rfi_flush
    # echo 0 > /sys/kernel/debug/powerpc/rfi_flush 
    # echo 1 > /sys/kernel/debug/powerpc/rfi_flush 

    # dmesg -c | grep rfi-flush
    [  308.988958] rfi-flush (debug): enabled flush types: 0x4
    [  314.206548] rfi-flush: patched 8 locations (no flush)
    [  316.349916] rfi-flush: patched 8 locations (ori type flush)

mttrig type only:

    # echo 16 > /sys/kernel/debug/powerpc/rfi_flush
    # echo 0 > /sys/kernel/debug/powerpc/rfi_flush 
    # echo 1 > /sys/kernel/debug/powerpc/rfi_flush 

    # dmesg -c | grep rfi-flush
    [  355.993189] rfi-flush (debug): enabled flush types: 0x8
    [  360.644291] rfi-flush: patched 8 locations (no flush)
    [  365.300547] rfi-flush: patched 8 locations (mttrig type flush)

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/setup_64.c            | 29 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/mobility.c |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4ec4a27..9c9568e 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -816,6 +816,24 @@ static void *l1d_flush_fallback_area;
 static bool no_rfi_flush;
 bool rfi_flush;
 
+static int __init handle_enabled_flush_types(char *p)
+{
+	int rc;
+	enum l1d_flush_type types;
+
+	rc = kstrtoul(p, 0, (long unsigned int *)&types);
+	if (!rc) {
+		enabled_flush_types = types;
+		pr_info("rfi-flush (debug): enabled flush types: 0x%x\n", enabled_flush_types);
+	} else {
+		enabled_flush_types = L1D_FLUSH_NONE;
+		pr_info("rfi-flush (debug): enabled flush types is invalid\n");
+	}
+
+	return rc;
+}
+early_param("enabled_flush_types", handle_enabled_flush_types);
+
 static int __init handle_no_rfi_flush(char *p)
 {
 	pr_info("rfi-flush: disabled on command line.");
@@ -883,6 +901,8 @@ static void init_fallback_flush(void)
 
 void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 {
+	types |= enabled_flush_types;
+
 	if (types & L1D_FLUSH_FALLBACK) {
 		pr_info("rfi-flush: fallback displacement flush available\n");
 		init_fallback_flush();
@@ -909,6 +929,15 @@ static int rfi_flush_set(void *data, u64 val)
 		enable = true;
 	else if (val == 0)
 		enable = false;
+	else if (val == 1111) {
+		enable = true;
+		enabled_flush_types = 0;
+		pr_info("rfi-flush (debug): enabled flush types: 0x%x\n", enabled_flush_types);
+	} else if (val >= 2) {
+		enable = true;
+		enabled_flush_types = val >> 1;
+		pr_info("rfi-flush (debug): enabled flush types: 0x%x\n", enabled_flush_types);
+	}
 	else
 		return -EINVAL;
 
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 8a8033a..2a8458a 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -326,6 +326,7 @@ int pseries_devicetree_update(s32 scope)
 
 void post_mobility_fixup(void)
 {
+#if 0
 	int rc;
 	int activate_fw_token;
 
@@ -348,6 +349,7 @@ void post_mobility_fixup(void)
 		printk(KERN_ERR "Post-mobility device tree update "
 			"failed: %d\n", rc);
 
+#endif
 	/* Possibly switch to a new RFI flush type */
 	pseries_setup_rfi_flush();
 
@@ -358,6 +360,7 @@ static ssize_t migration_store(struct class *class,
 			       struct class_attribute *attr, const char *buf,
 			       size_t count)
 {
+#if 0
 	u64 streamid;
 	int rc;
 
@@ -374,6 +377,7 @@ static ssize_t migration_store(struct class *class,
 	if (rc)
 		return rc;
 
+#endif
 	post_mobility_fixup();
 	return count;
 }
-- 
2.7.4
