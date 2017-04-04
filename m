Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy6l720MqzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 21:51:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>, gregkh@linuxfoundation.org,
 jslaby@suse.com
Cc: linuxppc-dev@ozlabs.org, Denis Kirjanov <kda@linux-powerpc.org>,
 linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org <benh@kernel.crashing.org>
Subject: Re: [PATCH] tty/hvc_console: fix console lock ordering with spinlock
In-Reply-To: <1490882779-16066-1-git-send-email-kda@linux-powerpc.org>
References: <1490882779-16066-1-git-send-email-kda@linux-powerpc.org>
Date: Tue, 04 Apr 2017 21:51:45 +1000
Message-ID: <877f30v19q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Denis Kirjanov <kda@linux-powerpc.org> writes:

> hvc_remove() takes a spin lock first then acquires the console
> semaphore. This situation can easily lead to a deadlock scenario
> where we call scheduler with spin lock held.

Have you actually hit the deadlock? Because that code's been like that
for years and I've never received a bug report.

> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index b19ae36..a8d3991 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -920,17 +920,17 @@ int hvc_remove(struct hvc_struct *hp)
>  
>  	tty = tty_port_tty_get(&hp->port);
>  
> +	console_lock();
>  	spin_lock_irqsave(&hp->lock, flags);
>  	if (hp->index < MAX_NR_HVC_CONSOLES) {
> -		console_lock();
>  		vtermnos[hp->index] = -1;
>  		cons_ops[hp->index] = NULL;
> -		console_unlock();
>  	}
>  
>  	/* Don't whack hp->irq because tty_hangup() will need to free the irq. */
>  
>  	spin_unlock_irqrestore(&hp->lock, flags);
> +	console_unlock();

I get that you're trying to do the minimal change, but I don't think the
result is ideal. If this isn't a console hvc then we take both locks but
do nothing.

So what about:

	if (hp->index < MAX_NR_HVC_CONSOLES) {
		console_lock();
		spin_lock_irqsave(&hp->lock, flags);
		vtermnos[hp->index] = -1;
		cons_ops[hp->index] = NULL;
		spin_unlock_irqrestore(&hp->lock, flags);
		console_unlock();
	}

cheers
