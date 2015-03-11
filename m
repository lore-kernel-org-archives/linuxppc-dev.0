Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 339801A0701
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 19:35:09 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 14:05:06 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 63A95E0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 14:07:02 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2B8Z1IL43450406
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 14:05:01 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2B8Yxol031725
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 14:05:00 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Thomas Huth <thuth@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH SLOF] pci-properties: Remove redundant call to device-type
In-Reply-To: <20150311085030.43ac4fac@oc7435384737.ibm.com>
References: <1426055192-28691-1-git-send-email-aik@ozlabs.ru>
 <20150311085030.43ac4fac@oc7435384737.ibm.com>
Date: Wed, 11 Mar 2015 14:04:59 +0530
Message-ID: <87sidcc4p8.fsf@abhimanyu.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Huth <thuth@linux.vnet.ibm.com> writes:

> On Wed, 11 Mar 2015 17:26:32 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>> At the moment SLOF adds a "device_type" property automatically for
>> every single PCI device based on its class even if there is no SLOF
>> driver for such a device. OF1275 says that "device_type" is for
>> implemented interfaces only. A side effect of this is virtio-balloon
>> getting device_type=="memory" while it should not have.
>> 
>> This removes automatic call to device-type from the common PCI code.
>> Since now, we rely on existing SLOF PCI drivers to call device-type if
>> needed. virtio-blk/net, e1000, ohci/ehci/xhci do this. virtio-scsi
>> does not create the property for itself but disks on its bus do.
>> virtio-ballon won't get the device_type property as there is no driver
>> for it.
>

Looks good to me.

> Sounds very reasonable, but I think there are a couple of other things
> you could/should check:
>
> - Graphic cards should get the "display" device_type ... I guess that's
>   missing now?

No, its being set as "display"

> - pci bus nodes (like bridges) should get the "pci" device_type
>   according to the Open Firmware PCI binding, is this still the case?

Yes

> - Seems like there are some other devices with device_type property
>   where SLOF does not provide an implemented interface, like in
>   slof/fs/usb/dev-mouse.fs ... should these be revised, too?

./slof/fs/usb/dev-mouse.fs:s" mouse" device-type

Regards,
Nikunj
