Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (unknown [192.88.158.103])
	by ozlabs.org (Postfix) with ESMTP id 2738E679E1
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 15:56:28 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k4I6CLf3022500
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 23:12:21 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k4I5uFZo011427
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 00:56:16 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673062C03DB@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 7/10]  Powerpc: workaround for tsi108 pci c
	onfi g read exception
Date: Thu, 18 May 2006 13:56:11 +0800
MIME-Version: 1.0
Content-Type: text/plain
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


PB and PCI error flags will be set when issuing a PCI/X configuration 
read request. The error flags should be cleared or the system will be
halt.

Alex, is it right?
Roy

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
