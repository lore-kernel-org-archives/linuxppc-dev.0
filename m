Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFwBX1yLWzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 17:50:58 +1000 (AEST)
Date: Fri, 19 Aug 2016 08:50:34 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 chris.ryder@arm.com, pawel.moll@arm.com, mhiramat@kernel.org,
 jolsa@kernel.org, mpe@ellerman.id.au, hemant@linux.vnet.ibm.com,
 namhyung@kernel.org
Subject: Re: [PATCH v5 2/7] perf annotate: Add cross arch annotate support
Message-ID: <20160819075034.GG1041@n2100.armlinux.org.uk>
References: <1471584546-11080-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1471584546-11080-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471584546-11080-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 19, 2016 at 10:59:01AM +0530, Ravi Bangoria wrote:
> -static struct ins instructions[] = {
> +static struct ins instructions_x86[] = {
>  	{ .name = "add",   .ops  = &mov_ops, },
>  	{ .name = "addl",  .ops  = &mov_ops, },
>  	{ .name = "addq",  .ops  = &mov_ops, },
>  	{ .name = "addw",  .ops  = &mov_ops, },
>  	{ .name = "and",   .ops  = &mov_ops, },
> -#ifdef __arm__
> -	{ .name = "b",     .ops  = &jump_ops, }, // might also be a call
> -	{ .name = "bcc",   .ops  = &jump_ops, },
> -	{ .name = "bcs",   .ops  = &jump_ops, },
> -	{ .name = "beq",   .ops  = &jump_ops, },
> -	{ .name = "bge",   .ops  = &jump_ops, },
> -	{ .name = "bgt",   .ops  = &jump_ops, },
> -	{ .name = "bhi",   .ops  = &jump_ops, },
> -	{ .name = "bl",    .ops  = &call_ops, },
> -	{ .name = "bls",   .ops  = &jump_ops, },
> -	{ .name = "blt",   .ops  = &jump_ops, },
> -	{ .name = "blx",   .ops  = &call_ops, },
> -	{ .name = "bne",   .ops  = &jump_ops, },
> -#endif

Notice that ARM includes a lot of other instructions from this table,
not just those above.

>  	{ .name = "bts",   .ops  = &mov_ops, },
>  	{ .name = "call",  .ops  = &call_ops, },
>  	{ .name = "callq", .ops  = &call_ops, },
> @@ -456,6 +444,21 @@ static struct ins instructions[] = {
>  	{ .name = "retq",  .ops  = &ret_ops, },
>  };
>  
> +static struct ins instructions_arm[] = {
> +	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */
> +	{ .name = "bcc",   .ops  = &jump_ops, },
> +	{ .name = "bcs",   .ops  = &jump_ops, },
> +	{ .name = "beq",   .ops  = &jump_ops, },
> +	{ .name = "bge",   .ops  = &jump_ops, },
> +	{ .name = "bgt",   .ops  = &jump_ops, },
> +	{ .name = "bhi",   .ops  = &jump_ops, },
> +	{ .name = "bl",    .ops  = &call_ops, },
> +	{ .name = "bls",   .ops  = &jump_ops, },
> +	{ .name = "blt",   .ops  = &jump_ops, },
> +	{ .name = "blx",   .ops  = &call_ops, },
> +	{ .name = "bne",   .ops  = &jump_ops, },
> +};
> +
...
> +	if (!strcmp(norm_arch, NORM_X86)) {
> +		instructions = instructions_x86;
> +		nmemb = ARRAY_SIZE(instructions_x86);
> +	} else if (!strcmp(norm_arch, NORM_ARM)) {
> +		instructions = instructions_arm;
> +		nmemb = ARRAY_SIZE(instructions_arm);

But these changes result in _only_ the ones that were in the #if __arm__
being matched.  This is wrong.

If we want to go that way, we need to add _all_ arm instructions to
instructions_arm, not just those within the #if.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
