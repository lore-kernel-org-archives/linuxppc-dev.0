Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 577B81A0B68
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 13:45:17 +1100 (AEDT)
Message-ID: <1449024316.11810.6.camel@ellerman.id.au>
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
From: Michael Ellerman <mpe@ellerman.id.au>
To: Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mips@linux-mips.org, Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, linux-cris-kernel@axis.com,
 linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, adi-buildroot-devel@lists.sourceforge.net, Ingo
 Molnar <mingo@redhat.com>, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,  Russell King <rmk+kernel@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>,  linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Date: Wed, 02 Dec 2015 13:45:16 +1100
In-Reply-To: <1448622572-16900-2-git-send-email-pmladek@suse.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-2-git-send-email-pmladek@suse.com>
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

On Fri, 2015-11-27 at 12:09 +0100, Petr Mladek wrote:

> printk() takes some locks and could not be used a safe way in NMI
> context.
> 
> The chance of a deadlock is real especially when printing
> stacks from all CPUs. This particular problem has been addressed
> on x86 by the commit a9edc8809328 ("x86/nmi: Perform a safe NMI stack
> trace on all CPUs").

...

> diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
> new file mode 100644
> index 000000000000..3989e13a0021
> --- /dev/null
> +++ b/kernel/printk/nmi.c
> @@ -0,0 +1,200 @@

...

> +
> +struct nmi_seq_buf {
> +	atomic_t		len;	/* length of written data */
> +	struct irq_work		work;	/* IRQ work that flushes the buffer */
> +	unsigned char		buffer[PAGE_SIZE - sizeof(atomic_t) -
> +				       sizeof(struct irq_work)];
> +};
> +static DEFINE_PER_CPU(struct nmi_seq_buf, nmi_print_seq);


PAGE_SIZE isn't always 4K.

On typical powerpc systems this will give you 128K, and on some 512K, which is
probably not what we wanted.

The existing code just did:

#define NMI_BUF_SIZE           4096

So I think you should just go back to doing that.

cheers
