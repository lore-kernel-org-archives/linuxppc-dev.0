Return-Path: <a.korud@vector.com.pl>
Received: from lion.vector.com.pl (lion.vector.com.pl [81.210.9.36])
	by ozlabs.org (Postfix) with ESMTP id A1BCE2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Dec 2004 23:12:38 +1100 (EST)
From: Andriy Korud <a.korud@vector.com.pl>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20041207105250.C13540@home.com>
References: <20041207105250.C13540@home.com>
Content-Type: text/plain
Date: Mon, 13 Dec 2004 14:08:22 +0100
Message-Id: <1102943302.28201.14.camel@localhost>
Mime-Version: 1.0
Cc: jgarzik@pobox.com, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][EMAC] allow rx of the maximum sized VLAN tagged packets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, 
as I know from documentation and IBM's support when you program VTPID
register, EMAC will receive only frames with programmed ID. Other frames
will be received only if they do not exceed 1518 bytes.
Can anybody please comment this?

Thanks in advance,

--

Andriy Korud


On Tue, 2004-12-07 at 10:52 -0700, Matt Porter wrote:
> Patch enables EMAC to receive maximum sized VLAN tagged packets. 
> 
> Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
> Signed-off-by: Matt Porter <mporter@kernel.crashing.org>
> 
> ===== drivers/net/ibm_emac/ibm_emac.h 1.1 vs edited =====
> --- 1.1/drivers/net/ibm_emac/ibm_emac.h	2004-05-22 10:13:08 -07:00
> +++ edited/drivers/net/ibm_emac/ibm_emac.h	2004-08-24 12:19:41 -07:00
> @@ -98,7 +98,7 @@
>  #endif				/* CONFIG_IBM_EMAC4 */
>  #define EMAC_M1_BASE			(EMAC_M1_TX_FIFO_2K | \
>  					EMAC_M1_APP | \
> -					EMAC_M1_TR)
> +					EMAC_M1_TR | EMAC_M1_VLE)
>  
>  /* Transmit Mode Register 0 */
>  #define EMAC_TMR0_GNP0			0x80000000
> ===== drivers/net/ibm_emac/ibm_emac_core.c 1.2 vs edited =====
> --- 1.2/drivers/net/ibm_emac/ibm_emac_core.c	2004-06-04 08:50:36 -07:00
> +++ edited/drivers/net/ibm_emac/ibm_emac_core.c	2004-08-24 12:18:27 -07:00
> @@ -1335,6 +1335,9 @@
>  
>  	/* set frame gap */
>  	out_be32(&emacp->em0ipgvr, CONFIG_IBM_EMAC_FGAP);
> +	
> +	/* set VLAN Tag Protocol Identifier */
> +	out_be32(&emacp->em0vtpid, 0x8100);
>  
>  	/* Init ring buffers */
>  	emac_init_rings(fep->ndev);
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
