Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id A90522C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 06:30:47 +1100 (EST)
Message-ID: <1363375740.16793.12.camel@ul30vt.home>
Subject: Re: [PATCH 2/3] VFIO: VFIO_DEVICE_SET_ADDR_MAPPING command
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Fri, 15 Mar 2013 13:29:00 -0600
In-Reply-To: <1363332390-12754-3-git-send-email-shangw@linux.vnet.ibm.com>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1363332390-12754-3-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-03-15 at 15:26 +0800, Gavin Shan wrote:
> The address (domain/bus/slot/function) of the passed PCI device
> looks quite different from perspective of host and guest. Some
> architectures like PPC need to setup the mapping in host. The patch
> introduces additional VFIO device IOCTL command to address that.

Could you explain further how this will be used?  How the device is
exposed to a guest is entirely a userspace construct, so why does vfio
need to know or care about this?  I had assumed for AER that QEMU would
do the translation from host to guest address space.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  include/uapi/linux/vfio.h |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 6e58d9b..ecc4f38 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -289,6 +289,22 @@ struct vfio_irq_set {
>   */
>  #define VFIO_DEVICE_RESET		_IO(VFIO_TYPE, VFIO_BASE + 11)
>  
> +/**
> + * VFIO_DEVICE_SET_ADDR_MAPPING - _IO(VFIO_TYPE, VFIO_BASE + 12)
> + *
> + * The address, which comprised of domain/bus/slot/function looks
> + * different between host and guest. We need to setup the mapping
> + * in host for some architectures like PPC so that the passed PCI
> + * devices could support RTAS smoothly.
> + */
> +struct vfio_addr_mapping {
> +	__u64 buid;

What's a buid?  Thanks,

Alex

> +	__u8  bus;
> +	__u8  slot;
> +	__u8  func;
> +};
> +#define VFIO_DEVICE_SET_ADDR_MAPPING	_IO(VFIO_TYPE, VFIO_BASE + 12)
> +
>  /*
>   * The VFIO-PCI bus driver makes use of the following fixed region and
>   * IRQ index mapping.  Unimplemented regions return a size of zero.
