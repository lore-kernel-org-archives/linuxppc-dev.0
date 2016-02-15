Return-Path: <clombard@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB7271A0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 07:54:03 +1100 (AEDT)
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 15 Feb 2016 20:53:58 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 036BE2190019
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 20:53:42 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1FKruea2752818
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 20:53:56 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1FKruSE023888
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 13:53:56 -0700
Subject: Re: [PATCH v3 14/18] cxl: Support to flash a new image on the adapter
 from a guest
To: Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, michael.neuling@au1.ibm.com
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-15-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1455097101-sup-8413@delenn.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Message-ID: <56C23AE2.8050608@linux.vnet.ibm.com>
Date: Mon, 15 Feb 2016 21:53:54 +0100
MIME-Version: 1.0
In-Reply-To: <1455097101-sup-8413@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> @mpe since this patch introduces a new user API I'd appreciate it if you
> could give this a bit extra scrutiny.
>
> Excerpts from Frederic Barrat's message of 2016-02-07 00:29:01 +1100:
>> +    Starts and controls flashing a new FPGA image. Partial
>> +    reconfiguration is not supported (yet), so the image must contain
>> +    a copy of the PSL and AFU(s). Since an image can be quite large,
>> +    the caller may have to iterate, splitting the image in smaller
>> +    chunks.
> Does that mean they will call the ioctl multiple times with additional
> chunks?
right. The maximum size of each chunks supported by the platform - phyp -
is 1 MB during the download/validate phase.
> I assume that PowerVM will take care of most of this for us, but
> still worth checking for my own assurances if nothing else - what
> happens if the process is interrupted and they never pass us the final
> chunk?
several checking are performed when a new FPGA image is flashing. A maximum
time is supported between each call, otherwise the sequence is aborted.


> Could we have a partially flashed image, or is it buffered until
> the entire image is in kernel / hypervisor memory before starting to
> actually perform the flash?
The entire image is not buffered in the kernel. Each chunk of the image,
sent by the caller is handled and "forwarded" to the partition.
> If it is interrupted, how is the process restarted from the beginning -
> I guess it's when the internal continue token is set back to 0 on
> close/open?
when an issue occurred, the platform is resetted and a new
operation can be performed. The continue token is effectively set back
to 0 on close/open.
>> +    Takes a pointer to a struct cxl_adapter_image:
>> +    struct cxl_adapter_image {
>> +        __u32 version;
> You have a 32bit hole here since the next item is a pointer - add a
> flags or reserved field here if you have nothing else for it (and check
> that it is passed as 0).
ok.
>> +        __u8 *data;
> A pointer will either be 32bits or 64bits depending on the userspace
> process calling this. This also means there is a 32bit hole here on
> 32bit applications - I'd be inclined to define this as a __u64 instead
> and have userspace cast the pointer to that, but mpe might have other
> suggestions.
>
>> +        __u64 len_data;
>> +        __u64 len_image;
>> +        __u32 need_header;
>> +        __u32 op;
> Maybe add a couple of reserved fields now to allow for future additions
> to this API (and make sure they are passed as 0), especially in case we
> end up supporting this on bare metal.
ok
>> +    };
>> +
>> +    version:
>> +        Describes the version of the structure.
> So, this is a little different to the other cxl user APIs, where we
> decided to use a flags field, with each bit either reserved for future
> use (verify they are 0) or signifying that an optional parameter has
> been set. For consistency, it would probably be a good idea to do the
> same here.
ok
>> +    op:
>> +        Operation requested. After it is written, an image must be
>> +        verified.
> So we have a multiplexed-multiplexed call now? Split this into two
> separate ioctls please.
>
> What happens if userspace doesn't verify the image for whatever reason,
> or what if the verification fails? I'd hope that PowerVM already handles
> this gracefully for us, but still worth checking...
PowerVM verifies the image bitstream data chunk. If it determines
that the image is not valid an error is returned. Then the CXL driver 
resets the platform.
Otherwise, a new operation can be performed by the caller even if the 
platform
loads a bad image.
>> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> ...
>> +struct cxl_adapter_image {
>> +    __u32 version;
>> +    __u8 *data;
>> +    __u64 len_data;
>> +    __u64 len_image;
>> +    __u32 need_header;
>> +    __u32 op;
>> +};
> This user API definition should be in include/uapi/misc/cxl.h with all
> the other ones we can't afford to break.
>
>> diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
>> +#define CXL_IOCTL_TRANSFER_IMAGE _IOR(CXL_MAGIC, 0x10, struct cxl_adapter_image)
> This definition needs to go in include/uapi/misc/cxl.h...
>
>> +#define ADAPTER_IMAGE_HEADER_SIZE 128
>> +#define MAX_CHUNK_SIZE (SG_BUFFER_SIZE * SG_MAX_ENTRIES)
>> +#define DOWNLOAD_IMAGE 1
>> +#define VALIDATE_IMAGE 2
>> +#define INITIAL_VERSION 1
> ...along with anything from these that userspace may be expected to pass
> to the kernel, appropriately renamed to namespace them under CXL_
ok
>> +static u64 token;
> You have several local variables of the same name that will mask this in
> the functions where they are defined - change this to a unique name to
> remove the ambiguity and to make it easy to search through the file for.
You are right.
>> +static int device_open(struct inode *inode, struct file *file)
>> +{
> ...
>> +    /* Allows one process to open the device by using a semaphore */
>> +    if (down_interruptible(&sem) != 0)
>> +        return -EPERM;
> Good, first thing I thought to check :)
>
>> +static const struct file_operations fops = {
>> +    .owner        = THIS_MODULE,
>> +    .open        = device_open,
>> +    .unlocked_ioctl    = device_ioctl,
> You also need a .compat_ioctl defined for 32bit applications to be able
> to call this.
ok
>> +void cxl_guest_reload_module(struct cxl *adapter)
>> +{
>> +    struct platform_device *pdev;
>> +    int afu;
>> +
>> +    for (afu = 0; afu < adapter->slices; afu++)
>> +        cxl_guest_remove_afu(adapter->afu[afu]);
> Should we possibly have done this part earlier?
>
> I'd think it should be done before any operation that might lead to us
> resetting the card. Probably the safest thing is to do it when the first
> chunk is handed to the kernel so we can make sure it's safe, and return
> -EBUSY if any of the AFUs are still in use.
Not necessary. PowerVM - phyp - refuses any type of action when an operation
of download/validation is in progress. The reverse is true as well.

>> +    cxl_guest_remove_adapter(adapter);
> This part should be fine here :)
>
> Cheers,
> -Ian
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
