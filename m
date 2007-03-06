Return-Path: <James.Bottomley@SteelEye.com>
Received: from hancock.sc.steeleye.com (hancock.steeleye.com [71.30.118.248])
	by ozlabs.org (Postfix) with ESMTP id 5A78BDDEEF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 05:09:01 +1100 (EST)
Subject: Re: [parisc-linux] [PATCH 2/2] Make pcibios_add_platform_entries()
	return errors
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20070306150725.68D97DDF36@ozlabs.org>
References: <20070306150725.68D97DDF36@ozlabs.org>
Content-Type: text/plain
Date: Tue, 06 Mar 2007 12:05:01 -0600
Message-Id: <1173204301.3379.33.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Cc: discuss@x86-64.org, dev-etrax@axis.com, linux-ia64@vger.kernel.org,
	chris@zankel.net, Greg Kroah-Hartman <greg@kroah.com>,
	linux-m68k@vger.kernel.org, uclinux-v850@lsi.nec.co.jp,
	linuxppc-dev@ozlabs.org, linux-mips@linux-mips.org,
	gerg@uclinux.org, sparclinux@vger.kernel.org,
	ink@jurassic.park.msu.ru, linux-pci@atrey.karlin.mff.cuni.cz,
	rth@twiddle.net, kernel@wantstofly.org, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-03-06 at 16:06 +0100, Michael Ellerman wrote:
>  int __must_check pci_create_sysfs_dev_files (struct pci_dev *pdev)
> @@ -644,10 +644,13 @@ int __must_check pci_create_sysfs_dev_fi
>  		}
>  	}
>  	/* add platform-specific attributes */
> -	pcibios_add_platform_entries(pdev);
> +	if (pcibios_add_platform_entries(pdev))
> +		goto err_rom_attr;
>  
>  	return 0;
>  
> +err_rom_attr:
> +	sysfs_remove_bin_file(&pdev->dev.kobj, rom_attr);

This file is only created if the rom resource has a non-zero length.  If
you unconditionally call sysfs_remove_bin_file() it's going to spit
scary warnings and dump traces in this error leg if the rom resource
doesn't exist.

James


>  err_rom:
>  	kfree(rom_attr);
>  err_bin_file:
> Index: msi-new/include/linux/pci.h
> ===================================================================
> --- msi-new.orig/include/linux/pci.h
> +++ msi-new/include/linux/pci.h
> @@ -857,7 +857,7 @@ extern int pci_pci_problems;
>  extern unsigned long pci_cardbus_io_size;
>  extern unsigned long pci_cardbus_mem_size;
>  
> -extern void pcibios_add_platform_entries(struct pci_dev *dev);
> +extern int pcibios_add_platform_entries(struct pci_dev *dev);
>  
>  #endif /* __KERNEL__ */
>  #endif /* LINUX_PCI_H */
> _______________________________________________
> parisc-linux mailing list
> parisc-linux@lists.parisc-linux.org
> http://lists.parisc-linux.org/mailman/listinfo/parisc-linux
