Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 42F5B2C0088
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Sep 2012 09:59:49 +1000 (EST)
Message-ID: <1347235183.2385.132.camel@pasglop>
Subject: Re: [PATCH 22/22] ppc/eeh: cleanup on EEH PCI address cache
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 10 Sep 2012 09:59:43 +1000
In-Reply-To: <1347093863-6319-23-git-send-email-shangw@linux.vnet.ibm.com>
References: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1347093863-6319-23-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-09-08 at 16:44 +0800, Gavin Shan wrote:
> The patch does cleanup on EEH PCI address cache based on the fact
> EEH core is the only user of the component.
> 
>         * Cleanup on function names so that they all have prefix
>           "eeh" and looks more short.
>         * Function printk() has been replaced with pr_debug() or
>           pr_warning() accordingly.

You missed a bit:

/home/benh/linux-powerpc-test/arch/powerpc/platforms/pseries/eeh_cache.c: In function 'eeh_addr_cache_build':
/home/benh/linux-powerpc-test/arch/powerpc/platforms/pseries/eeh_cache.c:316:2: error: implicit declaration of function 'pci_addr_cache_print'
cc1: warnings being treated as errors
/home/benh/linux-powerpc-test/arch/powerpc/platforms/pseries/eeh_cache.c: At top level:
/home/benh/linux-powerpc-test/arch/powerpc/platforms/pseries/eeh_cache.c:112:13: error: 'eeh_addr_cache_print' defined but not used

You probably didn't try with DEBUG defined :-)

