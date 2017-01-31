Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCTQK3VtZzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 01:38:17 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0VEY5vT020790
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 09:38:14 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28apxq5yy3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 09:38:14 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 1 Feb 2017 00:38:11 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B80D22BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 01:38:09 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0VEc1h926542246
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 01:38:09 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0VEbboS010865
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 01:37:37 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: enable BPF_SYSCALL in defconfigs
Date: Tue, 31 Jan 2017 20:07:13 +0530
In-Reply-To: <39bf4b52484efc4f4b31303450a528ad260ab0ad.1485872578.git.naveen.n.rao@linux.vnet.ibm.com>
References: <39bf4b52484efc4f4b31303450a528ad260ab0ad.1485872578.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <39bf4b52484efc4f4b31303450a528ad260ab0ad.1485872578.git.naveen.n.rao@linux.vnet.ibm.com>
References: <39bf4b52484efc4f4b31303450a528ad260ab0ad.1485872578.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <39904dc2f744a4902d95f93cb3292a10c18504e5.1485872578.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable BPF_SYSCALL in ppc64, pseries and powernv defconfigs so that eBPF
is usable.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/configs/powernv_defconfig | 1 +
 arch/powerpc/configs/ppc64_defconfig   | 1 +
 arch/powerpc/configs/pseries_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 8e2b1da2560e..21829749c295 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -320,3 +320,4 @@ CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
 CONFIG_UPROBE_EVENT=y
+CONFIG_BPF_SYSCALL=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 270fbfe61ab6..f0b50935fb12 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -361,3 +361,4 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_POWERNV=m
 CONFIG_UPROBE_EVENT=y
+CONFIG_BPF_SYSCALL=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index bd9246588596..1469651d473c 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -324,3 +324,4 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_POWERNV=m
 CONFIG_UPROBE_EVENT=y
+CONFIG_BPF_SYSCALL=y
-- 
2.11.0
