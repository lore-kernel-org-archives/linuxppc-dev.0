Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C12711400BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 17:44:48 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 22 Apr 2014 13:14:44 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1DFE4E0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 13:19:07 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3M7ib8N66650202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 13:14:37 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3M7idqc024057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 13:14:40 +0530
Date: Tue, 22 Apr 2014 15:44:37 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: clear the refcount for pci_dev on
 powernv platform
Message-ID: <20140422074437.GB6431@richard>
References: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140421233423.GA4023@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140421233423.GA4023@shangw>
Cc: aik@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2014 at 09:34:23AM +1000, Gavin Shan wrote:
>On Mon, Apr 21, 2014 at 10:25:18AM +0800, Wei Yang wrote:
>>When pcibios_remove_pci_devices() is removing pci devices, it will release
>>pci device respectively. When the refcount of the device is 0, the pci_dev
>>structure will be destroyed.
>>
>>On PowerNV platform, the pci_dev will not be destroyed since the refcount is
>>not 0.
>>
>
>Richard, the above description is true. However, it's not relevant to the
>issue (backtrace). I don't quite understand the scenario you had. You're
>doing hotplug on VFs or PF? I guess it would be full-hotplug instead of
>partial hotplug.

I am doing hotplug on PF.

>
>It seems that the IOMMU group wasn't detached correctly and then we tried
>to attach it again. Or the IOMMU group was attached for towice? :-)

Did more tests and find it is a little out of expectation. The conclusion is:
1. The iommu group is detached correctly, 
2. The iommu group is attached three times
3. The warning is cleared based on the first patch instead of this one.

The three times to attach the iommu_group is:

    pci_device_add
       ...
       set_iommu_table_base_and_group   <- 1st time, fail
    device_add
       ...
       tce_iommu_bus_notifier           <- 2nd time, succees
    pcibios_add_pci_devices
       ...
       pcibios_setup_bus_devices        <- 3rd time, re-attach

The error in patch 1 happens at the first time, since the dev->kobj->sd is not
initialized.
The warning in patch 2 happens at the 3rd time, since iommu group is already
attached in the 2nd time.

So this patch(the 2nd one) doesn't contribute to clear the warning and error.
Only the first patch did it. Please ignore this one.

>
>The IOMMU group is expected to be detached like this, please investigate
>for more why it wasn't detached correctly.
>
>pcibios_remove_pci_devices()
>pci_stop_and_remove_bus_device()
>pci_remove_bus_device()
>pci_destroy_dev()

>
>static void pci_destroy_dev(struct pci_dev *dev)
>{
>        if (!dev->dev.kobj.parent)
>                return;
>
>        device_del(&dev->dev);              /* It's calling iommu_del_device() */
>
>        down_write(&pci_bus_sem);
>        list_del(&dev->bus_list);
>        up_write(&pci_bus_sem);
>
>        pci_free_resources(dev);
>        put_device(&dev->dev);		    /* It's calling pcibios_release_device() */
>}
>


-- 
Richard Yang
Help you, Help me
