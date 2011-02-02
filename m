Return-Path: <dgibson@ozlabs.org>
Date: Thu, 3 Feb 2011 10:08:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 4/6] powerpc/44x: don't use tlbivax on AMP systems
Message-ID: <20110202230844.GG3032@yookeroo>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-5-git-send-email-shaggy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296586126-32765-5-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 01, 2011 at 12:48:44PM -0600, Dave Kleikamp wrote:
> Since other OS's may be running on the other cores don't use tlbivax

[snip]
> +#ifdef CONFIG_44x
> +void __init early_init_mmu_44x(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +	if (of_flat_dt_is_compatible(root, "ibm,47x-AMP"))
> +		amp = 1;
> +}
> +#endif /* CONFIG_44x */

A test against a hardcoded compatible string seems a nasty way to do
this.  Maybe we should define a new boolean property for the root
node.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
