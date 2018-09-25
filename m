Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K9ry6dcRzF3Dr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 16:19:30 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8P6JLLt015953
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 02:19:28 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mqe1akr0a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 02:19:28 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 25 Sep 2018 02:19:27 -0400
Date: Tue, 25 Sep 2018 11:49:21 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, tyreld@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Disable CPU hotplug across migrations
Reply-To: ego@linux.vnet.ibm.com
References: <153721164232.32706.4283915467151746975.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <CAHZ_5WxcDxV5vrdW5Y1QaucXLL8Z4xskEbm+y4VFeNsj-38e7g@mail.gmail.com>
 <d0a4995c-949b-f6a4-889a-908e6f72036e@linux.vnet.ibm.com>
 <87va6v5qhx.fsf@concordia.ellerman.id.au>
 <20180924085606.GA16671@in.ibm.com>
 <87h8ie5rxe.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h8ie5rxe.fsf@concordia.ellerman.id.au>
Message-Id: <20180925061921.GB32534@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2018 at 10:42:05AM +1000, Michael Ellerman wrote:
[..snip..]
> I'm not suggesting we try to bring them online after we've disabled CPU
> hotplug, if we detect that race we can just fail the migration.
> 
> Can't we do:
>  - save mask of offline CPUs
>  - bring all offline CPUs online
>  - disable CPU hotplug
>  - check if any CPUs are offline
>    - if so, we've raced with an offline
>    - bail out of the migration with an error
> 
> 
> Instead of bailing out we could go back to the start and try again for
> some number of retries, but that's probably overkill anyway.
> 
> What am I missing?

I guess that will work. The race is unlikely anyway, so I doubt
CPU-Hotplug can DDOS the partition migration.

Does the following implementation of the same look ok ? (Build tested) 

------------------------------------ X8------------------------------------- 
>From acb9eb9f8bb14cf3121aeb0589255cbc31292be7 Mon Sep 17 00:00:00 2001
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Date: Tue, 25 Sep 2018 11:01:18 +0530
Subject: [PATCH] powerpc/rtas: Fix a potential race between CPU-Offline & Migration

commit 85a88cabad57 ("powerpc/pseries: Disable CPU hotplug across
migrations") disables any CPU-hotplug operations when Live Partition
Migration is in progress. However, there is a minor race-window
between the time all the CPUs are onlined by rtas_ibm_suspend_me() and
the CPU-Hotplugs are disabled via cpu_hotplug_disable() when some CPUs
could be offlined by the userspace, thus nullifying the assumption
that all the CPUs are online at this point.

This patch fixes this by checking if all the present CPUs are brought
online after disabling CPU-Hotplug. Otherwise, it retries to bring the
CPUs online again for a finite number of times failing which
rtas_ibm_suspend_me() returns -EBUSY.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 2c7ed31..e6a6425 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -934,6 +934,8 @@ int rtas_offline_cpus_mask(cpumask_var_t cpus)
 }
 EXPORT_SYMBOL(rtas_offline_cpus_mask);
 
+#define MAX_SUSPEND_HOTPLUG_RETRIES    5
+
 int rtas_ibm_suspend_me(u64 handle)
 {
 	long state;
@@ -943,6 +945,7 @@ int rtas_ibm_suspend_me(u64 handle)
 	DECLARE_COMPLETION_ONSTACK(done);
 	cpumask_var_t offline_mask;
 	int cpuret;
+	int retries = MAX_SUSPEND_HOTPLUG_RETRIES;
 
 	if (!rtas_service_present("ibm,suspend-me"))
 		return -ENOSYS;
@@ -972,6 +975,7 @@ int rtas_ibm_suspend_me(u64 handle)
 	data.token = rtas_token("ibm,suspend-me");
 	data.complete = &done;
 
+again:
 	/* All present CPUs must be online */
 	cpumask_andnot(offline_mask, cpu_present_mask, cpu_online_mask);
 	cpuret = rtas_online_cpus_mask(offline_mask);
@@ -982,6 +986,19 @@ int rtas_ibm_suspend_me(u64 handle)
 	}
 
 	cpu_hotplug_disable();
+
+	/* Check if we raced with a CPU-Offline Operation */
+	if (unlikely(!cpumask_equal(cpu_present_mask, cpu_online_mask))) {
+		cpu_hotplug_enable();
+		if (retries-- > 0)
+			goto again;
+
+		pr_err("%s: Too many concurrent CPU-Offline operation in progress\n",
+		       __func__);
+		atomic_set(&data.error, -EBUSY);
+		goto out;
+	}
+
 	stop_topology_update();
 
 	/* Call function on all CPUs.  One of us will make the
-- 
1.9.4
