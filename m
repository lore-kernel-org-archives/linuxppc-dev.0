Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHskw4jldzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 05:07:51 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v17HxD0R036295
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 13:07:48 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28fch55cmp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 13:07:48 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 04:07:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 486B83578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 05:07:43 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v17I7Z4l28835894
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 05:07:43 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v17I7ATR010939
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 05:07:11 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/powernv: Add more BPF in defconfig
Date: Tue,  7 Feb 2017 23:36:41 +0530
In-Reply-To: <874m06b70t.fsf@concordia.ellerman.id.au>
References: <874m06b70t.fsf@concordia.ellerman.id.au>
Message-Id: <20170207180641.31912-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/07 10:00PM, Michael Ellerman wrote:
> 
> I'll mush the patches all together and turn them all on across
> pseries/ppc64/powernv.

Here's a version that does that. I have merged all the patches
(including UPROBE_EVENT since that is very useful with bcc anyway). I
have also added CGROUP_BPF to get namespace coverage.

Thanks,
Naveen

--
powerpc: include bpf/bcc related config options in defconfigs

Specifically:
- CONFIG_BPF_SYSCALL
- CONFIG_NET_SCHED
- CONFIG_NET_CLS_BPF
- CONFIG_NET_CLS_ACT
- CONFIG_NET_ACT_BPF
- CONFIG_CGROUP_BPF
- CONFIG_UPROBE_EVENT

... in pseries, ppc64 and powernv defconfigs.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/configs/powernv_defconfig | 7 +++++++
 arch/powerpc/configs/ppc64_defconfig   | 7 +++++++
 arch/powerpc/configs/pseries_defconfig | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index b793550fac91..7a60b026247a 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -26,9 +26,11 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_BPF=y
 CONFIG_CGROUP_PERF=y
 CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
@@ -79,6 +81,10 @@ CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
+CONFIG_NET_SCHED=y
+CONFIG_NET_CLS_BPF=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_ACT_BPF=m
 CONFIG_BPF_JIT=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
@@ -290,6 +296,7 @@ CONFIG_LOCKUP_DETECTOR=y
 CONFIG_LATENCYTOP=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_UPROBE_EVENT=y
 CONFIG_CODE_PATCHING_SELFTEST=y
 CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 0396126ba6a8..4f1288b04303 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -14,7 +14,9 @@ CONFIG_LOG_BUF_SHIFT=18
 CONFIG_LOG_CPU_MAX_BUF_SHIFT=13
 CONFIG_CGROUPS=y
 CONFIG_CPUSETS=y
+CONFIG_CGROUP_BPF=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
@@ -76,6 +78,10 @@ CONFIG_INET_IPCOMP=m
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_BRIDGE=m
+CONFIG_NET_SCHED=y
+CONFIG_NET_CLS_BPF=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_ACT_BPF=m
 CONFIG_BPF_JIT=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
@@ -324,6 +330,7 @@ CONFIG_DEBUG_MUTEXES=y
 CONFIG_LATENCYTOP=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_UPROBE_EVENT=y
 CONFIG_CODE_PATCHING_SELFTEST=y
 CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index d99734f3b868..6d0eb02fefa4 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -24,12 +24,14 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_BPF=y
 CONFIG_MEMCG=y
 CONFIG_MEMCG_SWAP=y
 CONFIG_CGROUP_PERF=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
@@ -82,6 +84,10 @@ CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
+CONFIG_NET_SCHED=y
+CONFIG_NET_CLS_BPF=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_ACT_BPF=m
 CONFIG_BPF_JIT=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
@@ -290,6 +296,7 @@ CONFIG_LOCKUP_DETECTOR=y
 CONFIG_LATENCYTOP=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_UPROBE_EVENT=y
 CONFIG_CODE_PATCHING_SELFTEST=y
 CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
-- 
2.11.0