I'm fixing that locally.

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h             |    4 +-
>  arch/powerpc/include/asm/ppc-pci.h         |    7 ++--
>  arch/powerpc/platforms/pseries/eeh.c       |    6 ++--
>  arch/powerpc/platforms/pseries/eeh_cache.c |   44 ++++++++++++++--------------
>  arch/powerpc/platforms/pseries/pci.c       |    2 +-
>  5 files changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index ebfdb7c..58c5ee6 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -197,7 +197,7 @@ int __exit eeh_ops_unregister(const char *name);
>  unsigned long eeh_check_failure(const volatile void __iomem *token,
>  				unsigned long val);
>  int eeh_dev_check_failure(struct eeh_dev *edev);
> -void __init pci_addr_cache_build(void);
> +void __init eeh_addr_cache_build(void);
>  void eeh_add_device_tree_early(struct device_node *);
>  void eeh_add_device_tree_late(struct pci_bus *);
>  void eeh_remove_bus_device(struct pci_dev *);
> @@ -233,7 +233,7 @@ static inline unsigned long eeh_check_failure(const volatile void __iomem *token
>  
>  #define eeh_dev_check_failure(x) (0)
>  
> -static inline void pci_addr_cache_build(void) { }
> +static inline void eeh_addr_cache_build(void) { }
>  
>  static inline void eeh_add_device_tree_early(struct device_node *dn) { }
>  
> diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
> index 962a902..ed57fa7 100644
> --- a/arch/powerpc/include/asm/ppc-pci.h
> +++ b/arch/powerpc/include/asm/ppc-pci.h
> @@ -47,10 +47,9 @@ extern int rtas_setup_phb(struct pci_controller *phb);
>  
>  #ifdef CONFIG_EEH
>  
> -void pci_addr_cache_build(void);
> -void pci_addr_cache_insert_device(struct pci_dev *dev);
> -void pci_addr_cache_remove_device(struct pci_dev *dev);
> -struct eeh_dev *pci_addr_cache_get_device(unsigned long addr);
> +void eeh_addr_cache_insert_dev(struct pci_dev *dev);
> +void eeh_addr_cache_rmv_dev(struct pci_dev *dev);
> +struct eeh_dev *eeh_addr_cache_get_dev(unsigned long addr);
>  void eeh_slot_error_detail(struct eeh_pe *pe, int severity);
>  int eeh_pci_enable(struct eeh_pe *pe, int function);
>  int eeh_reset_pe(struct eeh_pe *);
> diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
> index 9e618424..18c168b 100644
> --- a/arch/powerpc/platforms/pseries/eeh.c
> +++ b/arch/powerpc/platforms/pseries/eeh.c
> @@ -411,7 +411,7 @@ unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned lon
>  
>  	/* Finding the phys addr + pci device; this is pretty quick. */
>  	addr = eeh_token_to_phys((unsigned long __force) token);
> -	edev = pci_addr_cache_get_device(addr);
> +	edev = eeh_addr_cache_get_dev(addr);
>  	if (!edev) {
>  		eeh_stats.no_device++;
>  		return val;
> @@ -787,7 +787,7 @@ static void eeh_add_device_late(struct pci_dev *dev)
>  	edev->pdev = dev;
>  	dev->dev.archdata.edev = edev;
>  
> -	pci_addr_cache_insert_device(dev);
> +	eeh_addr_cache_insert_dev(dev);
>  	eeh_sysfs_add_device(dev);
>  }
>  
> @@ -844,7 +844,7 @@ static void eeh_remove_device(struct pci_dev *dev)
>  	pci_dev_put(dev);
>  
>  	eeh_rmv_from_parent_pe(edev);
> -	pci_addr_cache_remove_device(dev);
> +	eeh_addr_cache_rmv_dev(dev);
>  	eeh_sysfs_remove_device(dev);
>  }
>  
> diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
> index 6c5ef75..d46d438 100644
> --- a/arch/powerpc/platforms/pseries/eeh_cache.c
> +++ b/arch/powerpc/platforms/pseries/eeh_cache.c
> @@ -60,7 +60,7 @@ static struct pci_io_addr_cache {
>  	spinlock_t piar_lock;
>  } pci_io_addr_cache_root;
>  
> -static inline struct eeh_dev *__pci_addr_cache_get_device(unsigned long addr)
> +static inline struct eeh_dev *__eeh_addr_cache_get_device(unsigned long addr)
>  {
>  	struct rb_node *n = pci_io_addr_cache_root.rb_root.rb_node;
>  
> @@ -84,7 +84,7 @@ static inline struct eeh_dev *__pci_addr_cache_get_device(unsigned long addr)
>  }
>  
>  /**
> - * pci_addr_cache_get_device - Get device, given only address
> + * eeh_addr_cache_get_dev - Get device, given only address
>   * @addr: mmio (PIO) phys address or i/o port number
>   *
>   * Given an mmio phys address, or a port number, find a pci device
> @@ -93,13 +93,13 @@ static inline struct eeh_dev *__pci_addr_cache_get_device(unsigned long addr)
>   * from zero (that is, they do *not* have pci_io_addr added in).
>   * It is safe to call this function within an interrupt.
>   */
> -struct eeh_dev *pci_addr_cache_get_device(unsigned long addr)
> +struct eeh_dev *eeh_addr_cache_get_dev(unsigned long addr)
>  {
>  	struct eeh_dev *edev;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
> -	edev = __pci_addr_cache_get_device(addr);
> +	edev = __eeh_addr_cache_get_device(addr);
>  	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
>  	return edev;
>  }
> @@ -109,7 +109,7 @@ struct eeh_dev *pci_addr_cache_get_device(unsigned long addr)
>   * Handy-dandy debug print routine, does nothing more
>   * than print out the contents of our addr cache.
>   */
> -static void pci_addr_cache_print(struct pci_io_addr_cache *cache)
> +static void eeh_addr_cache_print(struct pci_io_addr_cache *cache)
>  {
>  	struct rb_node *n;
>  	int cnt = 0;
> @@ -118,7 +118,7 @@ static void pci_addr_cache_print(struct pci_io_addr_cache *cache)
>  	while (n) {
>  		struct pci_io_addr_range *piar;
>  		piar = rb_entry(n, struct pci_io_addr_range, rb_node);
> -		printk(KERN_DEBUG "PCI: %s addr range %d [%lx-%lx]: %s\n",
> +		pr_debug("PCI: %s addr range %d [%lx-%lx]: %s\n",
>  		       (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", cnt,
>  		       piar->addr_lo, piar->addr_hi, pci_name(piar->pcidev));
>  		cnt++;
> @@ -129,7 +129,7 @@ static void pci_addr_cache_print(struct pci_io_addr_cache *cache)
>  
>  /* Insert address range into the rb tree. */
>  static struct pci_io_addr_range *
> -pci_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
> +eeh_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
>  		      unsigned long ahi, unsigned int flags)
>  {
>  	struct rb_node **p = &pci_io_addr_cache_root.rb_root.rb_node;
> @@ -147,7 +147,7 @@ pci_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
>  		} else {
>  			if (dev != piar->pcidev ||
>  			    alo != piar->addr_lo || ahi != piar->addr_hi) {
> -				printk(KERN_WARNING "PIAR: overlapping address range\n");
> +				pr_warning("PIAR: overlapping address range\n");
>  			}
>  			return piar;
>  		}
> @@ -164,7 +164,7 @@ pci_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
>  	piar->flags = flags;
>  
>  #ifdef DEBUG
> -	printk(KERN_DEBUG "PIAR: insert range=[%lx:%lx] dev=%s\n",
> +	pr_debug("PIAR: insert range=[%lx:%lx] dev=%s\n",
>  	                  alo, ahi, pci_name(dev));
>  #endif
>  
> @@ -174,7 +174,7 @@ pci_addr_cache_insert(struct pci_dev *dev, unsigned long alo,
>  	return piar;
>  }
>  
> -static void __pci_addr_cache_insert_device(struct pci_dev *dev)
> +static void __eeh_addr_cache_insert_dev(struct pci_dev *dev)
>  {
>  	struct device_node *dn;
>  	struct eeh_dev *edev;
> @@ -182,7 +182,7 @@ static void __pci_addr_cache_insert_device(struct pci_dev *dev)
>  
>  	dn = pci_device_to_OF_node(dev);
>  	if (!dn) {
> -		printk(KERN_WARNING "PCI: no pci dn found for dev=%s\n", pci_name(dev));
> +		pr_warning("PCI: no pci dn found for dev=%s\n", pci_name(dev));
>  		return;
>  	}
>  
> @@ -213,19 +213,19 @@ static void __pci_addr_cache_insert_device(struct pci_dev *dev)
>  			continue;
>  		if (start == 0 || ~start == 0 || end == 0 || ~end == 0)
>  			 continue;
> -		pci_addr_cache_insert(dev, start, end, flags);
> +		eeh_addr_cache_insert(dev, start, end, flags);
>  	}
>  }
>  
>  /**
> - * pci_addr_cache_insert_device - Add a device to the address cache
> + * eeh_addr_cache_insert_dev - Add a device to the address cache
>   * @dev: PCI device whose I/O addresses we are interested in.
>   *
>   * In order to support the fast lookup of devices based on addresses,
>   * we maintain a cache of devices that can be quickly searched.
>   * This routine adds a device to that cache.
>   */
> -void pci_addr_cache_insert_device(struct pci_dev *dev)
> +void eeh_addr_cache_insert_dev(struct pci_dev *dev)
>  {
>  	unsigned long flags;
>  
> @@ -234,11 +234,11 @@ void pci_addr_cache_insert_device(struct pci_dev *dev)
>  		return;
>  
>  	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
> -	__pci_addr_cache_insert_device(dev);
> +	__eeh_addr_cache_insert_dev(dev);
>  	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
>  }
>  
> -static inline void __pci_addr_cache_remove_device(struct pci_dev *dev)
> +static inline void __eeh_addr_cache_rmv_dev(struct pci_dev *dev)
>  {
>  	struct rb_node *n;
>  
> @@ -259,7 +259,7 @@ restart:
>  }
>  
>  /**
> - * pci_addr_cache_remove_device - remove pci device from addr cache
> + * eeh_addr_cache_rmv_dev - remove pci device from addr cache
>   * @dev: device to remove
>   *
>   * Remove a device from the addr-cache tree.
> @@ -267,17 +267,17 @@ restart:
>   * the tree multiple times (once per resource).
>   * But so what; device removal doesn't need to be that fast.
>   */
> -void pci_addr_cache_remove_device(struct pci_dev *dev)
> +void eeh_addr_cache_rmv_dev(struct pci_dev *dev)
>  {
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&pci_io_addr_cache_root.piar_lock, flags);
> -	__pci_addr_cache_remove_device(dev);
> +	__eeh_addr_cache_rmv_dev(dev);
>  	spin_unlock_irqrestore(&pci_io_addr_cache_root.piar_lock, flags);
>  }
>  
>  /**
> - * pci_addr_cache_build - Build a cache of I/O addresses
> + * eeh_addr_cache_build - Build a cache of I/O addresses
>   *
>   * Build a cache of pci i/o addresses.  This cache will be used to
>   * find the pci device that corresponds to a given address.
> @@ -285,7 +285,7 @@ void pci_addr_cache_remove_device(struct pci_dev *dev)
>   * Must be run late in boot process, after the pci controllers
>   * have been scanned for devices (after all device resources are known).
>   */
> -void __init pci_addr_cache_build(void)
> +void __init eeh_addr_cache_build(void)
>  {
>  	struct device_node *dn;
>  	struct eeh_dev *edev;
> @@ -294,7 +294,7 @@ void __init pci_addr_cache_build(void)
>  	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
>  
>  	for_each_pci_dev(dev) {
> -		pci_addr_cache_insert_device(dev);
> +		eeh_addr_cache_insert_dev(dev);
>  
>  		dn = pci_device_to_OF_node(dev);
>  		if (!dn)
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 2c6ded2..56b864d 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -73,7 +73,7 @@ void __init pSeries_final_fixup(void)
>  {
>  	pSeries_request_regions();
>  
> -	pci_addr_cache_build();
> +	eeh_addr_cache_build();
>  }
>  
>  /*
