Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BDE1DDE0A0
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 11:46:57 +1100 (EST)
Subject: Re: [PATCH 1/2] rename pSeries nvram functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20070125001628.GH16486@localdomain>
References: <20070125001628.GH16486@localdomain>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 11:46:51 +1100
Message-Id: <1169686011.24996.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-24 at 18:16 -0600, Nathan Lynch wrote:
> The nvram support in the pSeries platform code is not really tied to
> the pSeries platform.  This code is useful on other platforms that
> have the necessary firmware support.
> 
> Change the "pSeries" prefixes on the nvram function names to "rtas" in
> preparation for moving this code to a platform-neutral location.
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>

Please, move them out of platform/pseries while at it, so you can also
merge with chrp nvram.c which is pretty much the same.

Cheers,
Ben.

> ---
>  arch/powerpc/platforms/pseries/nvram.c |   14 +++++++-------
>  arch/powerpc/platforms/pseries/setup.c |    2 +-
>  include/asm-powerpc/nvram.h            |    2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
> index 64163ce..45cce8c 100644
> --- a/arch/powerpc/platforms/pseries/nvram.c
> +++ b/arch/powerpc/platforms/pseries/nvram.c
> @@ -29,7 +29,7 @@ static char nvram_buf[NVRW_CNT];	/* assume this is in the first 4GB */
>  static DEFINE_SPINLOCK(nvram_lock);
>  
> 
> -static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
> +static ssize_t rtas_nvram_read(char *buf, size_t count, loff_t *index)
>  {
>  	unsigned int i;
>  	unsigned long len;
> @@ -73,7 +73,7 @@ static ssize_t pSeries_nvram_read(char *buf, size_t count, loff_t *index)
>  	return p - buf;
>  }
>  
> -static ssize_t pSeries_nvram_write(char *buf, size_t count, loff_t *index)
> +static ssize_t rtas_nvram_write(char *buf, size_t count, loff_t *index)
>  {
>  	unsigned int i;
>  	unsigned long len;
> @@ -115,12 +115,12 @@ static ssize_t pSeries_nvram_write(char *buf, size_t count, loff_t *index)
>  	return p - buf;
>  }
>  
> -static ssize_t pSeries_nvram_get_size(void)
> +static ssize_t rtas_nvram_get_size(void)
>  {
>  	return nvram_size ? nvram_size : -ENODEV;
>  }
>  
> -int __init pSeries_nvram_init(void)
> +int __init rtas_nvram_init(void)
>  {
>  	struct device_node *nvram;
>  	const unsigned int *nbytes_p;
> @@ -141,9 +141,9 @@ int __init pSeries_nvram_init(void)
>  	printk(KERN_INFO "PPC64 nvram contains %d bytes\n", nvram_size);
>  	of_node_put(nvram);
>  
> -	ppc_md.nvram_read	= pSeries_nvram_read;
> -	ppc_md.nvram_write	= pSeries_nvram_write;
> -	ppc_md.nvram_size	= pSeries_nvram_get_size;
> +	ppc_md.nvram_read	= rtas_nvram_read;
> +	ppc_md.nvram_write	= rtas_nvram_write;
> +	ppc_md.nvram_size	= rtas_nvram_get_size;
>  
>  	return 0;
>  }
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 042ecae..488828f 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -315,7 +315,7 @@ static void __init pSeries_setup_arch(void)
>  	find_and_init_phbs();
>  	eeh_init();
>  
> -	pSeries_nvram_init();
> +	rtas_nvram_init();
>  
>  	/* Choose an idle loop */
>  	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
> diff --git a/include/asm-powerpc/nvram.h b/include/asm-powerpc/nvram.h
> index f3563e1..981fb9e 100644
> --- a/include/asm-powerpc/nvram.h
> +++ b/include/asm-powerpc/nvram.h
> @@ -68,7 +68,7 @@ extern int nvram_read_error_log(char * buff, int length, unsigned int * err_type
>  extern int nvram_clear_error_log(void);
>  extern struct nvram_partition *nvram_find_partition(int sig, const char *name);
>  
> -extern int pSeries_nvram_init(void);
> +extern int rtas_nvram_init(void);
>  extern int mmio_nvram_init(void);
>  #endif /* __KERNEL__ */
>  
