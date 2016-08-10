Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8Jbs1lNlzDqQb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 14:50:00 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7A3T2RY006446
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 23:35:23 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9qh3fj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 23:35:22 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 10 Aug 2016 13:35:19 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B9C0B357805B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 13:35:16 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7A3ZG8122806608
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 13:35:16 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7A3ZGwS028187
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 13:35:16 +1000
Subject: Re: [PATCH v2 2/2] powerpc: update pci_controller.refcount for PCI
 devices and buses
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1470789844-16401-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1470789844-16401-3-git-send-email-mauricfo@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 10 Aug 2016 13:35:15 +1000
MIME-Version: 1.0
In-Reply-To: <1470789844-16401-3-git-send-email-mauricfo@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3e033c05-bf77-18d3-1822-7973b2525373@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/08/16 10:44, Mauricio Faria de Oliveira wrote:
> This patch employs the refcount in struct pci_controller to track
> the references from PCI devices and buses (struct pci_dev/pci_bus).
>
> In order to do that without modifying any PCI scan/probe approach
> (e.g., PCI_PROBE_DEVTREE and PCI_PROBE_NORMAL), it leverages some
> of the PCI arch-specific callback: pci_(add|release)_device() and
> pci_(add|remove)_bus().
>
> (a small change is required for PCI_PROBE_DEVTREE, which makes it
> consistent with PCI_PROBE_NORMAL - the pci_dev should inherit the
> parent pci_bus's phb pointer - see pci_setup_device() in probe.c)
>
> This also has the advantage that locking for kref_(get|put)() is
> satisfied by the 'pci_rescan_remove_lock' mutex, which is normal
> practice for usage of the PCI subsystem - thus already in place.
> More details added in comment on pcibios_release_device().
>
> Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

>  void pcibios_release_device(struct pci_dev *dev)
>  {
>  	struct pci_controller *phb = pci_bus_to_host(dev->bus);
>
> +	pr_debug("PCI %s, pci_dev %p, phb %p\n", dev_name(&dev->dev), dev, phb);
> +
>  	eeh_remove_device(dev);
>
>  	if (phb->controller_ops.release_device)
>  		phb->controller_ops.release_device(dev);
> +
> +	if (unlikely(!phb))
> +		pr_warn("%s: PCI device %s has null PHB; refcount bug!",
> +			__func__, dev_name(&dev->dev)); /* WARN_ON ahead */

This should probably go before trying to dereference phb->controller_ops 
above?


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
