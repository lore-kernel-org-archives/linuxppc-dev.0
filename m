Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0AEC1A0BA2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 14:26:07 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 13:26:07 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DEC642CE8070
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 14:26:05 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB43Q5NT42336410
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 14:26:05 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB43Q5ZZ004191
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Dec 2014 14:26:05 +1100
Date: Thu, 4 Dec 2014 11:26:04 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pci: remove pci device on a bus in reverse order
Message-ID: <20141204032604.GA8943@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1417662272-8444-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417662272-8444-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please ignore this one, I create an old version of the patch.

The new one is sent.

On Thu, Dec 04, 2014 at 11:04:32AM +0800, Wei Yang wrote:
>As in commit ac205b7b (PCI: make sriov work with hotplug remove) indicates,
>when removing pci devices on a bus which has VFs, we need to remove them in
>the reverse order.
>
>This patch applies this patten on the hotplug remove patch on powerpc arch.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> arch/powerpc/kernel/pci-hotplug.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
>index 5b78917..f0f00d9 100644
>--- a/arch/powerpc/kernel/pci-hotplug.c
>+++ b/arch/powerpc/kernel/pci-hotplug.c
>@@ -50,7 +50,7 @@ void pcibios_remove_pci_devices(struct pci_bus *bus)
>
> 	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
> 		 pci_domain_nr(bus),  bus->number);
>-	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
>+	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
> 		pr_debug("   Removing %s...\n", pci_name(dev));
> 		pci_stop_and_remove_bus_device(dev);
> 	}
>-- 
>1.7.9.5

-- 
Richard Yang
Help you, Help me
