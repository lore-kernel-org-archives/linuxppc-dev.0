Message-ID: <3E6534FA.9070503@embeddededge.com>
Date: Tue, 04 Mar 2003 18:21:30 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
References: <20030304191644.GA4524@rover.farnsworth.org> <3E64FD53.3030107@embeddededge.com> <20030304201302.GA4683@rover.farnsworth.org> <3E650AAF.7060804@embeddededge.com> <20030304230849.GB4683@rover.farnsworth.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dale Farnsworth wrote:

> -	nop	/* used by __secondary_hold on prep (mtx) and chrp smp */
> -	nop	/* used by __secondary_hold on prep (mtx) and chrp smp */
> +	/*
> +	 * The first two words are used by __secondary_hold on SMP systems.
> +	 * The second word may be overwritten before the first cpu runs
> +	 * here, so we branch around it.
> +	 */
> +	b	__start
> +	nop
>  	nop

I thought of this, but the comment on the first nop bothered me.
Was it just a cut/paste without updating the comment, or could the nop
and location zero be used by MP systems just like the one at location 0x04?

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
