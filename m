Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vX3P5k0zzF162
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 10:43:29 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7L0dLnT007617
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 20:43:27 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m04x1xh6j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 20:43:27 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 20 Aug 2018 20:43:26 -0400
Subject: Re: [PATCH 8/9] PCI: hotplug: Embed hotplug_slot
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
 <9918fbca94bcfc03d1560b191d138d3e6664cc86.1534686485.git.lukas@wunner.de>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 20 Aug 2018 17:43:17 -0700
MIME-Version: 1.0
In-Reply-To: <9918fbca94bcfc03d1560b191d138d3e6664cc86.1534686485.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <f2ff6486-35bc-2ade-deec-caa7ab15d8e5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2018 07:29 AM, Lukas Wunner wrote:
> When the PCI hotplug core and its first user, cpqphp, were introduced in
> February 2002 with historic commit a8a2069f432c, cpqphp allocated a slot
> struct for its internal use plus a hotplug_slot struct to be registered
> with the hotplug core and linked the two with pointers:
> https://git.kernel.org/tglx/history/c/a8a2069f432c
> 
> Nowadays, the predominant pattern in the tree is to embed ("subclass")
> such structures in one another and cast to the containing struct with
> container_of().  But it wasn't until July 2002 that container_of() was
> introduced with historic commit ec4f214232cf:
> https://git.kernel.org/tglx/history/c/ec4f214232cf
> 
> pnv_php, introduced in 2016, did the right thing and embedded struct
> hotplug_slot in its internal struct pnv_php_slot, but all other drivers
> cargo-culted cpqphp's design and linked separate structs with pointers.
> 
> Embedding structs is preferrable to linking them with pointers because
> it requires fewer allocations, thereby reducing overhead and simplifying
> error paths.  Casting an embedded struct to the containing struct
> becomes a cheap subtraction rather than a dereference.  And having fewer
> pointers reduces the risk of them pointing nowhere either accidentally
> or due to an attack.
> 
> Convert all drivers to embed struct hotplug_slot in their internal slot
> struct.  The "private" pointer in struct hotplug_slot thereby becomes
> unused, so drop it.
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
> Cc: Darren Hart <dvhart@infradead.org

With regards to driver/pci/hotplug/rpa*

Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
