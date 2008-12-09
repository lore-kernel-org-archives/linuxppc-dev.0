Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44544DDED6
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 10:30:37 +1100 (EST)
Subject: Re: [PATCH] powerpc: Remove `have_of' global variable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081209194729.GA22132@oksana.dev.rtsoft.ru>
References: <20081209194729.GA22132@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Wed, 10 Dec 2008 10:30:26 +1100
Message-Id: <1228865426.22413.31.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-09 at 22:47 +0300, Anton Vorontsov wrote:
> The `have_of' variable is a relic from the arch/ppc time, it isn't
> useful nowadays.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/include/asm/processor.h |    2 --
>  arch/powerpc/kernel/pci-common.c     |    2 --
>  arch/powerpc/kernel/pci_32.c         |    7 +------
>  arch/powerpc/kernel/setup_32.c       |    2 --
>  arch/powerpc/kernel/setup_64.c       |    1 -
>  fs/proc/proc_devtree.c               |    3 +--
>  6 files changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index cd7a478..d346649 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -69,8 +69,6 @@ extern int _prep_type;
>  
>  #ifdef __KERNEL__
>  
> -extern int have_of;
> -
>  struct task_struct;
>  void start_thread(struct pt_regs *regs, unsigned long fdptr, unsigned long sp);
>  void release_thread(struct task_struct *);
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 91c3f52..1a32db3 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -160,8 +160,6 @@ EXPORT_SYMBOL(pci_domain_nr);
>   */
>  struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
>  {
> -	if (!have_of)
> -		return NULL;
>  	while(node) {
>  		struct pci_controller *hose, *tmp;
>  		list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> index 7ad11e5..132cd80 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -266,9 +266,6 @@ pci_busdev_to_OF_node(struct pci_bus *bus, int devfn)
>  {
>  	struct device_node *parent, *np;
>  
> -	if (!have_of)
> -		return NULL;
> -
>  	pr_debug("pci_busdev_to_OF_node(%d,0x%x)\n", bus->number, devfn);
>  	parent = scan_OF_for_pci_bus(bus);
>  	if (parent == NULL)
> @@ -309,8 +306,6 @@ pci_device_from_OF_node(struct device_node* node, u8* bus, u8* devfn)
>  	struct pci_controller* hose;
>  	struct pci_dev* dev = NULL;
>  	
> -	if (!have_of)
> -		return -ENODEV;
>  	/* Make sure it's really a PCI device */
>  	hose = pci_find_hose_for_OF_device(node);
>  	if (!hose || !hose->dn)
> @@ -431,7 +426,7 @@ static int __init pcibios_init(void)
>  	 * numbers vs. kernel bus numbers since we may have to
>  	 * remap them.
>  	 */
> -	if (pci_assign_all_buses && have_of)
> +	if (pci_assign_all_buses)
>  		pcibios_make_OF_bus_map();
>  
>  	/* Call common code to handle resource allocation */
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index c1a2762..cc4679e 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -53,8 +53,6 @@ unsigned long ISA_DMA_THRESHOLD;
>  unsigned int DMA_MODE_READ;
>  unsigned int DMA_MODE_WRITE;
>  
> -int have_of = 1;
> -
>  #ifdef CONFIG_VGA_CONSOLE
>  unsigned long vgacon_remap_base;
>  EXPORT_SYMBOL(vgacon_remap_base);
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 93c875a..ce48f5c 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -70,7 +70,6 @@
>  #define DBG(fmt...)
>  #endif
>  
> -int have_of = 1;
>  int boot_cpuid = 0;
>  u64 ppc64_pft_size;
>  
> diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
> index d777789..de2bba5 100644
> --- a/fs/proc/proc_devtree.c
> +++ b/fs/proc/proc_devtree.c
> @@ -218,8 +218,7 @@ void proc_device_tree_add_node(struct device_node *np,
>  void __init proc_device_tree_init(void)
>  {
>  	struct device_node *root;
> -	if ( !have_of )
> -		return;
> +
>  	proc_device_tree = proc_mkdir("device-tree", NULL);
>  	if (proc_device_tree == 0)
>  		return;
