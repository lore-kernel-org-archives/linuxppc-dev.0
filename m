Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 5C197B6FEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 17:29:51 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 7/7] [v4] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Thu, 9 Jun 2011 09:29:23 +0200
References: <1307573154-15838-1-git-send-email-timur@freescale.com>
In-Reply-To: <1307573154-15838-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106090929.23671.arnd@arndb.de>
Cc: konrad.wilk@oracle.com, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	akpm@kernel.org, dsaxena@linaro.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	Timur Tabi <timur@freescale.com>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 09 June 2011 00:45:54 Timur Tabi wrote:
> +struct fsl_hv_ioctl_memcpy {
> +       __u32 ret;
> +       __u32 source;
> +       __u32 target;
> +       __u64 local_vaddr;
> +       __u64 remote_paddr;
> +       __u64 count;
> +};

> +struct fsl_hv_ioctl_prop {
> +       __u32 ret;
> +       __u32 handle;
> +       __u64 path;
> +       __u64 propname;
> +       __u64 propval;
> +       __u32 proplen;
> +};

These structures have implied padding. Better make it explicit by
adding the appropriate __u32 __pad1 members or similar.

> +/*
> + * ioctl commands.
> + */
> +enum {
> +       FSL_HV_IOCTL_PARTITION_RESTART = 1, /* Boot another partition */
> +       FSL_HV_IOCTL_PARTITION_GET_STATUS = 2, /* Boot another partition */
> +       FSL_HV_IOCTL_PARTITION_START = 3, /* Boot another partition */
> +       FSL_HV_IOCTL_PARTITION_STOP = 4, /* Stop this or another partition */
> +       FSL_HV_IOCTL_MEMCPY = 5, /* Copy data from one partition to another */
> +       FSL_HV_IOCTL_DOORBELL = 6, /* Ring a doorbell */
> +
> +       /* Get a property from another guest's device tree */
> +       FSL_HV_IOCTL_GETPROP = 7,
> +
> +       /* Set a property in another guest's device tree */
> +       FSL_HV_IOCTL_SETPROP = 8,
> +};

As discussed before, this one should really be using the _IOC macros to define
the commands that you use based on the structure definitions above, e.g.

#define FSL_HV_IOCTL_GETPROP _IORW(FSL_HV, 8, struct fsl_hv_ioctl_prop)

Then get rid of all the code that takes apart the ioctl command numbers
again and just do a switch/case based on the command.

	Arnd

	Arnd
