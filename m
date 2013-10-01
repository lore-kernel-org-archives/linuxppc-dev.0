Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 11D1D2C0119
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 21:26:37 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Oct 2013 16:56:28 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id EF2F21258051
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 16:56:40 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r91BSoDs34078734
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Oct 2013 16:58:50 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r91BQMXY005255
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Oct 2013 16:56:22 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 00/11 Allow PR and HV KVM to coexist in one kernel
In-Reply-To: <524990A9.60704@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <878uyibkq2.fsf@linux.vnet.ibm.com>
 <48337EF0-471D-4BDB-8088-FC072FF82753@suse.de>
 <87had2bgme.fsf@linux.vnet.ibm.com> <524990A9.60704@suse.de>
Date: Tue, 01 Oct 2013 16:56:21 +0530
Message-ID: <87ob79cjvm.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "<kvm@vger.kernel.org> list" <kvm@vger.kernel.org>,
 Gleb Natapov <gleb@redhat.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 09/30/2013 03:09 PM, Aneesh Kumar K.V wrote:
>> Alexander Graf<agraf@suse.de>  writes:
>>
>>> On 27.09.2013, at 12:52, Aneesh Kumar K.V wrote:
>>>
>>>> "Aneesh Kumar K.V"<aneesh.kumar@linux.vnet.ibm.com>  writes:
>>>>
>>>>> Hi All,
>>>>>
>>>>> This patch series support enabling HV and PR KVM together in the same kernel. We
>>>>> extend machine property with new property "kvm_type". A value of 1 will force HV
>>>>> KVM and 2 PR KVM. The default value is 0 which will select the fastest KVM mode.
>>>>> ie, HV if that is supported otherwise PR.
>>>>>
>>>>> With Qemu command line having
>>>>>
>>>>> -machine pseries,accel=kvm,kvm_type=1
>>>>>
>>>>> [root@llmp24l02 qemu]# bash ../qemu
>>>>> failed to initialize KVM: Invalid argument
>>>>> [root@llmp24l02 qemu]# modprobe kvm-pr
>>>>> [root@llmp24l02 qemu]# bash ../qemu
>>>>> failed to initialize KVM: Invalid argument
>>>>> [root@llmp24l02 qemu]# modprobe  kvm-hv
>>>>> [root@llmp24l02 qemu]# bash ../qemu
>>>>>
>>>>> now with
>>>>>
>>>>> -machine pseries,accel=kvm,kvm_type=2
>>>>>
>>>>> [root@llmp24l02 qemu]# rmmod kvm-pr
>>>>> [root@llmp24l02 qemu]# bash ../qemu
>>>>> failed to initialize KVM: Invalid argument
>>>>> [root@llmp24l02 qemu]#
>>>>> [root@llmp24l02 qemu]# modprobe kvm-pr
>>>>> [root@llmp24l02 qemu]# bash ../qemu
>>>>>
>>>>> if don't specify kvm_type machine property, it will take a default value 0,
>>>>> which means fastest supported.
>>>> Related qemu patch
>>>>
>>>> commit 8d139053177d48a70cb710b211ea4c2843eccdfb
>>>> Author: Aneesh Kumar K.V<aneesh.kumar@linux.vnet.ibm.com>
>>>> Date:   Mon Sep 23 12:28:37 2013 +0530
>>>>
>>>>     kvm: Add a new machine property kvm_type
>>>>
>>>>     Targets like ppc64 support different type of KVM, one which use
>>>>     hypervisor mode and the other which doesn't. Add a new machine
>>>>     property kvm_type that helps in selecting the respective ones
>>>>
>>>>     Signed-off-by: Aneesh Kumar K.V<aneesh.kumar@linux.vnet.ibm.com>
>>> This really is too early, as we can't possibly run in HV mode for
>>> non-pseries machines, so the interpretation (or at least sanity
>>> checking) of what values are reasonable should occur in the
>>> machine. That's why it's a variable in the "machine opts".
>> With the current code CREATE_VM will fail, because we won't have
>> kvm-hv.ko loaded and trying to create a vm with type 1 will fail.
>> Now the challenge related to moving that to machine_init or later is, we
>> depend on HV or PR callback early in CREATE_VM. With the changes we have
>>
>> int kvmppc_core_init_vm(struct kvm *kvm)
>> {
>>
>> #ifdef CONFIG_PPC64
>> 	INIT_LIST_HEAD(&kvm->arch.spapr_tce_tables);
>> 	INIT_LIST_HEAD(&kvm->arch.rtas_tokens);
>> #endif
>>
>> 	return kvm->arch.kvm_ops->init_vm(kvm);
>> }
>>
>> Also the mmu notifier callback do end up calling kvm_unmap_hva etc which
>> are all HV/PR dependent.
>
> Yes, so we should verify in the machine models that we're runnable with 
> the currently selected type at least, to give the user a sensible error 
> message.

