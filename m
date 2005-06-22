Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0ABAC67B4C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Jun 2005 07:58:21 +1000 (EST)
Date: Wed, 22 Jun 2005 14:58:18 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@freescale.com>
Message-ID: <20050622215818.GA15176@gate.ebshome.net>
References: <Pine.LNX.4.61.0506221539470.3206@nylon.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0506221539470.3206@nylon.am.freescale.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: Add support for Freescale e200 (Book-E) core
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 22, 2005 at 03:41:09PM -0500, Kumar Gala wrote:

[snip]

> +#ifdef CONFIG_E200
> +#define DEBUG_EXCEPTION							      \
> +	START_EXCEPTION(Debug);						      \
> +	DEBUG_EXCEPTION_PROLOG;						      \
> +									      \
> +	/*								      \
> +	 * If there is a single step or branch-taken exception in an	      \
> +	 * exception entry sequence, it was probably meant to apply to	      \
> +	 * the code where the exception occurred (since exception entry	      \
> +	 * doesn't turn off DE automatically).  We simulate the effect	      \
> +	 * of turning off DE on entry to an exception handler by turning      \
> +	 * off DE in the CSRR1 value and clearing the debug status.	      \
> +	 */								      \
> +	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
> +	andis.	r10,r10,DBSR_IC@h;					      \
> +	beq+	2f;							      \
> +									      \
> +	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
> +	ori	r10,r10,KERNELBASE@l;					      \

I think we can get rid of one instruction here :)

-- 
Eugene
