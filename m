Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53C4F2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 14:34:28 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 15 Mar 2013 23:34:25 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B20406E801D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 23:34:19 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2G3YLVk62652626
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 23:34:21 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2G3YKX8000397
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 23:34:21 -0400
Date: Sat, 16 Mar 2013 11:34:18 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 3/3] VFIO: Direct access config reg without capability
Message-ID: <20130316033418.GA23132@shangw.(null)>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1363332390-12754-4-git-send-email-shangw@linux.vnet.ibm.com>
 <1363376468.16793.18.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363376468.16793.18.camel@ul30vt.home>
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, kvm@vger.kernel.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 15, 2013 at 01:41:08PM -0600, Alex Williamson wrote:
>On Fri, 2013-03-15 at 15:26 +0800, Gavin Shan wrote:
>> The config registers in [0, 0x40] is being supported by VFIO. Apart
>> from that, the other config registers should be coverred by PCI or
>> PCIe capability. However, there might have some PCI devices (be2net)
>> who has config registers (0x7c) out of [0, 0x40], and don't have
>> corresponding PCI or PCIe capability. VFIO will return 0x0 on reading
>> those registers and writing is dropped. It caused the be2net driver
>> fails to be loaded because 0x0 returned from its config register 0x7c.
>> 
>> The patch changes the behaviour so that those config registers out
>> of [0, 0x40] and don't have corresponding PCI or PCIe capability
>> will be accessed directly.
>
>This basically gives userspace free access to any regions that aren't
>covered by known capabilities.  We have no idea what this might expose
>on some devices.  I'd like to support be2net, but what's the minimal
>access that it needs?  Can we provide 2 or 4 bytes of read-only access
>at offset 0x7c for just that device?  Is it always 0x7c?  Let's split
>this patch from the series since it's clearly dealing with something
>independent.  Thanks,
>

0x7c is just one example. Actually, benet driver also need access other
uncoverred config registers like 0x58/0xf0/0xfc (by capabilities) in orde
to make the device work well. All of those uncoverred config registers
are really business of specific device itself. I think we might not bother
their accessing attributes. So exporting those uncoverred registers to
user space might be the reasonable choice.

If we really want to control the accessing attributes for those uncoverred
registers, we might introduce some mechanism to check the vendor/device ID
and read/write to the uncoverred registers according the specified bits.
All of that requires fully understanding the usage of those uncoverred registers.

Yes, I will split this one from the patchset.

Thanks,
Gavin

>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  drivers/vfio/pci/vfio_pci_config.c |   31 ++++++++++++++++++++-----------
>>  1 files changed, 20 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
>> index 964ff22..5ea3afb 100644
>> --- a/drivers/vfio/pci/vfio_pci_config.c
>> +++ b/drivers/vfio/pci/vfio_pci_config.c
>> @@ -1471,18 +1471,27 @@ static ssize_t vfio_config_do_rw(struct vfio_pci_device *vdev, char __user *buf,
>>  
>>  	cap_id = vdev->pci_config_map[*ppos / 4];
>>  
>> +	/*
>> +	 * Some PCI device config registers might not be coverred by
>> +	 * capability and useful. We will enable direct access to
>> +	 * those registers.
>> +	 */
>>  	if (cap_id == PCI_CAP_ID_INVALID) {
>> -		if (iswrite)
>> -			return ret; /* drop */
>> -
>> -		/*
>> -		 * Per PCI spec 3.0, section 6.1, reads from reserved and
>> -		 * unimplemented registers return 0
>> -		 */
>> -		if (copy_to_user(buf, &val, count))
>> -			return -EFAULT;
>> -
>> -		return ret;
>> +		if (iswrite) {
>> +			if (copy_from_user(&val, buf, count))
>> +				return -EFAULT;
>> +			ret = vfio_user_config_write(vdev->pdev, (int)(*ppos),
>> +						     val, count);
>> +			return ret ? ret : count;
>> +		} else {
>> +			ret = vfio_user_config_read(vdev->pdev, (int)(*ppos),
>> +						    &val, count);
>> +			if (ret)
>> +				return ret;
>> +			if (copy_to_user(buf, &val, count))
>> +				return -EFAULT;
>> +			return count;
>> +		}
>>  	}
>>  
>>  	/*
>
>
>
