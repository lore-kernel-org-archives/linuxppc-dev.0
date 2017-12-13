Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxghR1RdSzDrd5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 02:33:42 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBDFTLUs041887
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 10:33:41 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eu3m3aqva-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 10:33:40 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Wed, 13 Dec 2017 10:33:27 -0500
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v1 2/7] powerpc/kernel: Add uevents in EEH error/resume
Date: Wed, 13 Dec 2017 09:32:37 -0600
In-Reply-To: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20171213153242.98015-3-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Devices can go offline when EEH is reported. This patch adds
a change to the kernel object and lets udev know of error.
When device resumes a change is also set reporting device as
online. Therefore, EEH events are better propagated to user
space for devices in powerpc arch.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 3c0fa99c5533..c61bf770282b 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -204,6 +204,7 @@ static void *eeh_report_error(void *data, void *userdata)
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
+	char *envp[] = {"EVENT=EEH_ERROR", "ONLINE=0", NULL};
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
@@ -228,6 +229,7 @@ static void *eeh_report_error(void *data, void *userdata)
 
 	edev->in_error = true;
 	eeh_pcid_put(dev);
+	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
 	return NULL;
 }
 
@@ -358,6 +360,7 @@ static void *eeh_report_resume(void *data, void *userdata)
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	bool was_in_error;
 	struct pci_driver *driver;
+	char *envp[] = {"EVENT=EEH_RESUME", "ONLINE=1", NULL};
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
@@ -379,8 +382,8 @@ static void *eeh_report_resume(void *data, void *userdata)
 	}
 
 	driver->err_handler->resume(dev);
-
 	eeh_pcid_put(dev);
+	kobject_uevent_env(&dev->dev.kobj, KOBJ_CHANGE, envp);
 	return NULL;
 }
 
-- 
2.14.3 (Apple Git-98)
