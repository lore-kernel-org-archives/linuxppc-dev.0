Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18D751A026E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 20:27:21 +1100 (AEDT)
Message-ID: <1447666040.2191.3.camel@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc: Print MSR TM bits in oops message
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
Cc: sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org
Date: Mon, 16 Nov 2015 20:27:20 +1100
In-Reply-To: <1447390652-28355-1-git-send-email-mikey@neuling.org>
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-11-13 at 15:57 +1100, Michael Neuling wrote:

> Print the MSR TM bits in oops messages.  This appends them to the end
> like this:
>  MSR: 8000000502823031 <SF,VEC,VSX,FP,ME,IR,DR,LE,TM[TE]>
> 
> You get the TM[] only if at least one TM MSR bit is set.  Inside the
> TM[], E means Enabled (bit 32), S means Suspended (bit 33), and T
> means Transactional (bit 34)

Can you duplicate this into a comment in printtmbits() or on the bit
definitions, so that I don't have to look up the commit to find the
explanation.

> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +static struct regbit msr_tm_bits[] = {
> +	{MSR_TS_T,	"T"},
> +	{MSR_TS_S,	"S"},
> +	{MSR_TM,	"E"},
> +	{0,		NULL}
> +};
> +static void printtmbits(unsigned long val)

I realise you followed the lead here with the naming, but can you call it
print_tm_bits() please. MY EYES!

> +{
> +	if (val & (MSR_TM | MSR_TS_S | MSR_TS_T)) {
> +		printk(",TM[");
> +		printbits(val, msr_tm_bits, "");
> +		printk("]");

I suspect all these individual printks are going to behave badly if we have
multiple cpus crashing simultaneously. But I won't make you fix that here. We
should look at it sometime though.

cheers
