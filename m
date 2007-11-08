Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F96BDDE02
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 01:12:19 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA8ECGjD032115
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 09:12:16 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA8ECGSB480628
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 09:12:16 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA8ECGxN009129
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 09:12:16 -0500
Date: Thu, 8 Nov 2007 08:08:01 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH] another ioremap/iounmap issue in sycamore_setup_arch();
	arch/ppc/platforms/4xx/sycamore.c
Message-ID: <20071108080801.155396d1@zod.rchland.ibm.com>
In-Reply-To: <473238C2.9050402@tiscali.nl>
References: <473238C2.9050402@tiscali.nl>
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

On Wed, 07 Nov 2007 23:14:26 +0100
Roel Kluin <12o3l@tiscali.nl> wrote:

> not yet tested
> --
> iounmap kb_data on error
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/arch/ppc/platforms/4xx/sycamore.c b/arch/ppc/platforms/4xx/sycamore.c
> index 8689f3e..c4ac63d 100644
> --- a/arch/ppc/platforms/4xx/sycamore.c
> +++ b/arch/ppc/platforms/4xx/sycamore.c
> @@ -99,22 +99,23 @@ sycamore_setup_arch(void)
>  	kb_data = ioremap(SYCAMORE_PS2_BASE, 8);
>  	if (!kb_data) {
>  		printk(KERN_CRIT
>  		       "sycamore_setup_arch() kb_data ioremap failed\n");
>  		return;
>  	}
> 
>  	kb_cs = kb_data + 1;
> 
>  	fpga_status = ioremap(PPC40x_FPGA_BASE, 8);
>  	if (!fpga_status) {
> +		iounmap(kb_data);
>  		printk(KERN_CRIT
>  		       "sycamore_setup_arch() fpga_status ioremap failed\n");
>  		return;
>  	}

Same comment as the walnut patch.  You can probably fold these two
patches into one.

josh