Something like the below

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 004184d..7d59ac1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1337,6 +1337,21 @@ static void ppc_spapr_init(QEMUMachineInitArgs *args)
     assert(spapr->fdt_skel != NULL);
 }
 
+static int spapr_get_vm_type(const char *vm_type)
+{
+    if (!vm_type)
+        return 0;
+
+    if (!strcmp(vm_type, "HV"))
+        return 1;
+
+    if (!strcmp(vm_type, "PR"))
+        return 2;
+
+    hw_error("qemu: unknown kvm_type specified '%s'", vm_type);
+    exit(1);
+}
+
 static QEMUMachine spapr_machine = {
     .name = "pseries",
     .desc = "pSeries Logical Partition (PAPR compliant)",
@@ -1347,6 +1362,7 @@ static QEMUMachine spapr_machine = {
     .max_cpus = MAX_CPUS,
     .no_parallel = 1,
     .default_boot_order = NULL,
+    .get_vm_type = spapr_get_vm_type,
 };
 
 static void spapr_machine_init(void)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5a7ae9f..2130488 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -21,6 +21,8 @@ typedef void QEMUMachineResetFunc(void);
 
 typedef void QEMUMachineHotAddCPUFunc(const int64_t id, Error **errp);
 
+typedef int QEMUMachineGetVmTypeFunc(const char *arg);
+
 typedef struct QEMUMachine {
     const char *name;
     const char *alias;
@@ -28,6 +30,7 @@ typedef struct QEMUMachine {
     QEMUMachineInitFunc *init;
     QEMUMachineResetFunc *reset;
     QEMUMachineHotAddCPUFunc *hot_add_cpu;
+    QEMUMachineGetVmTypeFunc *get_vm_type;
     BlockInterfaceType block_default_type;
     int max_cpus;
     unsigned int no_serial:1,
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index e1f88bf..acc3d74 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -36,7 +36,8 @@ void xen_cmos_set_s3_resume(void *opaque, int irq, int level);
 
 qemu_irq *xen_interrupt_controller_init(void);
 
-int xen_init(void);
+typedef struct QEMUMachine QEMUMachine;
+int xen_init(QEMUMachine *machine);
 int xen_hvm_init(MemoryRegion **ram_memory);
 void xenstore_store_pv_console_info(int i, struct CharDriverState *chr);
 
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 9bbe3db..f25caec 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -142,8 +142,8 @@ typedef struct KVMState KVMState;
 extern KVMState *kvm_state;
 
 /* external API */
-
-int kvm_init(void);
+typedef struct QEMUMachine QEMUMachine;
+int kvm_init(QEMUMachine *machine);
 
 int kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 9a0c6b3..d71343d 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -31,7 +31,8 @@ static inline int qtest_available(void)
     return 1;
 }
 
-int qtest_init(void);
+typedef struct QEMUMachine QEMUMachine;
+int qtest_init(QEMUMachine *machine);
 #else
 static inline bool qtest_enabled(void)
 {
@@ -43,7 +44,7 @@ static inline int qtest_available(void)
     return 0;
 }
 
-static inline int qtest_init(void)
+static inline int qtest_init(QEMUMachine *machine)
 {
     return 0;
 }
diff --git a/kvm-all.c b/kvm-all.c
index b87215c..3863abd 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -35,6 +35,8 @@
 #include "qemu/event_notifier.h"
 #include "trace.h"
 
+#include "hw/boards.h"
+
 /* This check must be after config-host.h is included */
 #ifdef CONFIG_EVENTFD
 #include <sys/eventfd.h>
@@ -1342,7 +1344,7 @@ static int kvm_max_vcpus(KVMState *s)
     return 4;
 }
 
-int kvm_init(void)
+int kvm_init(QEMUMachine *machine)
 {
     static const char upgrade_note[] =
         "Please upgrade to at least kernel 2.6.29 or recent kvm-kmod\n"
@@ -1350,7 +1352,7 @@ int kvm_init(void)
     KVMState *s;
     const KVMCapabilityInfo *missing_cap;
     int ret;
-    int i;
+    int i, kvm_type = 0;
     int max_vcpus;
 
     s = g_malloc0(sizeof(KVMState));
@@ -1407,7 +1409,11 @@ int kvm_init(void)
         goto err;
     }
 
-    s->vmfd = kvm_ioctl(s, KVM_CREATE_VM, 0);
+    if (machine->get_vm_type) {
+        kvm_type = machine->get_vm_type(qemu_opt_get(qemu_get_machine_opts(),
+                                                     "kvm_type"));
+    }
+    s->vmfd = kvm_ioctl(s, KVM_CREATE_VM, kvm_type);
     if (s->vmfd < 0) {
 #ifdef TARGET_S390X
         fprintf(stderr, "Please add the 'switch_amode' kernel parameter to "
diff --git a/kvm-stub.c b/kvm-stub.c
index 548f471..ccb7b8c 100644
--- a/kvm-stub.c
+++ b/kvm-stub.c
@@ -19,6 +19,8 @@
 #include "hw/pci/msi.h"
 #endif
 
+#include "hw/boards.h"
+
 KVMState *kvm_state;
 bool kvm_kernel_irqchip;
 bool kvm_async_interrupts_allowed;
@@ -33,7 +35,7 @@ int kvm_init_vcpu(CPUState *cpu)
     return -ENOSYS;
 }
 
-int kvm_init(void)
+int kvm_init(QEMUMachine *machine)
 {
     return -ENOSYS;
 }
diff --git a/qtest.c b/qtest.c
index 584c707..ef3c473 100644
--- a/qtest.c
+++ b/qtest.c
@@ -502,7 +502,7 @@ static void qtest_event(void *opaque, int event)
     }
 }
 
