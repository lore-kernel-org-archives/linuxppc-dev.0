Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vWxR2qSKzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 10:38:19 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7L0Xlt5055851
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 20:38:17 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m066g3w6x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 20:38:17 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 20 Aug 2018 20:38:15 -0400
Subject: Re: [PATCH 6/9] PCI: hotplug: Constify hotplug_slot_ops
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Scott Murray <scott@spiteful.org>, linux-s390@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 acpi4asus-user@lists.sourceforge.net, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Sebastian Ott
 <sebott@linux.vnet.ibm.com>, Corentin Chary <corentin.chary@gmail.com>,
 Darren Hart <dvhart@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Andy Shevchenko <andy@infradead.org>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>, Len Brown <lenb@kernel.org>
References: <cover.1534686484.git.lukas@wunner.de>
 <40b17d029c4fbf099535f989b1d6dd013f708a73.1534686485.git.lukas@wunner.de>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 20 Aug 2018 17:38:06 -0700
MIME-Version: 1.0
In-Reply-To: <40b17d029c4fbf099535f989b1d6dd013f708a73.1534686485.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <92f4ee2a-39b8-daa6-ea36-4214e4a438bd@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2018 07:29 AM, Lukas Wunner wrote:
> Hotplug drivers cannot declare their hotplug_slot_ops const, making them
> attractive targets for attackers, because upon registration of a hotplug
> slot, __pci_hp_initialize() writes to the "owner" and "mod_name" members
> in that struct.
> 
> Fix by moving these members to struct hotplug_slot and constify every
> driver's hotplug_slot_ops except for pciehp.
> 
> pciehp constructs its hotplug_slot_ops at runtime based on the PCIe
> port's capabilities, hence cannot declare them const.  It can be
> converted to __write_rarely once that's mainlined:
> http://www.openwall.com/lists/kernel-hardening/2016/11/16/3
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Scott Murray <scott@spiteful.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: Corentin Chary <corentin.chary@gmail.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> ---

With regards to drivers/pci/hotplug/rpa*

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
