Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F44D67A63
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jun 2006 23:35:42 +1000 (EST)
In-Reply-To: <20060624211708.0d6039b2@localhost.localdomain>
References: <20060623231648.6721.3495.stgit@localhost.localdomain>
	<20060623231710.6721.8447.stgit@localhost.localdomain>
	<7062D82B-EEC2-49BE-8685-DCBCC02A2BCD@kernel.crashing.org>
	<20060624211708.0d6039b2@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <916A10D3-1F96-43D0-945D-ACE406E840E6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 6/6] [RFC] POWERPC: Add mpc8560 board support
Date: Mon, 26 Jun 2006 08:35:37 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]

>>> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/
>>> Makefile
>>> index cef95b0..75dfe12 100644
>>> --- a/arch/powerpc/sysdev/Makefile
>>> +++ b/arch/powerpc/sysdev/Makefile
>>> @@ -12,3 +12,10 @@ obj-$(CONFIG_U3_DART)		+=
>>> dart_iommu.o obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
>>>  obj-$(CONFIG_PPC_83xx)		+= ipic.o
>>>  obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
>>> +
>>> +# Temporary hack until we have migrated to asm-powerpc
>>> +ifeq ($(ARCH),powerpc)
>>> +obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
>>> +endif
>>
>> See earlier comments about just building in arch/powerpc
>>
> Hrm, here I am not completely sure it's a good thing. The point is  
> that
> currently some OF-specific stuff is under construction to go into
> cpm2_common at least (for instance, getting rid of CPM_MAP_ADDR
> ioremap because the offset is available via oftree, and things like
> that).

If that's the case, make a duplicate of cpm2_common.c, however I dont  
think you need the ifeq... to make that work.

>>> +
>>> +#obj-$(CONFIG_CPM2)		+= cpm2/

what's in the cpm2 directory?

[snip]

>>> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/
>>> fsl_soc.c
>>> index ceb5846..bab202d 100644
>>> --- a/arch/powerpc/sysdev/fsl_soc.c
>>> +++ b/arch/powerpc/sysdev/fsl_soc.c
>>> @@ -21,6 +21,8 @@ #include <linux/module.h>
>>>  #include <linux/device.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/fsl_devices.h>
>>> +#include <linux/fs_enet_pd.h>
>>> +#include <linux/fs_uart_pd.h>
>>>
>>>  #include <asm/system.h>
>>>  #include <asm/atomic.h>
>>> @@ -30,6 +32,10 @@ #include <asm/prom.h>
>>>  #include <sysdev/fsl_soc.h>
>>>  #include <mm/mmu_decl.h>
>>>
>>> +#ifdef CONFIG_CPM2
>>> +#include <asm/cpm2.h>
>>> +#endif
>>> +
>>>  static phys_addr_t immrbase = -1;
>>>
>>>  phys_addr_t get_immrbase(void)
>>> @@ -43,7 +49,9 @@ phys_addr_t get_immrbase(void)
>>>  	if (soc) {
>>>  		unsigned int size;
>>>  		void *prop = get_property(soc, "reg", &size);
>>> -		immrbase = of_translate_address(soc, prop);
>>> +
>>> +		if (prop)
>>> +			immrbase = of_translate_address(soc, prop);
>>>  		of_node_put(soc);
>>>  	};
>>>
>>> @@ -51,7 +59,79 @@ phys_addr_t get_immrbase(void)
>>>  }
>>>
>>>  EXPORT_SYMBOL(get_immrbase);
>>> +
>>> +static u32 brgfreq = -1;
>>> +
>>> +u32 get_brgfreq(void)
>>> +{
>>> +	struct device_node *node;
>>> +
>>> +	if (brgfreq != -1)
>>> +		return brgfreq;
>>> +
>>> +	node = of_find_node_by_type(NULL, "serial");
>>> +	if (node) {
>>> +		unsigned int size;
>>> +		unsigned int *prop = (unsigned
>>> int*)get_property(node, "clock- frequency", &size);
>>> +
>>> +		if (prop)
>>> +			brgfreq = *prop;
>>> +		of_node_put(node);
>>> +	};
>>> +
>>> +	return brgfreq;
>>> +}
>>
>> These seems broken on a system w/both CPM & 8250 style uarts.
>>
> Yeah, missed that.
>
>>> +
>>> +EXPORT_SYMBOL(get_brgfreq);
>>> +
>>> +static u32 fs_baudrate = -1;
>>> +
>>> +u32 get_baudrate(void)
>>> +{
>>> +	struct device_node *node;
>>>
>>> +	if (fs_baudrate != -1)
>>> +		return fs_baudrate;
>>> +
>>> +	node = of_find_node_by_type(NULL, "serial");
>>> +	if (node) {
>>> +		unsigned int size;
>>> +		unsigned int *prop = (unsigned
>>> int*)get_property(node, "current- speed", &size);
>>> +
>>> +		if (prop)
>>> +			fs_baudrate = *prop;
>>> +		of_node_put(node);
>>> +	};
>>> +
>>> +	return fs_baudrate;
>>> +}
>>> +
>>> +EXPORT_SYMBOL(get_baudrate);
>>> +
>>> +static u32 intfreq = -1;
>>> +
>>> +u32 get_intfreq(void)
>>> +{
>>> +	struct device_node *node;
>>> +
>>> +	if (intfreq != -1)
>>> +		return intfreq;
>>> +
>>> +	node = of_find_node_by_type(NULL, "cpu");
>>> +	if (node) {
>>> +		unsigned int size;
>>> +		unsigned int *prop = (unsigned
>>> int*)get_property(node, "clock- frequency", &size);
>>> +		if (prop)
>>> +			intfreq = *prop;
>>> +		of_node_put(node);
>>> +	}
>>> +
>>> +	return intfreq;
>>> +}
>>> +
>>> +EXPORT_SYMBOL(get_intfreq);
>>> +
>>
>> Don't we have something that reports "clock-frequency" elsewhere?
>>
>
> If yes, I haven't found... Mind pointing where to look at?

