Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070907032353.GA3082@localhost.localdomain>
References: <20070907032353.GA3082@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2fcd14e175d5a215cd8d602ac74fce21@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Document and implement an improved flash device binding for
	powerpc (v5)
Date: Fri, 7 Sep 2007 16:25:10 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch replaces the binding for flash chips in
> booting-without-of.txt with an clarified and improved version.  It
> also makes drivers/mtd/maps/physmap_of.c recognize this new binding.
> Finally it revises the Ebony device tree source to use the new binding
> as an example.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

Thanks for doing this work David!


> +	/* First look for RedBoot table or partitions on the command
> +	 * line, these take precedence over device tree information */

Any specific reason you chose this order?  Just curious...

> +		.data		= (void *)"jedec_probe",

Hrm, this cast is only getting rid of the const-ness of the
string literal -- maybe .data should be declared const, or
does the majority of users want it writable?


Segher
