Return-Path: <rjwysocki@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v61k07QhzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 18:10:33 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so24288422oic.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 01:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1534686484.git.lukas@wunner.de>
 <40b17d029c4fbf099535f989b1d6dd013f708a73.1534686485.git.lukas@wunner.de>
In-Reply-To: <40b17d029c4fbf099535f989b1d6dd013f708a73.1534686485.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Aug 2018 10:10:19 +0200
Message-ID: <CAJZ5v0i5ibrVf=KVvPsG5DVV3JeRKTwjiToir7=VHK7zqxMmeA@mail.gmail.com>
Subject: Re: [PATCH 6/9] PCI: hotplug: Constify hotplug_slot_ops
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

On Sun, Aug 19, 2018 at 4:36 PM Lukas Wunner <lukas@wunner.de> wrote:
>
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
>  drivers/pci/hotplug/acpiphp_core.c      |  2 +-
>  drivers/pci/hotplug/cpci_hotplug_core.c |  2 +-
>  drivers/pci/hotplug/cpqphp_core.c       |  2 +-
>  drivers/pci/hotplug/ibmphp.h            |  2 +-
>  drivers/pci/hotplug/ibmphp_core.c       |  2 +-
>  drivers/pci/hotplug/pci_hotplug_core.c  | 27 +++++++++++++------------
>  drivers/pci/hotplug/pnv_php.c           |  2 +-
>  drivers/pci/hotplug/rpaphp.h            |  2 +-
>  drivers/pci/hotplug/rpaphp_core.c       |  2 +-
>  drivers/pci/hotplug/s390_pci_hpc.c      |  2 +-
>  drivers/pci/hotplug/sgi_hotplug.c       |  2 +-
>  drivers/pci/hotplug/shpchp_core.c       |  2 +-
>  drivers/pci/pci.c                       |  4 ++--
>  drivers/pci/slot.c                      |  2 +-
>  drivers/platform/x86/asus-wmi.c         |  3 +--
>  drivers/platform/x86/eeepc-laptop.c     |  3 +--
>  include/linux/pci_hotplug.h             | 10 ++++-----
>  17 files changed, 35 insertions(+), 36 deletions(-)

Nice!

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
