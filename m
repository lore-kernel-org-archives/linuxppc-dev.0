Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2BED9DDE05
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 01:11:24 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA8EBLhj015070
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 09:11:21 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA8EBLaO123786
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 07:11:21 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA8EBKDe029575
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 07:11:20 -0700
Date: Thu, 8 Nov 2007 08:06:37 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH] very similar, now in walnut_setup_arch();
	arch/ppc/platforms/4xx/walnut.c
Message-ID: <20071108080637.6a510e8c@zod.rchland.ibm.com>
In-Reply-To: <4732397A.8020607@tiscali.nl>
References: <4732397A.8020607@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 07 Nov 2007 23:17:30 +0100
Roel Kluin <12o3l@tiscali.nl> wrote:

> iounmap kb_data on error
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/arch/ppc/platforms/4xx/walnut.c b/arch/ppc/platforms/4xx/walnut.c
> index 2f97723..04d3f3f 100644
> --- a/arch/ppc/platforms/4xx/walnut.c
> +++ b/arch/ppc/platforms/4xx/walnut.c
> @@ -81,22 +81,23 @@ walnut_setup_arch(void)
>  	kb_data = ioremap(WALNUT_PS2_BASE, 8);
>  	if (!kb_data) {
>  		printk(KERN_CRIT
>  		       "walnut_setup_arch() kb_data ioremap failed\n");
>  		return;
>  	}
> 
>  	kb_cs = kb_data + 1;
> 
>  	fpga_status = ioremap(PPC40x_FPGA_BASE, 8);
>  	if (!fpga_status) {
> +		iounmap(kb_data);
>  		printk(KERN_CRIT
>  		       "walnut_setup_arch() fpga_status ioremap failed\n");
>  		return;
>  	}

kb_data and fpga_status aren't iounmapped anywhere at all in this
function.  Care to fix that up in addition to the error case?

> 
>  	fpga_enable = fpga_status + 1;
>  	fpga_polarity = fpga_status + 2;
>  	fpga_trigger = fpga_status + 3;
>  	fpga_brdc = fpga_status + 4;
> 
>  	/* split the keyboard and mouse interrupts */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
