Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B82E1DDF1C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 15:18:22 +1000 (EST)
Subject: Re: [PATCH 5/7] Add dcr_host_t.base in dcr_read()/dcr_write()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <0caf686b20c5a22172d41e6c77b5b0bb3c429534.1190009070.git.michael@ellerman.id.au>
References: <449a181e8169af98984bb2d61a759c23e55d19b4.1190009070.git.michael@ellerman.id.au>
	<0caf686b20c5a22172d41e6c77b5b0bb3c429534.1190009070.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 15:17:58 +1000
Message-Id: <1191302278.6310.77.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-09-17 at 16:05 +1000, Michael Ellerman wrote:
> Now that all users of dcr_read()/dcr_write() add the dcr_host_t.base, we can
> save them the trouble and do it in dcr_read()/dcr_write().
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Please, fixup the changeset comment to be more exlicit or provide some
Documentation/powerpc/dcr.txt explaning some of the discussions we had
about why this is actually a good idea :-)

Among others:

 - Initially, the goal was to operate like mfdcr/mtdcr who take absolute
DCR numbers. The reason is that on 4xx hardware, indirect DCR access is
a pain (goes through a table of instructions) and it's useful to have
the compiler resolve an absolute DCR inline.

 - We decided that wasn't worth the API bastardisation since most cases
where absolute DCR values are used are low level 4xx-only code which may
as well continue using mfdcr/mtdcr, while the new API is designed for
device "instances" that can exist on 4xx and Axon type platforms and may
be located at variable DCR offsets.

Something around those lines...

Appart from that, patch is fine, I'll ack with the new comment :-)

Ben.

> ---
>  arch/powerpc/platforms/cell/axon_msi.c |    4 ++--
>  arch/powerpc/sysdev/mpic.c             |    4 ++--
>  drivers/net/ibm_emac/ibm_emac_mal.h    |    4 ++--
>  include/asm-powerpc/dcr-mmio.h         |    4 ++--
>  include/asm-powerpc/dcr-native.h       |    4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
> index 23e039a..26a5e88 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -77,12 +77,12 @@ static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
>  {
>  	pr_debug("axon_msi: dcr_write(0x%x, 0x%x)\n", val, dcr_n);
>  
> -	dcr_write(msic->dcr_host, msic->dcr_host.base + dcr_n, val);
> +	dcr_write(msic->dcr_host, dcr_n, val);
>  }
>  
>  static u32 msic_dcr_read(struct axon_msic *msic, unsigned int dcr_n)
>  {
> -	return dcr_read(msic->dcr_host, msic->dcr_host.base + dcr_n);
> +	return dcr_read(msic->dcr_host, dcr_n);
>  }
>  
>  static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 16b1f4b..61f5730 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -156,7 +156,7 @@ static inline u32 _mpic_read(enum mpic_reg_type type,
>  	switch(type) {
>  #ifdef CONFIG_PPC_DCR
>  	case mpic_access_dcr:
> -		return dcr_read(rb->dhost, rb->dhost.base + reg);
> +		return dcr_read(rb->dhost, reg);
>  #endif
>  	case mpic_access_mmio_be:
>  		return in_be32(rb->base + (reg >> 2));
> @@ -173,7 +173,7 @@ static inline void _mpic_write(enum mpic_reg_type type,
>  	switch(type) {
>  #ifdef CONFIG_PPC_DCR
>  	case mpic_access_dcr:
> -		return dcr_write(rb->dhost, rb->dhost.base + reg, value);
> +		return dcr_write(rb->dhost, reg, value);
>  #endif
>  	case mpic_access_mmio_be:
>  		return out_be32(rb->base + (reg >> 2), value);
> diff --git a/drivers/net/ibm_emac/ibm_emac_mal.h b/drivers/net/ibm_emac/ibm_emac_mal.h
> index 6b1fbeb..10dc978 100644
> --- a/drivers/net/ibm_emac/ibm_emac_mal.h
> +++ b/drivers/net/ibm_emac/ibm_emac_mal.h
> @@ -208,12 +208,12 @@ struct ibm_ocp_mal {
>  
>  static inline u32 get_mal_dcrn(struct ibm_ocp_mal *mal, int reg)
>  {
> -	return dcr_read(mal->dcrhost, mal->dcrhost.base + reg);
> +	return dcr_read(mal->dcrhost, reg);
>  }
>  
>  static inline void set_mal_dcrn(struct ibm_ocp_mal *mal, int reg, u32 val)
>  {
> -	dcr_write(mal->dcrhost, mal->dcrhost.base + reg, val);
> +	dcr_write(mal->dcrhost, reg, val);
>  }
>  
>  /* Register MAL devices */
> diff --git a/include/asm-powerpc/dcr-mmio.h b/include/asm-powerpc/dcr-mmio.h
> index 6b82c3b..a7d9eaf 100644
> --- a/include/asm-powerpc/dcr-mmio.h
> +++ b/include/asm-powerpc/dcr-mmio.h
> @@ -37,12 +37,12 @@ extern void dcr_unmap(dcr_host_t host, unsigned int dcr_n, unsigned int dcr_c);
>  
>  static inline u32 dcr_read(dcr_host_t host, unsigned int dcr_n)
>  {
> -	return in_be32(host.token + dcr_n * host.stride);
> +	return in_be32(host.token + ((host.base + dcr_n) * host.stride));
>  }
>  
>  static inline void dcr_write(dcr_host_t host, unsigned int dcr_n, u32 value)
>  {
> -	out_be32(host.token + dcr_n * host.stride, value);
> +	out_be32(host.token + ((host.base + dcr_n) * host.stride), value);
>  }
>  
>  extern u64 of_translate_dcr_address(struct device_node *dev,
> diff --git a/include/asm-powerpc/dcr-native.h b/include/asm-powerpc/dcr-native.h
> index f41058c..3bc780f 100644
> --- a/include/asm-powerpc/dcr-native.h
> +++ b/include/asm-powerpc/dcr-native.h
> @@ -30,8 +30,8 @@ typedef struct {
>  
>  #define dcr_map(dev, dcr_n, dcr_c)	((dcr_host_t){ .base = (dcr_n) })
>  #define dcr_unmap(host, dcr_n, dcr_c)	do {} while (0)
> -#define dcr_read(host, dcr_n)		mfdcr(dcr_n)
> -#define dcr_write(host, dcr_n, value)	mtdcr(dcr_n, value)
> +#define dcr_read(host, dcr_n)		mfdcr(dcr_n + host.base)
> +#define dcr_write(host, dcr_n, value)	mtdcr(dcr_n + host.base, value)
>  
>  /* Device Control Registers */
>  void __mtdcr(int reg, unsigned int val);
> -- 
> 1.5.1.3.g7a33b
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
