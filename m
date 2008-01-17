Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80A5BDDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 06:35:45 +1100 (EST)
Date: Thu, 17 Jan 2008 11:35:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: 2.6.24-rc8-mm1 powerpc build errors
Message-Id: <20080117113523.d802f991.akpm@linux-foundation.org>
In-Reply-To: <20080117190639.GA9499@lixom.net>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<20080117190639.GA9499@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jan 2008 13:06:39 -0600 Olof Johansson <olof@lixom.net> wrote:

> Hi,
> 
> My powerpc build-all-defconfigs script found the following:

thanks.

> mpc837x_mds_defconfig. Brokage looks like it came from libata's
> for_each_sg() patch.
> 
> drivers/ata/sata_fsl.c: In function 'sata_fsl_fill_sg':
> drivers/ata/sata_fsl.c:337: error: redeclaration of 'si' with no linkage
> drivers/ata/sata_fsl.c:326: error: previous declaration of 'si' was here

--- a/drivers/ata/sata_fsl.c~git-libata-all-fix-drivers-ata-sata_fslc
+++ a/drivers/ata/sata_fsl.c
@@ -323,7 +323,6 @@ static unsigned int sata_fsl_fill_sg(str
 	struct scatterlist *sg;
 	unsigned int num_prde = 0;
 	u32 ttl_dwords = 0;
-	unsigned int si;
 
 	/*
 	 * NOTE : direct & indirect prdt's are contigiously allocated
_

> powerpc_allyesconfig:
> 
> drivers/net/ehea/ehea_main.c: In function 'ehea_driver_sysfs_add':
> drivers/net/ehea/ehea_main.c:2812: error: 'struct device_driver' has no member named 'kobj'
> drivers/net/ehea/ehea_main.c:2815: error: 'struct device_driver' has no member named 'kobj'
> drivers/net/ehea/ehea_main.c:2818: error: 'struct device_driver' has no member named 'kobj'
> drivers/net/ehea/ehea_main.c: In function 'ehea_driver_sysfs_remove':
> drivers/net/ehea/ehea_main.c:2830: error: 'struct device_driver' has no member named 'kobj'

Looks like the driver tree wrecking ball failed to visit that driver.
