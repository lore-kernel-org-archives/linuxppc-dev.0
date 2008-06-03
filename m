Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id B613CDDEE7
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 03:31:01 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions with
	callbacks (not word wrapped)
Date: Tue, 3 Jun 2008 19:30:09 +0200
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806031449.14385.borntraeger@de.ibm.com>
In-Reply-To: <200806031449.14385.borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806031930.09556.arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 03 June 2008, Christian Borntraeger wrote:

> @@ -42,22 +42,48 @@
>   */
>  #define HVC_ALLOC_TTY_ADAPTERS	8
>  
> +struct hvc_struct {
> +	spinlock_t lock;
> +	int index;
> +	struct tty_struct *tty;
> +	unsigned int count;
> +	int do_wakeup;
> +	char *outbuf;
> +	int outbuf_size;
> +	int n_outbuf;
> +	uint32_t vtermno;
> +	struct hv_ops *ops;
> +	int data;
> +	struct list_head next;
> +	struct kref kref; /* ref count & hvc_struct lifetime */
> +};
>  

I don't see a reason to make this data structure known to other files,
so why not leave it in hvc_console.c?


> +
> +#ifdef CONFIG_HVC_IRQ
> +/* default notifier for irq based notification */
> +extern int notifier_add_irq(struct hvc_struct *hp, int irq);
> +extern void notifier_del_irq(struct hvc_struct *hp, int irq);
> +#endif
>  #endif // HVC_CONSOLE_H

Please remove the #ifdef around the declarations.

h	Arnd <><
