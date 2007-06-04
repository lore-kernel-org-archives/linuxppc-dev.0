Return-Path: <hch@lst.de>
Date: Mon, 4 Jun 2007 10:01:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PATCH 19/21] powerpc: Merge creation of signal frame (#2)
Message-ID: <20070604080126.GA19961@lst.de>
References: <20070604051559.3E8C1DDF43@ozlabs.org>
	<1180941768.31677.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180941768.31677.50.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 04, 2007 at 05:22:48PM +1000, Benjamin Herrenschmidt wrote:
> +/*
> + * Allocate space for the signal frame
> + */
> +void __user * get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
> +			   size_t frame_size)

little style nitpick: no whitespace after the *, please.

> +{
> +        unsigned long oldsp, newsp;
> +
> +        /* Default to using normal stack */
> +        oldsp = regs->gpr[1];
> +
> +	/* Check for alt stack */
> +	if ((ka->sa.sa_flags & SA_ONSTACK) &&
> +	    current->sas_ss_size && !on_sig_stack(oldsp))
> +		oldsp = (current->sas_ss_sp + current->sas_ss_size);
> +
> +	/* Get aligned frame */
> +	newsp = (oldsp - frame_size) & ~0xFUL;
> +
> +	/* Check access */
> +	if (!access_ok(VERIFY_WRITE, (void __user *)newsp, oldsp - newsp))
> +		return NULL;
> +
> +        return (void __user *)newsp;
> +}

The body also has some odd whitespace problems.  I'd also make
newsp a void __user variable to only do the cast once.  In the end the
function should looks something like:

void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
		size_t frame_size)
{
	unsigned long oldsp;
	void __user *newsp;

	/* Check for alt stack */
	if ((ka->sa.sa_flags & SA_ONSTACK) &&
	    current->sas_ss_size && !on_sig_stack(oldsp))
		oldsp = (current->sas_ss_sp + current->sas_ss_size);
	else
		oldsp = regs->gpr[1];

	/* Get aligned frame */
	newsp = (void __user *)((oldsp - frame_size) & ~0xFUL);

	/* Check access */
	if (!access_ok(VERIFY_WRITE, newsp, oldsp - newsp))
		return NULL;

	return newsp;
}
