Return-Path: <rjwysocki@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v69l0VthzF1P8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 18:17:30 +1000 (AEST)
Received: by mail-oi0-f67.google.com with SMTP id b16-v6so24351700oic.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 01:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1534686484.git.lukas@wunner.de>
 <9918fbca94bcfc03d1560b191d138d3e6664cc86.1534686485.git.lukas@wunner.de>
In-Reply-To: <9918fbca94bcfc03d1560b191d138d3e6664cc86.1534686485.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Aug 2018 10:17:17 +0200
Message-ID: <CAJZ5v0g-fNj7ESGMDOiotiGM9ztngCRgpKLfQaXmH+cgObi+iQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] PCI: hotplug: Embed hotplug_slot
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 okaya@kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Len Brown <lenb@kernel.org>, scott@spiteful.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, gwshan@linux.vnet.ibm.com,
 sebott@linux.vnet.ibm.com,
 gerald.schaefer@de.ibm.com, Corentin Chary <corentin.chary@gmail.com>,
 Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-s390@vger.kernel.org,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 acpi4asus-user@lists.sourceforge.net,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 19, 2018 at 4:46 PM Lukas Wunner <lukas@wunner.de> wrote:
>
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
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> ---
>  drivers/pci/hotplug/acpiphp.h           |  9 ++-
>  drivers/pci/hotplug/acpiphp_core.c      | 28 +++-----
>  drivers/pci/hotplug/acpiphp_ibm.c       |  2 +-
>  drivers/pci/hotplug/cpci_hotplug.h      |  9 ++-
>  drivers/pci/hotplug/cpci_hotplug_core.c | 37 ++++------
>  drivers/pci/hotplug/cpci_hotplug_pci.c  |  6 +-
>  drivers/pci/hotplug/cpqphp.h            |  9 ++-
>  drivers/pci/hotplug/cpqphp_core.c       | 37 ++++------
>  drivers/pci/hotplug/cpqphp_ctrl.c       |  2 -
>  drivers/pci/hotplug/ibmphp.h            |  7 +-
>  drivers/pci/hotplug/ibmphp_core.c       | 92 +++++++++++--------------
>  drivers/pci/hotplug/ibmphp_ebda.c       | 37 +++-------
>  drivers/pci/hotplug/pciehp.h            | 11 ++-
>  drivers/pci/hotplug/pciehp_core.c       | 37 ++++------
>  drivers/pci/hotplug/pciehp_ctrl.c       |  4 +-
>  drivers/pci/hotplug/pciehp_hpc.c        |  8 +--
>  drivers/pci/hotplug/pnv_php.c           |  9 ++-
>  drivers/pci/hotplug/rpaphp.h            |  7 +-
>  drivers/pci/hotplug/rpaphp_core.c       | 14 ++--
>  drivers/pci/hotplug/rpaphp_slot.c       | 15 ++--
>  drivers/pci/hotplug/s390_pci_hpc.c      | 30 ++++----
>  drivers/pci/hotplug/sgi_hotplug.c       | 52 ++++++--------
>  drivers/pci/hotplug/shpchp.h            |  6 +-
>  drivers/pci/hotplug/shpchp_core.c       | 17 ++---
>  drivers/platform/x86/asus-wmi.c         | 26 +++----
>  drivers/platform/x86/eeepc-laptop.c     | 30 ++++----
>  include/linux/pci_hotplug.h             |  3 -
>  27 files changed, 223 insertions(+), 321 deletions(-)

Good cleanup.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
