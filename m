Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 000EE2C0332
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 20:52:11 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 16:22:10 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E40C4394004E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 16:21:51 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RAsPYP44695794
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 16:24:25 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RAq6s9021310
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 16:22:07 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [RFC PATCH 00/11 Allow PR and HV KVM to coexist in one kernel
In-Reply-To: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 27 Sep 2013 16:22:05 +0530
Message-ID: <878uyibkq2.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Hi All,
>
> This patch series support enabling HV and PR KVM together in the same kernel. We
> extend machine property with new property "kvm_type". A value of 1 will force HV
> KVM and 2 PR KVM. The default value is 0 which will select the fastest KVM mode.
> ie, HV if that is supported otherwise PR.
>
> With Qemu command line having
>
>  -machine pseries,accel=kvm,kvm_type=1
>
> [root@llmp24l02 qemu]# bash ../qemu
> failed to initialize KVM: Invalid argument
> [root@llmp24l02 qemu]# modprobe kvm-pr
> [root@llmp24l02 qemu]# bash ../qemu
> failed to initialize KVM: Invalid argument
> [root@llmp24l02 qemu]# modprobe  kvm-hv
> [root@llmp24l02 qemu]# bash ../qemu
>
> now with
>
>  -machine pseries,accel=kvm,kvm_type=2
>
> [root@llmp24l02 qemu]# rmmod kvm-pr
> [root@llmp24l02 qemu]# bash ../qemu
> failed to initialize KVM: Invalid argument
> [root@llmp24l02 qemu]#
> [root@llmp24l02 qemu]# modprobe kvm-pr
> [root@llmp24l02 qemu]# bash ../qemu
>
> if don't specify kvm_type machine property, it will take a default value 0,
> which means fastest supported.

Related qemu patch

commit 8d139053177d48a70cb710b211ea4c2843eccdfb
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Mon Sep 23 12:28:37 2013 +0530

    kvm: Add a new machine property kvm_type
    
    Targets like ppc64 support different type of KVM, one which use
    hypervisor mode and the other which doesn't. Add a new machine
    property kvm_type that helps in selecting the respective ones
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/kvm-all.c b/kvm-all.c
index b87215c..a061eda 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1350,7 +1350,7 @@ int kvm_init(void)
     KVMState *s;
     const KVMCapabilityInfo *missing_cap;
     int ret;
-    int i;
+    int i, kvm_type;
     int max_vcpus;
 
     s = g_malloc0(sizeof(KVMState));
@@ -1407,7 +1407,8 @@ int kvm_init(void)
         goto err;
     }
 
-    s->vmfd = kvm_ioctl(s, KVM_CREATE_VM, 0);
+    kvm_type = qemu_opt_get_number(qemu_get_machine_opts(), "kvm_type", 0);
+    s->vmfd = kvm_ioctl(s, KVM_CREATE_VM, kvm_type);
     if (s->vmfd < 0) {
 #ifdef TARGET_S390X
         fprintf(stderr, "Please add the 'switch_amode' kernel parameter to "
diff --git a/vl.c b/vl.c
index 4e709d5..4374b17 100644
--- a/vl.c
+++ b/vl.c
@@ -427,7 +427,12 @@ static QemuOptsList qemu_machine_opts = {
             .name = "usb",
             .type = QEMU_OPT_BOOL,
             .help = "Set on/off to enable/disable usb",
+        },{
+            .name = "kvm_type",
+            .type = QEMU_OPT_NUMBER,
+            .help = "Set to kvm type to be used in create vm ioctl",
         },
+
         { /* End of list */ }
     },
 };
