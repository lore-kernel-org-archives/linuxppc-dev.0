Return-Path: <lkp@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LS1n0FgKzF0X5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 03:01:12 +1000 (AEST)
Date: Thu, 5 Jul 2018 01:00:30 +0800
From: kbuild test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, robh+dt@kernel.org,
 dan.j.williams@intel.com, nicolas.pitre@linaro.org,
 josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de,
 andy.shevchenko@gmail.com, brijesh.singh@amd.com,
 devicetree@vger.kernel.org, airlied@linux.ie,
 linux-pci@vger.kernel.org, richard.weiyang@gmail.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com,
 baiyaowei@cmss.chinamobile.com, frowand.list@gmail.com,
 lorenzo.pieralisi@arm.com, sthemmin@microsoft.com,
 Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org,
 patrik.r.jakobsson@gmail.com, linux-input@vger.kernel.org,
 gustavo@padovan.org, dyoung@redhat.com, vgoyal@redhat.com,
 thomas.lendacky@amd.com, haiyangz@microsoft.com,
 maarten.lankhorst@linux.intel.com, jglisse@redhat.com,
 seanpaul@chromium.org, bhelgaas@google.com, tglx@linutronix.de,
 yinghai@kernel.org, jonathan.derrick@intel.com, chris@zankel.net,
 monstr@monstr.eu, linux-parisc@vger.kernel.org,
 gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com,
 kexec@lists.infradead.org, ebiederm@xmission.com,
 devel@linuxdriverproject.org, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Subject: Re: [PATCH v6 2/4] resource: Use list_head to link sibling resource
Message-ID: <201807042312.io0Igseh%fengguang.wu@intel.com>
References: <20180704041038.8190-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
In-Reply-To: <20180704041038.8190-3-bhe@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baoquan,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.18-rc3 next-20180704]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180704-121402
config: ia64-allnoconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   arch/ia64/sn/kernel/io_init.c: In function 'sn_io_slot_fixup':
>> arch/ia64/sn/kernel/io_init.c:195:19: error: invalid operands to binary && (have 'int' and 'struct list_head')
      if (res->parent && res->parent->child)
          ~~~~~~~~~~~ ^~ ~~~~~~~~~~~~~~~~~~

vim +195 arch/ia64/sn/kernel/io_init.c

