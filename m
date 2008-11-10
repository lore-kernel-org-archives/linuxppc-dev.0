Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DAA73DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Nov 2008 04:59:25 +1100 (EST)
In-Reply-To: <491846A9.8080709@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Using DMA
MIME-Version: 1.0
Message-ID: <OF23CBF910.0133035A-ON882574FD.0061E950-882574FD.0062B6DE@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Mon, 10 Nov 2008 09:58:36 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: timur.tabi@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Timur Tabi <timur@freescale.com> wrote on 11/10/2008 06:35:21 AM:

> Bruce_Leonard@selinc.com wrote:
> 
> > Is there something else I need to do?  Or is there something wrong 
with my 
> > device tree (always a possibility :)  ).  Any help is appreciated.
> 
> You might need to add something like this:
> 
> static struct of_device_id __initdata mpc8610_ids[] = {
>          { .compatible = "fsl,mpc8610-immr", },
>          { .compatible = "simple-bus", },
>          {}
> };
> static int __init mpc8610_declare_of_platform_devices(void)
> {
>          /* Without this call, the SSI device driver won't get probed. 
*/
>          of_platform_bus_probe(NULL, mpc8610_ids, NULL);
>          return 0;
> }
> machine_device_initcall(mpc86xx_hpcd, 
mpc8610_declare_of_platform_devices);
> 
> -- 
> Timur Tabi
> Linux Kernel Developer @ Freescale

Something like that already exists in 
/arch/powerpc/platforms/83xx/mpc834x_itx.c, which I'm using.  Only real 
difference is the first compatible flag is:

.compatible = "fsl,pq2pro-localbus"

Which I presume is correct since other drivers load and work correctly 
based on what's in the device tree.

Bruce
