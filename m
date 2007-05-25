Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05A08DDEE7
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 08:44:14 +1000 (EST)
Subject: Re: [Patch ] Kexec/Kdump support - POWER6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: sachinp@in.ibm.com
In-Reply-To: <4656A488.2020507@in.ibm.com>
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
	<20070524121751.GB4547@in.ibm.com> <20070524142133.GA13191@lixom.net>
	<4656A488.2020507@in.ibm.com>
Content-Type: text/plain
Date: Sat, 26 May 2007 08:43:07 +1000
Message-Id: <1180132987.19517.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, kexec@lists.infradead.org,
	Milton Miller II <miltonm@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  
>  	/* TODO: Use bulk call */
> -	for (i = 0; i < hpte_count; i++)
> -		plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
> +	for (i = 0; i < hpte_count; i++) {
> +		/* dont remove HPTEs with VRMA mappings */
> +		lpar_rc = plpar_pte_remove_raw(H_ANDCOND, i, VRMA_HPTE_B_1TB,
> +						&dummy1, &dummy2);

If you're going to use the B (1T segment) bit instead of the bolted bit,
at least define a proper constant in line with the existing naming of
the hash table constants in mmu-hash64.h. I would suggest doing the same
with the VRMA_MASK/VALUE thing and calling it HPTE_V_VRMA_MASK or
something similar.

> +		if (lpar_rc == H_NOT_FOUND) {
> +			lpar_rc = plpar_pte_read_raw(0, i, &dword0, &dummy1);
> +			if (!lpar_rc && 
> +				(((dword0 >> 24) & VRMA_MASK) != VRMA_MASK))
> +				/* Can be hpte for 1TB Seg. So remove it */
> +				plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
> +		}
> +	}
>  }

In addition, I would recommend following Michael's advice and using
using the bulk remove Hcall whenever possible.

Cheers,
Ben.
