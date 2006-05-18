Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 271D867A44
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 10:56:40 +1000 (EST)
Subject: Re: [PATCH/2.6.17-rc4 7/10]  Powerpc: workaround for tsi108 pci
	confi g read exception
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD46730626D624@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD46730626D624@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Thu, 18 May 2006 10:56:32 +1000
Message-Id: <1147913792.10703.61.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Wed, 2006-05-17 at 18:14 +0800, Zang Roy-r61911 wrote:
> Workaround for Tundra Semiconductor tsi108 host bridge pci config read
> exception

Use ppc_md.machine_check_exception instead of modifying the generic
traps.c. Also make sure you can't configure your chip not to issue
machine checks on target/master aborts on config space accesses....

Ben.

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
