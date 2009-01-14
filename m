Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 6D459474C2
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 21:00:08 +1100 (EST)
Date: Wed, 14 Jan 2009 11:00:05 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Add init_dummy_netdev() and fix EMAC driver using it
In-Reply-To: <1231906495.22571.79.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0901141057110.31703@vixen.sonytel.be>
References: <1231906495.22571.79.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: netdev <netdev@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 14 Jan 2009, Benjamin Herrenschmidt wrote:
> This adds an init_dummy_netdev() function that gets a network device
> structure (allocation and lifetime entirely under caller's control) and
> initialize the minimum amount of fields so it can be used to schedule
> NAPI polls without registering a full blown interface. This is to be
> used by drivers that need to tie several hardware interfaces to a single
> NAPI poll scheduler due to HW limitations.
> 
> It also updates the ibm_newemac driver to use that, this fixing the
> oops on 2.6.29 due to passing NULL as "dev" to netif_napi_add()
> 
> Symbol is exported GPL only a I don't think we want binary drivers doing
> that sort of acrobatics (if we want them at all).
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks, this fixed my Sequoia!

Tested-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

> --- linux-work.orig/include/linux/netdevice.h	2009-01-13 16:13:41.000000000 +1100
> +++ linux-work/include/linux/netdevice.h	2009-01-14 14:13:24.000000000 +1100
> @@ -4434,6 +4434,45 @@ err_uninit:
>  }
>  
>  /**
> + *	init_dummy_netdev	- init a dummy network device for NAPI
> + *	@dev: device to init
> + *
> + *	This takes a network device structure and initialize the minimum
                                                  ^^^^^^^^^^
						  initializes
> + *	amount of fields so it can be used to schedule NAPI polls without
> + *	registering a full blown interface. This is to be used by drivers
> + *	that need to tie several hardware interfaces to a single NAPI
> + *	poll scheduler due to HW limitations.
> + */
> +int init_dummy_netdev(struct net_device *dev)
> +{
> +	/* Clear everything. Note we don't initialize spinlocks
> +	 * are they aren't supposed to be taken by any of the
           ^^^
	   as
> +	 * NAPI code and this dummy netdev is supposed to be
> +	 * only ever used for NAPI polls
> +	 */

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
