Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <boot-6-06.miltonm@bga.com>
References: <boot-6-06.miltonm@bga.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E8BEA706-0A5A-45F4-B905-5D090623BFAE@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/15] bootwrapper: switch 64 bit cpus to 32 bit mode
Date: Wed, 11 Jul 2007 00:57:07 +0200
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	/* Check if the processor is running in 32 bit mode, using
> +	 * only 32 bit instructions which should be safe on 32 and
> +	 * 64 bit processors.
> +	 *
> +	 * Subtract the bottom 32 bits of MSR from the full value
> +	 * recording the result.  Since MSR[SF] is in the high word,
> +	 * the result will be not-equal iff in 32 bit mode (either
> +	 * the processor is a 32 bit processor or MSR[SF] = 0).
> +	 */

The other way around -- the processor is 64-bit and MSR[SF]=1.

Great trick btw! :-)

> +	mfmsr	r0		/* grab whole msr		*/
> +	rlwinm	r8,r0,0,0,31	/* extract bottom word		*/
> +	subf.	r8,r8,r0	/* subtract, same?		*/
> +	beq	0f		/* yes: we are 32 bit mode	*/

The code is fine though.


Segher
