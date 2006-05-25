Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BFE2567A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 May 2006 18:23:29 +1000 (EST)
Received: from localhost.localdomain ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k4Q8NOs15689
	for <linuxppc-embedded@ozlabs.org>; Fri, 26 May 2006 13:23:25 +0500
Date: Fri, 26 May 2006 01:39:33 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 5/5] Updates for WRS SBC82xx boards
Message-ID: <20060526013933.58b00e1f@localhost.localdomain>
In-Reply-To: <20060525183231.GG679@windriver.com>
References: <20060525183231.GG679@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 25 May 2006 14:32:32 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> 
> patch5: fcc_enet-mac-addr.diff1
> 	- restore proper collection of mac addr data in obsolete FCC
> 	  driver by replacing mix of #ifdef and if() with case

8260_io stuff is obsoleted by fs_enet. You should fit the board into
ppc_sys infrastructure, fill the platform data and do per-board
initialization in board-specific file - refer to
platforms/mpc8272_setup.c for example... 

> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> 
> 
> --- linux-2.6.16_rc5/arch/ppc/8260_io/fcc_enet.c.orig
> 2006-01-02 22:21:10.000000000 -0500 +++
> linux-2.6.16_rc5/arch/ppc/8260_io/fcc_enet.c	2006-02-27
> 18:01:45.000000000 -0500 @@ -1962,32 +1962,30 @@
>  	 * non-static part of the address.
>  	 */
>  	eap = (unsigned char *)&(ep->fen_paddrh);
> -	for (i=5; i>=0; i--) {
>  
>  /*
>   * The EP8260 only uses FCC3, so we can safely give it the real
>   * MAC address.
>   */
> +	for (i=5; i>=0; i--) switch(i) {
> +		case 5:
>  #ifdef CONFIG_SBC82xx
> -		if (i == 5) {
>  			/* bd->bi_enetaddr holds the SCC0 address;
> the FCC devices count up from there */
>  			dev->dev_addr[i] = bd->bi_enetaddr[i] & ~3;
>  			dev->dev_addr[i] += 1 + fip->fc_fccnum;
>  			*eap++ = dev->dev_addr[i];
> -		}
> -#else
> -#ifndef CONFIG_RPX8260
> -		if (i == 3) {
> +			break;
> +#endif
> +		case 3:
> +#if !defined(CONFIG_RPX8260) && !defined(CONFIG_SBC82xx)
>  			dev->dev_addr[i] = bd->bi_enetaddr[i];
>  			dev->dev_addr[i] |= (1 << (7 -
> fip->fc_fccnum)); *eap++ = dev->dev_addr[i];
> -		} else
> +			break;
>  #endif
> -		{
> +		default:
>  			*eap++ = dev->dev_addr[i] =
> bd->bi_enetaddr[i];
> -		}
> -#endif
>  	}
>  
>  	ep->fen_taddrh = 0;
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
