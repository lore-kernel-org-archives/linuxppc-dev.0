Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 702E667D77
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 04:36:12 +1000 (EST)
In-Reply-To: <42EF9022.5050707@ru.mvista.com>
References: <42EF9022.5050707@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <955B5DDD-C111-440B-90EF-50FCF2C6D79A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 2 Aug 2005 13:35:46 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: Re: [PATCH] cpm_uart: Made non-console uart work
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I want to test this out on the 8560 ADS to see if works there as well  
before pushing upstream.

- kumar

On Aug 2, 2005, at 10:24 AM, Vitaly Bordug wrote:

> Kumar, Pantelis,
>
> This patch makes non-console UART work on both 8xx and 82xx. Various
> issues are resolved:
> - removed unnecessary STOP_TX commands in shutdown - no need to
> completely stop CPM TX and reinit BDs each time the port is closing;
> - when mem_addr has been allocated via dma_coherent_alloc, virt_to_bus
> on it will not tell the truth in most cases
> - SCC UART needs to wait several character times even after all the  
> BDs
> have READY bit cleared
> - adds needed board-specific bits for 86xADS
>
> Tested on 8272ADS, 885ADS and 866ADS development boards.
> ---------------------------------
> Signed-off-by:  Vitaly Bordug <vbordug@ru.mvista.com>
>
> -- 
> Sincerely,
> Vitaly
>
>
> <cpm_uart_fixes.patch>
>