^1da177e Linus Torvalds  2005-04-16  142  
3ec829b6 John Keller     2005-11-29  143  /*
6f09a925 John Keller     2007-01-30  144   * sn_io_slot_fixup() -   We are not running with an ACPI capable PROM,
8ea6091f John Keller     2006-10-04  145   *			  and need to convert the pci_dev->resource
8ea6091f John Keller     2006-10-04  146   *			  'start' and 'end' addresses to mapped addresses,
8ea6091f John Keller     2006-10-04  147   *			  and setup the pci_controller->window array entries.
^1da177e Linus Torvalds  2005-04-16  148   */
8ea6091f John Keller     2006-10-04  149  void
6f09a925 John Keller     2007-01-30  150  sn_io_slot_fixup(struct pci_dev *dev)
^1da177e Linus Torvalds  2005-04-16  151  {
^1da177e Linus Torvalds  2005-04-16  152  	int idx;
ab97b8cc Bjorn Helgaas   2016-03-02  153  	struct resource *res;
18c25526 Matt Fleming    2016-05-04  154  	unsigned long size;
6f09a925 John Keller     2007-01-30  155  	struct pcidev_info *pcidev_info;
6f09a925 John Keller     2007-01-30  156  	struct sn_irq_info *sn_irq_info;
6f09a925 John Keller     2007-01-30  157  	int status;
6f09a925 John Keller     2007-01-30  158  
6f09a925 John Keller     2007-01-30  159  	pcidev_info = kzalloc(sizeof(struct pcidev_info), GFP_KERNEL);
6f09a925 John Keller     2007-01-30  160  	if (!pcidev_info)
d4ed8084 Harvey Harrison 2008-03-04  161  		panic("%s: Unable to alloc memory for pcidev_info", __func__);
6f09a925 John Keller     2007-01-30  162  
6f09a925 John Keller     2007-01-30  163  	sn_irq_info = kzalloc(sizeof(struct sn_irq_info), GFP_KERNEL);
6f09a925 John Keller     2007-01-30  164  	if (!sn_irq_info)
d4ed8084 Harvey Harrison 2008-03-04  165  		panic("%s: Unable to alloc memory for sn_irq_info", __func__);
6f09a925 John Keller     2007-01-30  166  
6f09a925 John Keller     2007-01-30  167  	/* Call to retrieve pci device information needed by kernel. */
6f09a925 John Keller     2007-01-30  168  	status = sal_get_pcidev_info((u64) pci_domain_nr(dev),
6f09a925 John Keller     2007-01-30  169  		(u64) dev->bus->number,
6f09a925 John Keller     2007-01-30  170  		dev->devfn,
6f09a925 John Keller     2007-01-30  171  		(u64) __pa(pcidev_info),
6f09a925 John Keller     2007-01-30  172  		(u64) __pa(sn_irq_info));
6f09a925 John Keller     2007-01-30  173  
80a03e29 Stoyan Gaydarov 2009-03-10  174  	BUG_ON(status); /* Cannot get platform pci device information */
6f09a925 John Keller     2007-01-30  175  
3ec829b6 John Keller     2005-11-29  176  
^1da177e Linus Torvalds  2005-04-16  177  	/* Copy over PIO Mapped Addresses */
^1da177e Linus Torvalds  2005-04-16  178  	for (idx = 0; idx <= PCI_ROM_RESOURCE; idx++) {
ab97b8cc Bjorn Helgaas   2016-03-02  179  		if (!pcidev_info->pdi_pio_mapped_addr[idx])
^1da177e Linus Torvalds  2005-04-16  180  			continue;
^1da177e Linus Torvalds  2005-04-16  181  
ab97b8cc Bjorn Helgaas   2016-03-02  182  		res = &dev->resource[idx];
ab97b8cc Bjorn Helgaas   2016-03-02  183  
ab97b8cc Bjorn Helgaas   2016-03-02  184  		size = res->end - res->start;
ab97b8cc Bjorn Helgaas   2016-03-02  185  		if (size == 0)
3ec829b6 John Keller     2005-11-29  186  			continue;
ab97b8cc Bjorn Helgaas   2016-03-02  187  
240504ad Bjorn Helgaas   2016-03-02  188  		res->start = pcidev_info->pdi_pio_mapped_addr[idx];
18c25526 Matt Fleming    2016-05-04  189  		res->end = res->start + size;
64715725 Bernhard Walle  2007-03-18  190  
64715725 Bernhard Walle  2007-03-18  191  		/*
64715725 Bernhard Walle  2007-03-18  192  		 * if it's already in the device structure, remove it before
64715725 Bernhard Walle  2007-03-18  193  		 * inserting
64715725 Bernhard Walle  2007-03-18  194  		 */
ab97b8cc Bjorn Helgaas   2016-03-02 @195  		if (res->parent && res->parent->child)
ab97b8cc Bjorn Helgaas   2016-03-02  196  			release_resource(res);
64715725 Bernhard Walle  2007-03-18  197  
ab97b8cc Bjorn Helgaas   2016-03-02  198  		if (res->flags & IORESOURCE_IO)
ab97b8cc Bjorn Helgaas   2016-03-02  199  			insert_resource(&ioport_resource, res);
^1da177e Linus Torvalds  2005-04-16  200  		else
ab97b8cc Bjorn Helgaas   2016-03-02  201  			insert_resource(&iomem_resource, res);
d7ad2254 John Keller     2007-07-09  202  		/*
240504ad Bjorn Helgaas   2016-03-02  203  		 * If ROM, mark as shadowed in PROM.
d7ad2254 John Keller     2007-07-09  204  		 */
d7ad2254 John Keller     2007-07-09  205  		if (idx == PCI_ROM_RESOURCE) {
240504ad Bjorn Helgaas   2016-03-02  206  			pci_disable_rom(dev);
240504ad Bjorn Helgaas   2016-03-02  207  			res->flags = IORESOURCE_MEM | IORESOURCE_ROM_SHADOW |
240504ad Bjorn Helgaas   2016-03-02  208  				     IORESOURCE_PCI_FIXED;
d7ad2254 John Keller     2007-07-09  209  		}
^1da177e Linus Torvalds  2005-04-16  210  	}
6f09a925 John Keller     2007-01-30  211  
6f09a925 John Keller     2007-01-30  212  	sn_pci_fixup_slot(dev, pcidev_info, sn_irq_info);
^1da177e Linus Torvalds  2005-04-16  213  }
6f09a925 John Keller     2007-01-30  214  EXPORT_SYMBOL(sn_io_slot_fixup);
6f09a925 John Keller     2007-01-30  215  

:::::: The code at line 195 was first introduced by commit
:::::: ab97b8cc560eabfd8139dd97924a09e46a3c9632 ia64/PCI: Use temporary struct resource * to avoid repetition

:::::: TO: Bjorn Helgaas <bhelgaas@google.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--5vNYLRcllDrimb99
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
JRomG88BHTMp+v8H1UQQM5VNAAA=

--5vNYLRcllDrimb99--
