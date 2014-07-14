Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C70BD1A00EF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 09:24:56 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 15 Jul 2014 09:24:54 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 061CC3578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 09:24:53 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6EN86ak065864
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 09:08:07 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6ENOpII027564
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 09:24:52 +1000
Date: Tue, 15 Jul 2014 09:24:49 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH] Bugfix: powerpc/eeh: Wrong place to call pci_get_slot()
Message-ID: <20140714232449.GA4711@shangw>
References: <1405325963-1664-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20140714130149.GA4752@shangw> <53C3DC96.70505@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53C3DC96.70505@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2014 at 09:35:18PM +0800, Mike Qiu wrote:
>On 07/14/2014 09:01 PM, Gavin Shan wrote:
>>On Mon, Jul 14, 2014 at 04:19:23AM -0400, Mike Qiu wrote:

.../...

>>>Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>>>---
>>>arch/powerpc/kernel/eeh_pe.c | 29 ++++++++++++++++++++++++++---
>>>1 file changed, 26 insertions(+), 3 deletions(-)
>>>
>>>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>>>index fbd01eb..6f4bfee 100644
>>>--- a/arch/powerpc/kernel/eeh_pe.c
>>>+++ b/arch/powerpc/kernel/eeh_pe.c
>>>@@ -792,6 +792,28 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
>>>}
>>>
>>>/**
>>>+ * __dn_get_pdev - Retrieve the pci_dev from device_node by bus/devfn
>>>+ * @dn: device_node of the pci_dev
>>>+ * @data: the pci device's bus/devfn
>>>+ *
>>>+ * Retrieve the pci_dev using the given device_node and bus/devfn.
>>>+ */
>>>+void *__dn_get_pdev(struct device_node *dn, void *data)
>>>+{
>>The function isn't necessarily public. "static" is enough, I think.
>>I don't think we need this actually. Please refer to more comments
>>below.
>>
>>>+	struct pci_dn *pdn = PCI_DN(dn);
>>>+	int busno = *((int *)data) >> 8;
>>>+	int devfn = *((int *)data) & 0xff;
>>>+
>>>+	if (!pdn)
>>>+		return NULL;
>>>+
>>>+	if (pdn->busno == busno && pdn->devfn == devfn)
>>>+		return pdn->pcidev;
>>>+
>>>+	return NULL;
>>>+}
>>>+
>>>+/**
>>>  * eeh_pe_loc_get - Retrieve location code binding to the given PE
>>>  * @pe: EEH PE
>>>  *
>>>@@ -807,6 +829,7 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
>>>	struct pci_dev *pdev;
>>>	struct device_node *dn;
>>>	const char *loc;
>>>+	int bdevfn;
>>>
>>>	if (!bus)
>>>		return "N/A";
>>>@@ -823,7 +846,9 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
>>>		if (loc)
>>>			return loc;
>>>
>>>-		pdev = pci_get_slot(bus, 0x0);
>>>+		/* Get the root port */
>>>+		bdevfn = (bus->number) << 8 || 0x0;
>>>+		pdev = traverse_pci_devices(hose->dn, __dn_get_pdev, &bdevfn);
>>We needn't search pdev from device-tree and then translate it to
>>device-node. Root port is the only child hooked to root bus's
>>device node (it's also PHB's device-node). So I guess you can
>
>So here you mean, child hooked device node(root port) can be
>hose->dn->child?
>

Yes, I think so.

>>just have something:
>>
>>		/* Check PHB's device node */
>>		dn = pci_bus_to_OF_node(bus);
>>		if (unlikely(!dn)) {
>>			loc = "N/A";
>>			goto out;
>>		}
>>		loc = of_get_property(hose->dn,
>>  				      "ibm,loc-code", NULL);
>>		if (loc)
>>			return loc;
>>		loc = of_get_property(hose->dn,
>>				      "ibm,io-base-loc-code", NULL);
>>		if (loc)
>>			return loc;
>>
>>		/* Check root port */
>>		dn = dn->child;
>>>	} else {
>>>		pdev = bus->self;
>>Here, we needn't grab the bridge as well:
>>
>>		dn = pci_bus_to_OF_node(bus);
>>>	}
>>Then check the device-node of bridge (or root port):
>>
>>	if (unlikely(!dn)) {
>>		loc = "N/A";
>>		goto out;
>>	}
>>
>>         loc = of_get_property(dn, "ibm,loc-code", NULL);
>>         if (!loc)
>>                 loc = of_get_property(dn, "ibm,slot-location-code", NULL);
>>         if (!loc)
>>                 loc = "N/A";
>>
>>>@@ -846,8 +871,6 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
>>>		loc = "N/A";
>>>
>>>out:
>>>-	if (pci_is_root_bus(bus) && pdev)
>>>-		pci_dev_put(pdev);
>>>	return loc;
>>>}
>
>I will make a new patch, after tested, I will resend it out
>

Thanks, Mike.

Thanks,
Gavin
