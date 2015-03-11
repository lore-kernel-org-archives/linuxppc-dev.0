Return-Path: <thuth@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FBD41A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 18:50:42 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <thuth@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 07:50:36 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2C61D219005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 07:50:24 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2B7oXKx46596226
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 07:50:33 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2B7oWxI005393
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 01:50:32 -0600
Date: Wed, 11 Mar 2015 08:50:30 +0100
From: Thomas Huth <thuth@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH SLOF] pci-properties: Remove redundant call to device-type
Message-ID: <20150311085030.43ac4fac@oc7435384737.ibm.com>
In-Reply-To: <1426055192-28691-1-git-send-email-aik@ozlabs.ru>
References: <1426055192-28691-1-git-send-email-aik@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 11 Mar 2015 17:26:32 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> At the moment SLOF adds a "device_type" property automatically for
> every single PCI device based on its class even if there is no SLOF
> driver for such a device. OF1275 says that "device_type" is for
> implemented interfaces only. A side effect of this is virtio-balloon
> getting device_type=="memory" while it should not have.
> 
> This removes automatic call to device-type from the common PCI code.
> Since now, we rely on existing SLOF PCI drivers to call device-type if
> needed. virtio-blk/net, e1000, ohci/ehci/xhci do this. virtio-scsi
> does not create the property for itself but disks on its bus do.
> virtio-ballon won't get the device_type property as there is no driver
> for it.

Sounds very reasonable, but I think there are a couple of other things
you could/should check:

- Graphic cards should get the "display" device_type ... I guess that's
  missing now?

- pci bus nodes (like bridges) should get the "pci" device_type
  according to the Open Firmware PCI binding, is this still the case?

- Seems like there are some other devices with device_type property
  where SLOF does not provide an implemented interface, like in
  slof/fs/usb/dev-mouse.fs ... should these be revised, too?

 Thomas
