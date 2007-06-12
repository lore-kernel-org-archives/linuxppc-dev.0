Return-Path: <dgibson@ozlabs.org>
Date: Tue, 12 Jun 2007 14:31:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] dtc: parse NOP in dtb input
Message-ID: <20070612043104.GB4198@localhost.localdomain>
References: <311814492916b8b45674.846930886.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <311814492916b8b45674.846930886.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 09, 2007 at 11:21:31PM -0500, Milton Miller wrote:
> Version 16 and later of the flat device tree format allow NOPs
> to be placed in the tree.  When processing dtb input, dtc must
> recognise them.
> 
> Previously it would produce the error message
> FATAL ERROR: Invalid opcode word 00000004 in device tree blob
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> --- 
> 
> I was trying to look at the output of convert_flattree_inplace
> when I found this.  ftdump.c was able to process the input,
> producing // [NOP] comments when encountered.

Oops, we didn't parse NOPs already.  That's a bit of an oversight.

[snip]
> @@ -774,6 +775,13 @@ static struct node *unflatten_tree(struc
>  			die("Premature OF_DT_END in device tree blob\n");
>  			break;
>  
> +		case OF_DT_NOP:
> +			if (flags & FTF_NOPS)
> +				break;
> +
> +			die("OF_DT_NOP in device tree blob\n");
> +			break;
> +

Actually, I think we should accept the NOPs (with at most a warning)
on all DTB versions.  They may not have been defined for the early
versions, but they're not ambiguous.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
