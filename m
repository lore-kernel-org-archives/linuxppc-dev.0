Return-Path: <agx@sigxcpu.org>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA15E67A5D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 21:30:48 +1100 (EST)
Date: Thu, 20 Jan 2005 10:55:46 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Joerg Dorchain <joerg@dorchain.net>
Message-ID: <20050120095546.GD5810@bogon.ms20.nix>
References: <20050119101448.GA1374@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050119101448.GA1374@Redstar.dorchain.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: nvram driver not possible as a module
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Joerg,
On Wed, Jan 19, 2005 at 11:14:48AM +0100, Joerg Dorchain wrote:
> KConfig says CONFIG_NVRAM is possible as a module. Loading the module
> fails because of an unknown symbol __alloc_bootmem. __alloc_bootmem is
> marked __init. The obvious workaround is to compile the driver not as a
> module, but how can this get really fixed?
Does this help:

--- linux-2.6.9.orig/arch/ppc/platforms/pmac_nvram.c	2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6.9/arch/ppc/platforms/pmac_nvram.c	2004-10-25 09:53:15.000000000 +0200
@@ -488,7 +488,7 @@
 			printk(KERN_ERR "nvram: no address\n");
 			return;
 		}
-		nvram_image = alloc_bootmem(NVRAM_SIZE);
+		nvram_image = kmalloc(NVRAM_SIZE, GFP_KERNEL);
 		if (nvram_image == NULL) {
 			printk(KERN_ERR "nvram: can't allocate ram image\n");
 			return;

Cheers,
 -- Guido
