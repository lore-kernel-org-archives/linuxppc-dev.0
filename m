Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18309.33034.549240.640970@cargo.ozlabs.ibm.com>
Date: Thu, 10 Jan 2008 13:20:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: add phy-handle property for fec_mpc52xx
In-Reply-To: <20080109140608.GA15673@aepfle.de>
References: <20080109140608.GA15673@aepfle.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1487,6 +1487,34 @@ static void __init prom_find_mmu(void)
>  	else if (strncmp(version, "FirmWorks,3.", 12) == 0) {
>  		of_workarounds = OF_WA_CLAIM | OF_WA_LONGTRAIL;
>  		call_prom("interpret", 1, 1, "dev /memory 0 to allow-reclaim");
> +#ifdef CONFIG_PPC_MPC52xx
> +	} else if (strcmp(version, "EFIKA5K2") == 0) {

Why have you added this stuff in prom_find_mmu rather than putting it
in fixup_device_tree_efika()?

Paul.
