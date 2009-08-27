Return-Path: <arun@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0F8A9B7B85
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 21:55:55 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7RBtdmb000665
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2009 17:25:39 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7RBtdru2474154
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2009 17:25:39 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7RBtc3D009410
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2009 21:55:39 +1000
Date: Thu, 27 Aug 2009 17:25:36 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Joel Schopp <jschopp@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [PATCH 3/4]: ACPI/ARM: Register for cpuidle_pm_idle in
	drivers/acpi/processor_idle.c and arch/arm/mach-kirkwood/cpuidle.c
Message-ID: <20090827115536.GD24986@linux.vnet.ibm.com>
References: <20090827114908.GA24986@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090827114908.GA24986@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-08-27 17:19:08]:

Set the idle routine to cpuidle_pm_idle after registering cpuidle
devices. Earlier pm_idle was assumed as the defualt idle loop by
cpuidle infrastructure. This is changed to an architecture independent
cpuidle_pm_idle.

There are 2 instances which are using cpuidle infrastructure currently.
This patch makes the change in both the places.

Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---
 arch/arm/mach-kirkwood/cpuidle.c |    6 ++++++
 drivers/acpi/processor_idle.c    |    5 +++++
 2 files changed, 11 insertions(+)

Index: linux.trees.git/arch/arm/mach-kirkwood/cpuidle.c
===================================================================
--- linux.trees.git.orig/arch/arm/mach-kirkwood/cpuidle.c
+++ linux.trees.git/arch/arm/mach-kirkwood/cpuidle.c
@@ -90,6 +90,12 @@ static int kirkwood_init_cpuidle(void)
 		printk(KERN_ERR "kirkwood_init_cpuidle: Failed registering\n");
 		return -EIO;
 	}
+
+	if (pm_idle != cpuidle_pm_idle) {
+		printk(KERN_INFO "using cpuidle idle loop\n");
+		pm_idle = cpuidle_pm_idle;
+	}
+
 	return 0;
 }
 
Index: linux.trees.git/drivers/acpi/processor_idle.c
===================================================================
--- linux.trees.git.orig/drivers/acpi/processor_idle.c
+++ linux.trees.git/drivers/acpi/processor_idle.c
@@ -1216,6 +1216,11 @@ int __cpuinit acpi_processor_power_init(
 				printk(" C%d[C%d]", i,
 				       pr->power.states[i].type);
 		printk(")\n");
+
+		if (pm_idle != cpuidle_pm_idle) {
+			printk(KERN_INFO "using cpuidle idle loop\n");
+			pm_idle = cpuidle_pm_idle;
+		}
 	}
 
 	/* 'power' [R] */
