Return-Path: <thuth@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 786341A074A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:14:48 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <thuth@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 13:14:44 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D8A851B0806B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 13:15:02 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2BDEgAJ10092974
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 13:14:42 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2BDEeUe024106
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 07:14:41 -0600
Date: Wed, 11 Mar 2015 14:14:38 +0100
From: Thomas Huth <thuth@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH slof v2] pci-properties: Remove redundant call to
 device-type
Message-ID: <20150311141438.3c8b30f5@oc7435384737.ibm.com>
In-Reply-To: <1426078922-22972-1-git-send-email-aik@ozlabs.ru>
References: <1426078922-22972-1-git-send-email-aik@ozlabs.ru>
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

On Thu, 12 Mar 2015 00:02:02 +1100
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
> 
> While we are here, remove device-type from usb-mouse as well.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * removed usb mouse as well - slof does not implement it
> ---
>  slof/fs/pci-properties.fs | 2 +-
>  slof/fs/usb/dev-mouse.fs  | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/slof/fs/pci-properties.fs b/slof/fs/pci-properties.fs
> index a19c651..9efa87e 100644
> --- a/slof/fs/pci-properties.fs
> +++ b/slof/fs/pci-properties.fs
> @@ -565,7 +565,7 @@
>  \ ***************************************************************************************
>  \ set up common properties for devices and bridges
>  : pci-common-props ( addr -- )
> -        dup pci-class-name 2dup device-name device-type
> +        dup pci-class-name device-name
>          dup pci-vendor@    encode-int s" vendor-id"      property
>          dup pci-device@    encode-int s" device-id"      property
>          dup pci-revision@  encode-int s" revision-id"    property
> diff --git a/slof/fs/usb/dev-mouse.fs b/slof/fs/usb/dev-mouse.fs
> index 278a7c0..f6acd7e 100644
> --- a/slof/fs/usb/dev-mouse.fs
> +++ b/slof/fs/usb/dev-mouse.fs
> @@ -6,7 +6,6 @@ sudev slof-dev>port l@ dup set-unit encode-phys " reg" property
>  sudev slof-dev>udev @ VALUE udev
> 
>  s" usb-mouse" device-name
> -s" mouse" device-type
> 
>  \ .S cr
>  \     dup slof-dev>udev dup . @ . cr

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
