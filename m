Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-101-monday.nerim.net [62.4.16.101])
	by ozlabs.org (Postfix) with ESMTP id E869CDDE34
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 00:31:43 +1100 (EST)
Date: Mon, 18 Feb 2008 14:31:39 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [Patch 2/2] powerpc: i2c-isa: add access check to legacy ioports
Message-ID: <20080218143139.1ad6b82f@hyperion.delvare>
In-Reply-To: <20080213183701.254391cc@de.ibm.com>
References: <20080213182800.5c6940a8@de.ibm.com>
	<20080213183701.254391cc@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: parabelboi@bopserverein.de, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Christian,

On Wed, 13 Feb 2008 18:37:01 +0100, Christian Krafft wrote:
> when probing i2c-pca-isa writes to legacy ioports, which crashes the kernel
> if there is no device at that port.
> This patch adds a check_legacy_ioport call, so probe failes gracefully
> and thus prevents the oops.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> 
> Index: linux.git/drivers/i2c/busses/i2c-pca-isa.c
> ===================================================================
> --- linux.git.orig/drivers/i2c/busses/i2c-pca-isa.c
> +++ linux.git/drivers/i2c/busses/i2c-pca-isa.c
> @@ -125,6 +125,13 @@ static int __devinit pca_isa_probe(struc
>  
>  	dev_info(dev, "i/o base %#08lx. irq %d\n", base, irq);
>  
> +#ifdef CONFIG_PPC_MERGE
> +	if (check_legacy_ioport(base)) {
> +		dev_err(dev, "I/O address %#08lx is not available\n", base);
> +		goto out;
> +	}
> +#endif
> +
>  	if (!request_region(base, IO_SIZE, "i2c-pca-isa")) {
>  		dev_err(dev, "I/O address %#08lx is in use\n", base);
>  		goto out;
> 

I can apply this, no problem. That being said, you might alternatively
just exclude this driver from PPC. It's for a rare device with no known
user, the driver is unmaintained and will hopefully be replaced soon by
a platform driver which will not probe random ports at load time.

-- 
Jean Delvare