ppc_proc_freq in kernel/time.c

>>> +
>>>  static int __init gfar_mdio_of_init(void)
>>>  {
>>>  	struct device_node *np;
>>> @@ -491,3 +571,211 @@ err:
>>>  }
>>>
>>>  arch_initcall(fsl_usb_dr_of_init);
>>> +
>>> +static const char *fcc_regs = "fcc_regs";
>>> +static const char *fcc_regs_c = "fcc_regs_c";
>>> +static const char *fcc_pram = "fcc_pram";
>>> +static char bus_id[9][BUS_ID_SIZE];
>>> +
>>> +static int __init fs_enet_of_init(void)
>>> +{
>>> +	struct device_node *np;
>>> +	unsigned int i;
>>> +	struct platform_device *fs_enet_dev;
>>> +	struct resource res;
>>> +	int ret;
>>> +
>>> +	for (np = NULL, i = 0;
>>> +	     (np = of_find_compatible_node(np, "network",
>>> "fs_enet")) != NULL;
>>> +	     i++) {
>>> +		struct resource r[4];
>>> +		struct device_node *phy, *mdio;
>>> +		struct fs_platform_info fs_enet_data;
>>> +		unsigned int *id, *phy_addr;
>>> +		void *mac_addr;
>>> +		phandle *ph;
>>> +		char *model;
>>> +
>>> +		memset(r, 0, sizeof(r));
>>> +		memset(&fs_enet_data, 0, sizeof(fs_enet_data));
>>> +
>>> +		ret = of_address_to_resource(np, 0, &r[0]);
>>> +		if (ret)
>>> +			goto err;
>>> +		r[0].name = fcc_regs;
>>> +
>>> +		ret = of_address_to_resource(np, 1, &r[1]);
>>> +		if (ret)
>>> +			goto err;
>>> +		r[1].name = fcc_pram;
>>> +
>>> +		ret = of_address_to_resource(np, 2, &r[2]);
>>> +		if (ret)
>>> +			goto err;
>>> +		r[2].name = fcc_regs_c;
>>> +
>>> +		r[3].start = np->intrs[0].line;
>>> +		r[3].end = np->intrs[0].line;
>>> +		r[3].flags = IORESOURCE_IRQ;
>>> +
>>> +		fs_enet_dev =
>>> +		    platform_device_register_simple("fsl-cpm-fcc",
>>> i, &r[0], 4); +
>>> +		if (IS_ERR(fs_enet_dev)) {
>>> +			ret = PTR_ERR(fs_enet_dev);
>>> +			goto err;
>>> +		}
>>> +
>>> +		model = get_property(np, "model", NULL);
>>> +		if (model == NULL) {
>>> +			ret = -ENODEV;
>>> +			goto unreg;
>>> +		}
>>> +
>>> +		mac_addr = get_property(np, "mac-address", NULL);
>>> +		memcpy(fs_enet_data.macaddr, mac_addr, 6);
>>> +
>>> +		ph = (phandle *) get_property(np, "phy-handle",
>>> NULL);
>>> +		phy = of_find_node_by_phandle(*ph);
>>> +
>>> +		if (phy == NULL) {
>>> +			ret = -ENODEV;
>>> +			goto unreg;
>>> +		}
>>> +
>>> +		phy_addr = (u32 *) get_property(phy, "reg", NULL);
>>> +		fs_enet_data.phy_addr = *phy_addr;
>>> +
>>> +		id = (u32 *) get_property(np, "device-id", NULL);
>>> +		fs_enet_data.fs_no = *id;
>>> +
>>> +		mdio = of_get_parent(phy);
>>> +                ret = of_address_to_resource(mdio, 0, &res);
>>> +                if (ret) {
>>> +                        of_node_put(phy);
>>> +                        of_node_put(mdio);
>>> +                        goto unreg;
>>> +                }
>>> +
>>> +		switch (*id) {
>>> +		case fsid_fcc1:
>>> +			fs_enet_data.mem_offset = FCC1_MEM_OFFSET,
>>> +			snprintf((char*)&bus_id[2], BUS_ID_SIZE,
>>> "%x:%02x", (u32) res.start, fs_enet_data.phy_addr);
>>> +			fs_enet_data.bus_id = (char*)&bus_id[2];
>>> +			fs_enet_data.cp_page = CPM_CR_FCC1_PAGE;
>>> +			fs_enet_data.cp_block = CPM_CR_FCC1_SBLOCK;
>>> +			break;
>>> +		case fsid_fcc2:
>>> +			fs_enet_data.mem_offset = FCC2_MEM_OFFSET,
>>> +			snprintf((char*)&bus_id[3], BUS_ID_SIZE,
>>> "%x:%02x", (u32) res.start, fs_enet_data.phy_addr);
>>> +			fs_enet_data.bus_id = (char*)&bus_id[3];
>>> +			fs_enet_data.cp_page = CPM_CR_FCC2_PAGE;
>>> +			fs_enet_data.cp_block = CPM_CR_FCC2_SBLOCK;
>>> +			break;
>>> +		case fsid_fcc3:
>>> +			fs_enet_data.mem_offset = FCC3_MEM_OFFSET,
>>> +			snprintf((char*)&bus_id[4], BUS_ID_SIZE,
>>> "%x:%02x", (u32) res.start, fs_enet_data.phy_addr);
>>> +			fs_enet_data.bus_id = (char*)&bus_id[4];
>>> +			fs_enet_data.cp_page = CPM_CR_FCC3_PAGE;
>>> +			fs_enet_data.cp_block = CPM_CR_FCC3_SBLOCK;
>>> +			break;
>>> +		}
>>
>> this looks like a lot of effort to just encode a single integer (1,
>> 2, 3) and then lookup the other information based on it.
>>
>
> Not sure I am following what is suggested here. Could it be elaborated
> a little bit ?

I saying all you need to store is the fact that its a FCC and its  
number 1, 2, 3... after which we can have some table in cpm2_common.c  
that provides back cp_page, cp_block based on type and number.   
Encoding it fs_enet_data is just a duplication.

>>> +
>>> +		if (strstr(model, "FCC")) {
>>> +			fs_enet_data.dpram_offset =
>>> (u32)cpm2_immr->im_dprambase;
>>> +			fs_enet_data.rx_ring = 32;
>>> +			fs_enet_data.tx_ring = 32;
>>> +			fs_enet_data.rx_copybreak = 240;
>>> +			fs_enet_data.use_napi = 0;
>>> +			fs_enet_data.napi_weight = 17;
>>> +		}
>>> +
>>> +		of_node_put(phy);
>>> +		of_node_put(mdio);
>>> +
>>> +		ret = platform_device_add_data(fs_enet_dev,
>>> &fs_enet_data,
>>> +					     sizeof(struct
>>> +
>>> fs_platform_info));
>>> +		if (ret)
>>> +			goto unreg;
>>> +	}
>>> +	return 0;
>>> +
>>> +unreg:
>>> +	platform_device_unregister(fs_enet_dev);
>>> +err:
>>> +	return ret;
>>> +}
>>> +
>>> +arch_initcall(fs_enet_of_init);
>>> +
>>> +static const char *scc_regs = "regs";
>>> +static const char *scc_pram = "pram";
>>> +
>>> +static int __init cpm_uart_of_init(void)
>>> +{
>>> +	struct device_node *np;
>>> +	unsigned int i;
>>> +	struct platform_device *cpm_uart_dev;
>>> +	int ret;
>>> +
>>> +
>>> +	for (np = NULL, i = 0;
>>> +	     (np = of_find_compatible_node(np, "serial",
>>> "cpm_uart")) != NULL;
>>> +	     i++) {
>>> +		struct resource r[3];
>>> +		struct fs_uart_platform_info cpm_uart_data;
>>> +		int *id;
>>> +
>>> +		memset(r, 0, sizeof(r));
>>> +		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));
>>> +
>>> +		ret = of_address_to_resource(np, 0, &r[0]);
>>> +		if (ret)
>>> +			goto err;
>>> +
>>> +		r[0].name = scc_regs;
>>> +
>>> +		ret = of_address_to_resource(np, 1, &r[1]);
>>> +		if (ret)
>>> +			goto err;
>>> +		r[1].name = scc_pram;
>>> +
>>> +		r[2].start = np->intrs[0].line;
>>> +		r[2].end = np->intrs[0].line;
>>> +		r[2].flags = IORESOURCE_IRQ;
>>> +
>>> +		cpm_uart_dev =
>>> +
>>> platform_device_register_simple("fsl-cpm-scc:uart", i, &r [0], 3);
>>> +
>>> +		if (IS_ERR(cpm_uart_dev)) {
>>> +			ret = PTR_ERR(cpm_uart_dev);
>>> +			goto err;
>>> +		}
>>> +
>>> +		id = get_property(np, "device-id", NULL);
>>> +		cpm_uart_data.fs_no = *id;
>>> +		cpm_uart_data.uart_clk = get_intfreq();
>>> +
>>> +		cpm_uart_data.tx_num_fifo = 4;
>>> +		cpm_uart_data.tx_buf_size = 32;
>>> +		cpm_uart_data.rx_num_fifo = 4;
>>> +		cpm_uart_data.rx_buf_size = 32;
>>> +
>>> +		ret =
>>> +		    platform_device_add_data(cpm_uart_dev,
>>> &cpm_uart_data,
>>> +					     sizeof(struct
>>> +
>>> fs_uart_platform_info));
>>> +		if (ret)
>>> +			goto unreg;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +unreg:
>>> +	platform_device_unregister(cpm_uart_dev);
>>> +err:
>>> +	return ret;
>>> +}
>>> +
>>> +arch_initcall(cpm_uart_of_init);
>>> diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
>>> index f6a7ff0..8e6840b 100644
>>> --- a/include/asm-ppc/cpm2.h
>>> +++ b/include/asm-ppc/cpm2.h
>>> @@ -1186,7 +1186,7 @@ #define PC3_DIRC1	(PC3_TXDAT)
>>>  #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
>>>  #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
>>>  #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
>>> -#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
>>> +#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
>>>
>>>  #endif /* __CPM2__ */
>>>  #endif /* __KERNEL__ */
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
>>
