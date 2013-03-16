Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DB692C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 12:34:27 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 15 Mar 2013 21:34:23 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9C25F6E801D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 21:34:18 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2G1YKtE310798
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 21:34:20 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2G1YJRk017840
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 22:34:20 -0300
Date: Sat, 16 Mar 2013 09:34:17 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/3] VFIO: VFIO_DEVICE_SET_ADDR_MAPPING command
Message-ID: <20130316013417.GA3873@shangw.(null)>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1363332390-12754-3-git-send-email-shangw@linux.vnet.ibm.com>
 <1363375740.16793.12.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363375740.16793.12.camel@ul30vt.home>
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

On Fri, Mar 15, 2013 at 01:29:00PM -0600, Alex Williamson wrote:
>On Fri, 2013-03-15 at 15:26 +0800, Gavin Shan wrote:
>> The address (domain/bus/slot/function) of the passed PCI device
>> looks quite different from perspective of host and guest. Some
>> architectures like PPC need to setup the mapping in host. The patch
>> introduces additional VFIO device IOCTL command to address that.
>
>Could you explain further how this will be used?  How the device is
>exposed to a guest is entirely a userspace construct, so why does vfio
>need to know or care about this?  I had assumed for AER that QEMU would
>do the translation from host to guest address space.
>

The weak IOCTL function (vfio_pci_arch_ioctl) was introduced by previous
patch. The PowerNV platform is going to override it to figure out the
information for EEH core to use. On the other hand, QEMU will runs into
the IOCTL command while opening (creating) one VFIO device.

Though I'm not familiar with AER very much. AER is quite different from
EEH. The EEH functionality implemented in PHB instead of in PCI device
core. So we don't care AER stuff in EEH directly :-)

>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  include/uapi/linux/vfio.h |   16 ++++++++++++++++
>>  1 files changed, 16 insertions(+), 0 deletions(-)
>> 
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 6e58d9b..ecc4f38 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -289,6 +289,22 @@ struct vfio_irq_set {
>>   */
>>  #define VFIO_DEVICE_RESET		_IO(VFIO_TYPE, VFIO_BASE + 11)
>>  
>> +/**
>> + * VFIO_DEVICE_SET_ADDR_MAPPING - _IO(VFIO_TYPE, VFIO_BASE + 12)
>> + *
>> + * The address, which comprised of domain/bus/slot/function looks
>> + * different between host and guest. We need to setup the mapping
>> + * in host for some architectures like PPC so that the passed PCI
>> + * devices could support RTAS smoothly.
>> + */
>> +struct vfio_addr_mapping {
>> +	__u64 buid;
>
>What's a buid?  Thanks,
>

BUID means "Bus Unit Identifier". BUID is the identifier for specific PHB.
Firmware figures it out and expose to OS through device-tree. For VFIO case,
the QEMU figures it out and expose to guest eventually. It's notable that
the PHB (including buid) figured out by QEMU is virtual and something like
container :-)

>> +	__u8  bus;
>> +	__u8  slot;
>> +	__u8  func;
>> +};
>> +#define VFIO_DEVICE_SET_ADDR_MAPPING	_IO(VFIO_TYPE, VFIO_BASE + 12)
>> +
>>  /*
>>   * The VFIO-PCI bus driver makes use of the following fixed region and
>>   * IRQ index mapping.  Unimplemented regions return a size of zero.
>

Thanks,
Gavin
