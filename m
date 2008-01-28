Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 83FAEDDED6
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 04:19:48 +1100 (EST)
Message-ID: <479E0EC4.5070707@freescale.com>
Date: Mon, 28 Jan 2008 11:20:04 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
Subject: Re: request_irq() for external interrupt pin on MPC875 (A&M adder
	MPC 	875)
References: <39417DF3286A66428FA558987839F44F03FC914F@SINTEFXCH01.sintef.no>
In-Reply-To: <39417DF3286A66428FA558987839F44F03FC914F@SINTEFXCH01.sintef.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rognlien Dag Kristian wrote:
> With kernel 2.6.13 we used
>  
> request_irq (use_irq, irq_handler, SA_INTERRUPT|SA_SHIRQ, DEVICE_NAME, dev)
>  
> where use_irq is 12 to use the external IRQ6 pin.
>  
> We are now trying to get this driver to work with the 2.6.25 pull from 
> powerpc.git.
>  
> request_irq (use_irq, irq_handler, IRQF_SHARED, DEVICE_NAME, dev);
>  
> returns -ENOSYS on the newer kernel.
>  
> Have the IRQ mappings for the external IRQX pins been moved in the later 
> kernels?

Yes, you need to use the result of irq_create_mapping() or 
irq_of_parse_and_map().

-Scott
