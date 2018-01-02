Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z9shd209QzDqxK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jan 2018 22:46:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: david@gibson.dropbear.id.au, benh@au1.ibm.com
Subject: Re: [PATCH v2 1/1] powerpc/pseries: increase pseries_dlpar_init
 initcall priority
In-Reply-To: <20171226125359.23706-2-joserz@linux.vnet.ibm.com>
References: <20171226125359.23706-1-joserz@linux.vnet.ibm.com>
 <20171226125359.23706-2-joserz@linux.vnet.ibm.com>
Date: Tue, 02 Jan 2018 22:46:07 +1100
Message-ID: <87373otreo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com> writes:

> The hotplug engine uses its own workqueue to handle IRQ requests, the
> problem is that such workqueue is initialized after init_ras_IRQ, which
> will cause a kernel panic if any hotplug interruption is issued in that
> period of time.
>
> This patch changes the dlpar initcall registration to make sure it will
> be initialized before init_ras_IRQ.

Sorry I know this is already v2, but I don't think this is the best fix.

There's a dependency between the registration of the IRQ in the RAS
code, and the creation of the work queue in the DLPAR code, but it's
currently not explicit. That's the bug. So it'd be better to just make
it explicit.

As a bonus we can add actual error checking of the workqueue allocation.

Something like below, can you test it please?

cheers

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 6e35780c5962..dd8b29e58a98 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -574,11 +574,26 @@ static ssize_t dlpar_show(struct class *class, struct class_attribute *attr,
 
 static CLASS_ATTR_RW(dlpar);
 
-static int __init pseries_dlpar_init(void)
+int __init dlpar_workqueue_init(void)
 {
+	if (pseries_hp_wq)
+		return 0;
+
 	pseries_hp_wq = alloc_workqueue("pseries hotplug workqueue",
 					WQ_UNBOUND, 1);
+
+	return pseries_hp_wq ? 0 : -ENOMEM;
+}
+
+static int __init dlpar_sysfs_init(void)
+{
+	int rc;
+
+	rc = dlpar_workqueue_init();
+	if (rc)
+		return rc;
+
 	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
 }
-machine_device_initcall(pseries, pseries_dlpar_init);
+machine_device_initcall(pseries, dlpar_sysfs_init);
 
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 4470a3194311..1ae1d9f4dbe9 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -98,4 +98,6 @@ static inline unsigned long cmo_get_page_size(void)
 	return CMO_PageSize;
 }
 
+int dlpar_workqueue_init(void);
+
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 4923ffe230cf..879a92327010 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -69,8 +69,9 @@ static int __init init_ras_IRQ(void)
 	/* Hotplug Events */
 	np = of_find_node_by_path("/event-sources/hot-plug-events");
 	if (np != NULL) {
-		request_event_sources_irqs(np, ras_hotplug_interrupt,
-					   "RAS_HOTPLUG");
+		if (dlpar_workqueue_init() == 0)
+			request_event_sources_irqs(np, ras_hotplug_interrupt,
+						"RAS_HOTPLUG");
 		of_node_put(np);
 	}
 
