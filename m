Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2683E1A0A1D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:52 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:39:51 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2431E2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:50 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9H7u158654880
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:17:07 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9dnur009024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:49 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 06/12] spapr: Add "ddw" machine option
Date: Tue, 15 Jul 2014 19:39:38 +1000
Message-Id: <1405417184-14333-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405417184-14333-1-git-send-email-aik@ozlabs.ru>
References: <1405417184-14333-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This option will enable Dynamic DMA windows (DDW) support for pseries
machine.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr.c | 15 +++++++++++++++
 vl.c           |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d01978f..fec295b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -100,6 +100,7 @@ struct sPAPRMachineState {
 
     /*< public >*/
     char *kvm_type;
+    bool ddw_supported;
 };
 
 sPAPREnvironment *spapr;
@@ -1570,10 +1571,24 @@ static void spapr_set_kvm_type(Object *obj, const char *value, Error **errp)
     sm->kvm_type = g_strdup(value);
 }
 
+static bool spapr_machine_get_ddw(Object *obj, Error **errp)
+{
+    sPAPRMachineState *sms = SPAPR_MACHINE(obj);
+    return sms->ddw_supported;
+}
+
+static void spapr_machine_set_ddw(Object *obj, bool value, Error **errp)
+{
+    sPAPRMachineState *sms = SPAPR_MACHINE(obj);
+    sms->ddw_supported = value;
+}
+
 static void spapr_machine_initfn(Object *obj)
 {
     object_property_add_str(obj, "kvm-type",
                             spapr_get_kvm_type, spapr_set_kvm_type, NULL);
+    object_property_add_bool(obj, "ddw", spapr_machine_get_ddw,
+                             spapr_machine_set_ddw, NULL);
 }
 
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
diff --git a/vl.c b/vl.c
index 6e084c2..a615fb1 100644
--- a/vl.c
+++ b/vl.c
@@ -383,6 +383,10 @@ static QemuOptsList qemu_machine_opts = {
             .name = "kvm-type",
             .type = QEMU_OPT_STRING,
             .help = "Specifies the KVM virtualization mode (HV, PR)",
+        }, {
+            .name = "ddw",
+            .type = QEMU_OPT_BOOL,
+            .help = "Enable Dynamic DMA windows support (pseries only)",
         },{
             .name = PC_MACHINE_MAX_RAM_BELOW_4G,
             .type = QEMU_OPT_SIZE,
-- 
2.0.0
