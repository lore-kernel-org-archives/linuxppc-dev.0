Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.17.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E58F0DE0EE
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 22:28:48 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id n0DBShKA011922
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 11:28:43 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id n0DBSgra2162754
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 12:28:42 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n0DBSgIm023480
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 12:28:42 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/4] hvc_console: do not set low_latency
Date: Tue, 13 Jan 2009 12:28:41 +0100
References: <hvc-console-29-3-1@bga.com>
	<200901131004.22609.borntraeger@de.ibm.com>
In-Reply-To: <200901131004.22609.borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200901131228.41189.borntraeger@de.ibm.com>
Cc: Joe Peterson <joe@skyrush.com>, lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Dienstag 13 Januar 2009 schrieb Christian Borntraeger:
>  drivers/char/hvc_console.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/char/hvc_console.c
> ===================================================================
> --- linux-2.6.orig/drivers/char/hvc_console.c
> +++ linux-2.6/drivers/char/hvc_console.c
> @@ -318,8 +318,6 @@ static int hvc_open(struct tty_struct *t
>  	} /* else count == 0 */
> 
>  	tty->driver_data = hp;
> -	tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
> -
>  	hp->tty = tty;
> 
>  	spin_unlock_irqrestore(&hp->lock, flags);
> @@ -327,6 +325,9 @@ static int hvc_open(struct tty_struct *t
>  	if (hp->ops->notifier_add)
>  		rc = hp->ops->notifier_add(hp, hp->data);
> 
> +	if (!hp->irq_requested)
> +		tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
> +
>  	/*
>  	 * If the notifier fails we return an error.  The tty layer
>  	 * will call hvc_close() after a failed open but we don't want to clean
> 
> 

Just in case:

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
