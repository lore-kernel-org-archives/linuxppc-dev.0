Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5A2E31400B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 16:04:04 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 21 Apr 2014 11:34:00 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8D05C1258048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 11:36:39 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3L63sZV13828580
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 11:33:54 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3L63tJw018892
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 11:33:55 +0530
Date: Mon, 21 Apr 2014 14:03:53 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: clear the refcount for pci_dev on
 powernv platform
Message-ID: <20140421060353.GB24712@richard>
References: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1398051334.19682.14.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398051334.19682.14.camel@pasglop>
Cc: aik@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 Gavin Shan <gwshan@au1.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2014 at 01:35:34PM +1000, Benjamin Herrenschmidt wrote:
>On Mon, 2014-04-21 at 10:25 +0800, Wei Yang wrote:
>> When pcibios_remove_pci_devices() is removing pci devices, it will release
>> pci device respectively. When the refcount of the device is 0, the pci_dev
>> structure will be destroyed.
>> 
>> On PowerNV platform, the pci_dev will not be destroyed since the refcount is
>> not 0.
>> 
>> After applying the patch, this warning is cleared during the EEH hotplug
>> event.
>
>You have to be careful here. We take a reference to the device in the
>structure eeh_dev, that means we might access it after it's freed if
>we don't increase the refcount.

Ben,

Thanks for reminding.

Hmm, I checked the eeh_dev structure, there is a field pdev in eeh_dev, which
is not a ref to the device.

Then I did a check in eeh hotplug code patch. The pci_dev remove/install
happens in eeh_reset_device(), between pcibios_remove_pci_devices() and
pcibios_add_pci_devices(). During this period, we will try to clear/set the PE
state and restore the BAR of a pci device. But the BAR is restored through the
device node instead of pci_dev structure. As my understanding the eeh code
here has the assumption that these pci devices in the same PE are removed.
Maybe I missed something, needs confirmation from Gavin.

The code I removed in this patch is introduced in commit
184cd4a3(powerpc/powernv: PCI support for p7IOC under OPAL v2).
Sounds the original purpose is to make sure a pci device is covered by a Bus
PE, so don't remove it. After booting up, Bus PE will always be there, which
means we will always hold a refcount to a pci device.

I didn't come up with a better idea, or leaving the warning is fine.

Any comments are welcome :)

>
>Cheers,
>Ben.
>
