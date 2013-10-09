Return-Path: <michael@ellerman.id.au>
Date: Wed, 9 Oct 2013 14:23:15 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Add a debugfs file to read the firmware
 console
Message-ID: <20131009032314.GD23780@concordia>
References: <1381218400.645.204.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381218400.645.204.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 08, 2013 at 06:46:40PM +1100, Benjamin Herrenschmidt wrote:
> With OPALv3, the firmware can provide the address of it's internal console
> to Linux, which we can then display using debugfs. This is handy for
> diagnostics and debugging.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2911abe..10d7894 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -17,6 +17,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/notifier.h>
>  #include <linux/slab.h>
> +#include <linux/debugfs.h>
> +#include <linux/uaccess.h>
>  #include <asm/opal.h>
>  #include <asm/firmware.h>
>  
> @@ -27,6 +29,21 @@ struct opal {
>  	u64 entry;
>  } opal;
>  
> +/* OPAL in-memory console */

It might be nice to point out that the format of the struct is defined
by OPAL and must be in sync with what OPAL is using.

> +struct memcons {
> +	uint64_t magic;

u64 ?

> +#define MEMCONS_MAGIC	0x6630696567726173
> +	uint64_t obuf_phys;
> +	uint64_t ibuf_phys;
> +	uint32_t obuf_size;
> +	uint32_t ibuf_size;
> +	uint32_t out_pos;
> +#define MEMCONS_OUT_POS_WRAP	0x80000000u
> +#define MEMCONS_OUT_POS_MASK	0x00ffffffu

Where does this come from?

> +	uint32_t in_prod;
> +	uint32_t in_cons;
> +};

Should it be packed?

> @@ -369,6 +386,90 @@ static irqreturn_t opal_interrupt(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
> +static ssize_t opal_memcons_read(struct file *file, char __user *to,
> +				 size_t count, loff_t *ppos)
> +{
> +	struct memcons *mc = file->private_data;
> +	size_t available, ret, chunk0, chunk1, lcount;
> +	const char *start, *conbuf = __va(mc->obuf_phys);
> +	loff_t opos, pos;
> +
> +	/*
> +	 * Find out how much is in the buffer. If it has wrapped
> +	 * the whole buffer, else just the beginning. It has wrapped
> +	 * if the next character is not \0
> +	 */
> +	if (mc->out_pos & MEMCONS_OUT_POS_WRAP) {
> +		available = mc->obuf_size;
> +		chunk1 = mc->out_pos & MEMCONS_OUT_POS_MASK;
> +		start = conbuf + chunk1;
> +		chunk0 = mc->obuf_size - chunk1;
> +	} else {
> +		available = mc->out_pos;
> +		start = conbuf;
> +		chunk0 = available;
> +		chunk1 = 0;
> +	}

Surely simple_read_from_buffer() could make some of this simpler?


cheers
