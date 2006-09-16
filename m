Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D1A5867B97
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 18:35:58 +1000 (EST)
Date: Sat, 16 Sep 2006 18:36:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 3/7] POWERPC: Move generic cpm2 stuff to powerpc
Message-Id: <20060916183607.94d6facc.sfr@canb.auug.org.au>
In-Reply-To: <20060915173912.7984.40164.stgit@localhost.localdomain>
References: <20060915213751.128e85f3@localhost.localdomain>
	<20060915173912.7984.40164.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

Seems I am in nit picking mood tonight ..

On Fri, 15 Sep 2006 21:39:12 +0400 Vitaly Bordug <vbordug@ru.mvista.com> wrote:
>
> +# Temporary hack until we have migrated to asm-powerpc
> +ifeq ($(ARCH),powerpc)

I think we normally use:
ifeq ($(CONFIG_PPC_MERGE),y)

> +	if (brg < 4) {
> +		bp = (uint *)&cpm2_immr->im_brgc1;
> +	}
> +	else {

Normally:
	if (brg < 4)
		bp = (uint *)&cpm2_immr->im_brgc1;
	else {

> +static	u_char	irq_to_siureg[] = {

const ?

> +static	u_char	irq_to_siubit[] = {

ditto

> +int cpm2_get_irq(struct pt_regs *regs)
> +{
> +	int irq;
> +        unsigned long bits;
> +
> +        /* For CPM2, read the SIVEC register and shift the bits down
> +         * to get the irq number.         */
> +        bits = cpm2_immr->im_intctl.ic_sivec;
> +        irq = bits >> 26;
> +
> +	if (irq == 0)
> +		return(-1);
> +	return irq+CPM_IRQ_OFFSET;
> +}

Indentation needs fixing - we use single tab characters to indent.

> +static int cpm2_pic_host_xlate(struct irq_host *h, struct device_node *ct,
> +			    u32 *intspec, unsigned int intsize,
> +			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
> +{
> +	static unsigned char map_cpm2_senses[4] = {

const ?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
