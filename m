Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7283C1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 20:03:45 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 14 May 2015 20:03:43 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7B17A2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 20:03:41 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4EA3W0G30933128
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 20:03:41 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4EA38L9000413
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 20:03:08 +1000
Date: Thu, 14 May 2015 18:02:50 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 9/9] powerpc/eeh: handle VF PE properly
Message-ID: <20150514100250.GB12847@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-10-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150513011630.GA8973@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150513011630.GA8973@gwshan>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 13, 2015 at 11:16:30AM +1000, Gavin Shan wrote:
>> 	 * Actually, we should remove the PCI bridges as well.
>>@@ -416,7 +450,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
>> 	driver = eeh_pcid_get(dev);
>> 	if (driver) {
>> 		eeh_pcid_put(dev);
>>-		if (driver->err_handler)
>>+		if (removed && driver->err_handler)
>> 			return NULL;
>> 	}
>>
>>@@ -425,11 +459,21 @@ static void *eeh_rmv_device(void *data, void *userdata)
>> 		 pci_name(dev));
>> 	edev->bus = dev->bus;
>> 	edev->mode |= EEH_DEV_DISCONNECTED;
>>-	(*removed)++;
>>-
>>-	pci_lock_rescan_remove();
>>-	pci_stop_and_remove_bus_device(dev);
>>-	pci_unlock_rescan_remove();
>>+	if (removed)
>>+		(*removed)++;
>>+
>>+#ifdef CONFIG_PCI_IOV
>>+	if (edev->mode & EEH_DEV_VF) {
>>+		pci_iov_virtfn_remove(edev->physfn, pdn->vf_index, 0);
>>+		edev->pdev = NULL;
>>+		pdn->pe_number = IODA_INVALID_PE;
>
>Setting the PE number to invalid one seems not correct because the PE
>is still consumed by the VF's RID.
>

In commit 781a868f3136, we introduce the check of pdn->pe_number in
pnv_pci_dma_dev_setup(). Since VFs are create/released dynamically, we need to
delay the bind between PE and the device. Then to avoid rebind it, we check
the pdn->pe_number. The WARN_ON() is what you suggested.

So if don't clear the pe_number here, we break that rule.


-- 
Richard Yang
Help you, Help me
