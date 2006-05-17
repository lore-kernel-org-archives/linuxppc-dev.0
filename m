Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8440C67A64
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 02:07:43 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730626D624@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD46730626D624@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <378EE754-2656-4099-8689-D92A1FB65C35@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/2.6.17-rc4 7/10] Powerpc: workaround for tsi108 pci confi
	g read exception
Date: Wed, 17 May 2006 11:07:54 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:

> Workaround for Tundra Semiconductor tsi108 host bridge pci config read
> exception

Can you explain further why this is needed?


>
> Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
> Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>
>
> ---
>
>  arch/powerpc/kernel/traps.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
>
> 0575fbe21e4f1045528bb91ec4b34bb7955c4a92
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 064a525..7468d76 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -262,6 +262,19 @@ #if defined(CONFIG_PPC_PMAC) && defined(
>  		}
>  	}
>  #endif /* CONFIG_PPC_PMAC && CONFIG_PPC32 */
> +
> +#ifdef CONFIG_TSI108_BRIDGE
> +	extern void tsi108_clear_pci_cfg_error(void);
> +	const struct exception_table_entry *entry;
> +
> +	/* Are we prepared to handle this fault?  */
> +	if ((entry = search_exception_tables(regs->nip)) != NULL) {
> +		tsi108_clear_pci_cfg_error();
> +		regs->msr |= MSR_RI;
> +		regs->nip = entry->fixup;
> +		return 1;
> +	}
> +#endif /* CONFIG_TSI108_BRIDGE */
>  	return 0;
>  }
>
> -- 
> 1.3.0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
