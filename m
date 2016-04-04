Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdfmy73smzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 14:55:14 +1000 (AEST)
Received: by mail-pa0-x233.google.com with SMTP id fe3so135823466pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Apr 2016 21:55:14 -0700 (PDT)
Date: Mon, 4 Apr 2016 13:56:30 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Chris Metcalf <cmetcalf@ezchip.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 David Miller <davem@davemloft.net>
Subject: Re: [PATCH v4 2/5] printk/nmi: use IRQ work only when ready
Message-ID: <20160404045629.GF6164@swordfish>
References: <1459353210-20260-1-git-send-email-pmladek@suse.com>
 <1459353210-20260-3-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459353210-20260-3-git-send-email-pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On (03/30/16 17:53), Petr Mladek wrote:
> NMIs could happen at any time.  This patch makes sure that the safe
> printk() in NMI will schedule IRQ work only when the related structs are
> initialized.
> 
> All pending messages are flushed when the IRQ work is being initialized.

so, does this patch 'fix' 0001 (in a way)? shouldn't it then be folded?
sorry if I'm missing something.

	-ss

>  DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
> +static int printk_nmi_irq_ready;
>  
>  #define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
>  
> @@ -84,8 +85,11 @@ again:
>  		goto again;
>  
>  	/* Get flushed in a more safe context. */
> -	if (add)
> +	if (add && printk_nmi_irq_ready) {
> +		/* Make sure that IRQ work is really initialized. */
> +		smp_rmb();
>  		irq_work_queue(&s->work);
> +	}
>  
>  	return add;
>  }
> @@ -195,6 +199,13 @@ void __init printk_nmi_init(void)
>  
>  		init_irq_work(&s->work, __printk_nmi_flush);
>  	}
> +
> +	/* Make sure that IRQ works are initialized before enabling. */
> +	smp_wmb();
> +	printk_nmi_irq_ready = 1;
> +
> +	/* Flush pending messages that did not have scheduled IRQ works. */
> +	printk_nmi_flush();
>  }
