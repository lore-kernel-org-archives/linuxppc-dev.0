Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 31A85B6F94
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 07:40:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Date: Wed, 1 Jun 2011 23:40:14 +0200
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
In-Reply-To: <1306953337-15698-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201106012340.14237.arnd@arndb.de>
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 01 June 2011, Timur Tabi wrote:
> The Freescale hypervisor management driver provides several services to
> drivers and applications related to the Freescale hypervisor:
> 
> 1. An ioctl interface for querying and managing partitions
> 
> 2. A file interface to reading incoming doorbells
> 
> 3. An interrupt handler for shutting down the partition upon receiving the
>    shutdown doorbell from a manager partition
> 
> 4. An interface for receiving callbacks when a managed partition shuts down.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  drivers/misc/Kconfig           |    7 +
>  drivers/misc/Makefile          |    1 +
>  drivers/misc/fsl_hypervisor.c  |  941 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/Kbuild           |    1 +
>  include/linux/fsl_hypervisor.h |  203 +++++++++
>  5 files changed, 1153 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/misc/fsl_hypervisor.c
>  create mode 100644 include/linux/fsl_hypervisor.h

I think drivers/misc is not the right place for this, but I'm not completely
sure what is. drivers/firmware would be better at least, but virt/fsl might
also be ok.

> +static long ioctl_dtprop(struct fsl_hv_ioctl_prop __user *p, int set)
> +{
> +	struct fsl_hv_ioctl_prop param;
> +	char __user *upath, *upropname;
> +	void __user *upropval;
> +	char *path = NULL, *propname = NULL;
> +	void *propval = NULL;
> +	int ret = 0;
> +

I'm not convinced that an ioctl interface is the right way to work with
device tree properties. A more natural way would be to export it as
a file system, or maybe as a flattened device tree blob (the latter option
would require changing the hypervisor interface, which might not be
possible).

> +/**
> + * fsl_hv_ioctl: ioctl main entry point
> + */
> +static long fsl_hv_ioctl(struct file *file, unsigned int cmd,
> +			 unsigned long argaddr)
> +{
> +	union fsl_hv_ioctl_param __user *arg =
> +		(union fsl_hv_ioctl_param __user *)argaddr;
> +	long ret;
> +

For an ioctl, please follow the normal pattern of defining a separate
structure for each case, no union.

You can use a void __user * in the common ioctl function, and pass that
to the typed argument list in the specific functions.

	Arnd