-int qtest_init(void)
+int qtest_init(QEMUMachine *machine)
 {
     CharDriverState *chr;
 
diff --git a/vl.c b/vl.c
index 4e709d5..7ecc581 100644
--- a/vl.c
+++ b/vl.c
@@ -427,7 +427,12 @@ static QemuOptsList qemu_machine_opts = {
             .name = "usb",
             .type = QEMU_OPT_BOOL,
             .help = "Set on/off to enable/disable usb",
+        },{
+            .name = "kvm_type",
+            .type = QEMU_OPT_STRING,
+            .help = "Set to kvm type to be used in create vm ioctl",
         },
+
         { /* End of list */ }
     },
 };
@@ -2608,7 +2613,7 @@ static QEMUMachine *machine_parse(const char *name)
     exit(!name || !is_help_option(name));
 }
 
-static int tcg_init(void)
+static int tcg_init(QEMUMachine *machine)
 {
     tcg_exec_init(tcg_tb_size * 1024 * 1024);
     return 0;
@@ -2618,7 +2623,7 @@ static struct {
     const char *opt_name;
     const char *name;
     int (*available)(void);
-    int (*init)(void);
+    int (*init)(QEMUMachine *);
     bool *allowed;
 } accel_list[] = {
     { "tcg", "tcg", tcg_available, tcg_init, &tcg_allowed },
@@ -2627,7 +2632,7 @@ static struct {
     { "qtest", "QTest", qtest_available, qtest_init, &qtest_allowed },
 };
 
-static int configure_accelerator(void)
+static int configure_accelerator(QEMUMachine *machine)
 {
     const char *p;
     char buf[10];
@@ -2654,7 +2659,7 @@ static int configure_accelerator(void)
                     continue;
                 }
                 *(accel_list[i].allowed) = true;
-                ret = accel_list[i].init();
+                ret = accel_list[i].init(machine);
                 if (ret < 0) {
                     init_failed = true;
                     fprintf(stderr, "failed to initialize %s: %s\n",
@@ -4037,10 +4042,10 @@ int main(int argc, char **argv, char **envp)
         exit(0);
     }
 
-    configure_accelerator();
+    configure_accelerator(machine);
 
     if (!qtest_enabled() && qtest_chrdev) {
-        qtest_init();
+        qtest_init(machine);
     }
 
     machine_opts = qemu_get_machine_opts();
diff --git a/xen-all.c b/xen-all.c
index 839f14f..ac3654b 100644
--- a/xen-all.c
+++ b/xen-all.c
@@ -1000,7 +1000,7 @@ static void xen_exit_notifier(Notifier *n, void *data)
     xs_daemon_close(state->xenstore);
 }
 
-int xen_init(void)
+int xen_init(QEMUMachine *machine)
 {
     xen_xc = xen_xc_interface_open(0, 0, 0);
     if (xen_xc == XC_HANDLER_INITIAL_VALUE) {
diff --git a/xen-stub.c b/xen-stub.c
index ad189a6..59927cb 100644
--- a/xen-stub.c
+++ b/xen-stub.c
@@ -47,7 +47,7 @@ qemu_irq *xen_interrupt_controller_init(void)
     return NULL;
 }
 
-int xen_init(void)
+int xen_init(QEMUMachine *machine)
 {
     return -ENOSYS;
 }

>
>>
>>
>>
>>> Also, users don't want to say type=0. They want to say type=PR or
>>> type=HV or type=HV,PR. In fact, can't you make this a property of
>>> -accel? Then it's truly accel specific and everything should be well.
>> If we are doing this as machine property, we can't specify string,
>> because "HV"/"PR" are all powerpc dependent, so parsing that is not
>> possible in kvm_init in qemu. But, yes ideally it would be nice to be
>
> Well, we could do the "name to integer" conversion in an arch specific 
> function, no?
>
>> able to speicy the type using string. I thought accel is a machine
>> property, hence was not sure whether I can have additional properties
>> against that. I was using it as below.
>>
>>   -machine pseries,accel=kvm,kvm_type=1

Can we really specific -accel ? I check and I am finding that as machine
property. 

-aneesh
