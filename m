Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B82FDDDEC4
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 08:09:42 +1100 (EST)
Message-ID: <478D211E.6050209@freescale.com>
Date: Tue, 15 Jan 2008 15:09:50 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: mjw@linux.vnet.ibm.com
Subject: Re: [PATCH] change where the kernel loads
References: <478D2038.4090205@linux.vnet.ibm.com>
In-Reply-To: <478D2038.4090205@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Wolf wrote:
> When netbooting a kernel with an initrd or initramfs that makes
> the image larger than 8 meg the firmware will kick out the kernel 
> and go to the second boot device.  However when the mkzimage 
> script is used to create the image instead of 'make zImage' then 
> the kernel/initrd will netboot.  So this patch changes boot/zImage.lds
> to load the kernel at the same location that the mkzimage would set.
> 
> This has been boot tested on POWER5, POWER5+, blades and POWER6
> systems successfully.

This will fail on any platform without a vmlinux_alloc(), as there will 
be insufficient room for the kernel at address zero.

-Scott
