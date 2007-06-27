Return-Path: <dgibson@ozlabs.org>
Date: Wed, 27 Jun 2007 11:22:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 07/15] [POWERPC] Removed remnants of bus_offset
Message-ID: <20070627012206.GB11191@localhost.localdomain>
References: <11829070051484-git-send-email-galak@kernel.crashing.org>
	<11829070063989-git-send-email-galak@kernel.crashing.org>
	<11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
	<1182907013252-git-send-email-galak@kernel.crashing.org>
	<1182907014549-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1182907014549-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2007 at 08:16:37PM -0500, Kumar Gala wrote:
> Removed the remants of bus_offset and use self_busno in the mv64x60 case
> and use pci_assign_all_buses on 83xx/85xx.
> 
> 83xx/85xx have multiple PHBs and the firmwares on these devices tend not
> to handle topologies with P2P bridges well so we let Linux just reassign
> the bus numbers to match.

[snip]
> diff --git a/include/asm-ppc/pci-bridge.h b/include/asm-ppc/pci-bridge.h
> index 2c2abda..70aab66 100644
> --- a/include/asm-ppc/pci-bridge.h
> +++ b/include/asm-ppc/pci-bridge.h
> @@ -48,6 +48,7 @@ struct pci_controller {
>  	int first_busno;
>  	int last_busno;
>  	int self_busno;
> +	/* bus_offset is only used by ARCH=ppc */
>  	int bus_offset;
>  
>  	void __iomem *io_base_virt;

Might be a good time to copy asm-ppc/pci-bridge.h to
asm-powerpc/pci-bridge-32.h, yeah?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
