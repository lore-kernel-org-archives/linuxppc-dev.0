Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B186DB6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Dec 2011 07:02:47 +1100 (EST)
In-Reply-To: <20111210023646.19516.1453.stgit@suzukikp.in.ibm.com>
References: <20111209114720.16360.9670.stgit@suzukikp.in.ibm.com>
 <20111210023646.19516.1453.stgit@suzukikp.in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <485863B3-91BC-4488-9CA8-4F902D85D8F6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [UPDATED] [PATCH v4 3/7] [ppc] Process dynamic relocations for
 kernel
Date: Sat, 10 Dec 2011 21:02:41 +0100
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: Scott Wood <scottwood@freescale.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Suzuki,

Looks quite good, a few comments...

> +get_type:
> +	/* r4 holds the relocation type */
> +	extrwi	r4, r4, 8, 24	/* r4 = ((char*)r4)[3] */

This comment is confusing (only makes sense together with the
lwz a long way up).

> +nxtrela:
> +	/*
> +	 * We have to flush the modified instructions to the
> +	 * main storage from the d-cache. And also, invalidate the
> +	 * cached instructions in i-cache which has been modified.
> +	 *
> +	 * We delay the msync / isync operation till the end, since
> +	 * we won't be executing the modified instructions until
> +	 * we return from here.
> +	 */
> +	dcbst	r4,r7
> +	icbi	r4,r7

You still need a sync between these two.  Without it, the icbi can
complete before the dcbst for the same address does, which leaves
room for an instruction fetch from that address to get old data.

> +	cmpwi	r8, 0		/* relasz = 0 ? */
> +	ble	done
> +	add	r9, r9, r6	/* move to next entry in the .rela table */
> +	subf	r8, r6, r8	/* relasz -= relaent */
> +	b	applyrela
> +
> +done:
> +	msync			/* Wait for the flush to finish */

The instruction is called "sync".  msync is a BookE thing.

>  	next if (/R_PPC64_RELATIVE/ or /R_PPC64_NONE/ or
>  	         /R_PPC64_ADDR64\s+mach_/);
> +	next if (/R_PPC_ADDR16_LO/ or /R_PPC_ADDR16_HI/ or
> +		 /R_PPC_ADDR16_HA/ or /R_PPC_RELATIVE/);

Nothing new, but these should probably have \b or \s or just
a space on each side.


Segher
