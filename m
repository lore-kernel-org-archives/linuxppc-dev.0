Return-Path: <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 16:10:06 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 01/10] irq: move some interrupt arch_* functions into
	struct irq_chip.
Message-ID: <20100323071006.GJ13417@linux-sh.org>
References: <1269221770-9667-1-git-send-email-yinghai@kernel.org>
	<1269221770-9667-2-git-send-email-yinghai@kernel.org>
	<1269222962.3534.12.camel@concordia> <4BA6E4D1.6080704@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BA6E4D1.6080704@kernel.org>
Cc: lguest@ozlabs.org, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-sh@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Campbell <ian.campbell@citrix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 21, 2010 at 08:32:33PM -0700, Yinghai Lu wrote:
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 64f6f20..cafd378 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -1088,7 +1088,7 @@ int arch_early_irq_init(void)
>  	return 0;
>  }
>  
> -int arch_init_chip_data(struct irq_desc *desc, int node)
> +int arch_init_irq_desc(struct irq_desc *desc, int node, init_chip_data_fn fn)
>  {
>  	desc->status |= IRQ_NOREQUEST;
>  	return 0;
> 
> so this patch only change one line with powerpc code. 

This API seems to be going from bad to worse. Initially we had
arch_init_chip_data(), which had precisely nothing to do with chip_data
and only concerned itself with irq_desc, and now you're renaming it to
something sensible but also trying to bolt on some ad-hoc chip_data
relation at the same time thereby nullifying any benefit obtained from
renaming the function in the first place.

Renaming to xxx_irq_desc() while preserving the existing prototypes would
make sense, even if it's ultimately just unecessary churn.

> > It looks to me like this should just be done via a current machine
> > vector or platform routine, in the same way as powerpc and (I think)
> > ia64, ie:
> > 
> >> +int arch_init_irq_desc(struct irq_desc *desc, int node)
> >> +{
> >> +	return current_machine->init_chip_data(desc, node);
> >> +}
> > 
> looks like xen in same run time, some irqs need x86_init_chip_data,
> and some may need xen_init_chip_data later.
> 
I'm afraid I am unable to grasp the meaning of this sentence, or what
precisely this has to do with not being able to utilize platform ops to
get this sorted out on x86.

You're effectively trying to have the hardirq code pass around a function
pointer for you that ultimately only serves to bail out on certain code
paths if you're running under xen, which is a concern for how the
platform chooses to initialize the irq desc, none of this has any value
or relevance to the hardirq code outside of that. The fact that the
hardirq code doesn't do anything with this information other than pass it
around for your platform should already be a clear indicator that this is
the wrong way to go.

>From a cursory look at the x86 code, this looks like precisely the sort
of thing that arch/x86/include/asm/x86_init.h is well suited for, and
indeed you already have a x86_init_irqs to expand on as needed.

The function pointer thing itself is also a bit unorthodox to say the
least. You're introducing and passing around an opaque type just so you
can get to a 'return 0' in the xen case as far as I can tell, so you
could also just make arch_init_chip_data() a weak symbol and clobber it
in the xen case, no?
