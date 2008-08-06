Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC1A3DEAE3
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 03:27:59 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m76HRqHv016498
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 10:27:53 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m76HRqIp019574
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 12:27:52 -0500 (CDT)
Date: Wed, 6 Aug 2008 12:27:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 6/6] powerpc: add 82xx platform level support to SEC engine
Message-ID: <20080806172752.GB3138@ld0162-tx32.am.freescale.net>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
	<1218006285-27138-5-git-send-email-leoli@freescale.com>
	<1218006285-27138-6-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1218006285-27138-6-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 06, 2008 at 03:04:45PM +0800, Li Yang wrote:
> diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
> index 1b75902..bacb136 100644
> --- a/arch/powerpc/platforms/82xx/pq2.c
> +++ b/arch/powerpc/platforms/82xx/pq2.c
> @@ -22,6 +22,8 @@
>  #include <platforms/82xx/pq2.h>
>  
>  #define RMR_CSRE 0x00000001
> +#define PQ2_SECMR_128K 0xfffe0000
> +#define PQ2_ALRH_SEC 0x30126745
>  
>  void pq2_restart(char *cmd)
>  {
> @@ -35,6 +37,23 @@ void pq2_restart(char *cmd)
>  	panic("Restart failed\n");
>  }
>  
> +void __init pq2_init_sec(void)
> +{
> +	struct device_node *np = NULL;
> +	struct resource res;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,talitos");

This is an obsolete binding. 
See "Documentation/powerpc/dts-bindings/fsl/sec.txt".

> +	if (!np)
> +		return;
> +
> +	of_address_to_resource(np, 0, &res);
> +	printk(KERN_INFO "Setting SECBR and SECMR\n");

This is an unnecessary printk().

> +	out_be32(&cpm2_immr->im_memctl.secbr, (u32)res.start);
> +	out_be32(&cpm2_immr->im_memctl.secmr, PQ2_SECMR_128K);
> +	out_be32(&cpm2_immr->im_siu_conf.siu_82xx.sc_ppc_alrh, PQ2_ALRH_SEC);

Please put some comments here explaining what you're doing, such as 
/* Map the SEC registers */, and /* Lower the SEC arbitration priority */.

-Scott
