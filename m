Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlVmL3msczDql5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 18:15:14 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6788jqC080774
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 04:15:12 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xm17vk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 04:15:11 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 7 Jul 2016 18:15:09 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id ACC663578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 18:15:07 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u678F7n666977988
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 18:15:07 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u678F7Nr006467
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 18:15:07 +1000
Subject: Re: [PATCH 14/14] cxl: Add cxl_check_and_switch_mode() API to switch
 bi-modal cards
To: Ian Munsie <imunsie@au1.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-15-git-send-email-imunsie@au.ibm.com>
 <577D533E.4030605@linux.vnet.ibm.com>
 <23e62784-d67a-1e08-ed60-99a50a15b249@au1.ibm.com>
 <1467872513-sup-7704@x230.ozlabs.ibm.com>
 <8ae21f63-a17e-5b57-3a9a-1c38eae358ed@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Huy Nguyen
 <huyn@mellanox.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 7 Jul 2016 18:15:06 +1000
MIME-Version: 1.0
In-Reply-To: <8ae21f63-a17e-5b57-3a9a-1c38eae358ed@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <48b96bd7-70fa-3169-ea1f-7ca66b69e41a@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/16 16:44, Andrew Donnellan wrote:
> We can match the vendor, device ID *and* class code - unfortunately
> there isn't a macro for this, which makes it a little bit less
> aesthetically pleasing, but I'm pretty sure this works.

Something like the below, which works fine:

/*
  * Matches a given PCI vendor ID and device ID, but only for class 12
  * (processing accelerators). Useful for bi-modal cards, such as the
  * Mellanox ConnectX-4, which keep the same vendor/device ID
  * post-mode-switch.
  */
#define PCI_DEVICE_ACCEL(vend, dev) \
	.vendor = (vend), .device = (dev), \
	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
	.class = 0x120000, .class_mask = 0xff0000

static const struct pci_device_id cxl_pci_tbl[] = {
	/* FPGA devices */
	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0477), },
	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x04cf), },
	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0601), },
	/* Mellanox ConnectX-4 */
	{ PCI_DEVICE_ACCEL(PCI_VENDOR_ID_MELLANOX, 0x1013), },
	{ }
};
MODULE_DEVICE_TABLE(pci, cxl_pci_tbl);


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
