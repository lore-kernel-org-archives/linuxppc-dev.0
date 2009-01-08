Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.17.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55E1DDE3B7
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 03:50:36 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id n08GoUww029070
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 16:50:30 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id n08GoUqV3272752
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 17:50:30 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n08GoUlh018945
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 17:50:30 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/4] hvc_console: free_irq only if request_irq was
	successful
Date: Thu, 8 Jan 2009 17:50:31 +0100
References: <hvc-console-29-3-3@bga.com>
In-Reply-To: <hvc-console-29-3-3@bga.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200901081750.31637.borntraeger@de.ibm.com>
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

Am Donnerstag, 8. Januar 2009 schrieb Milton Miller:
> Only call free_irq if we marked the request_irq has having succeeded
> instead of whenever the the sub-driver identified the interrupt to use.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> ---
> Appears to be a bugfix but might use a bit of time in -next.
> This code was created in 2.6.28 to allow s390 to build without adding 
ifdefs.
> Many hvc-console sub-drivers have a single channel and are not modules.
> 
> Index: work.git/drivers/char/hvc_irq.c
> ===================================================================
> --- work.git.orig/drivers/char/hvc_irq.c	2009-01-08 04:07:28.000000000 -0600
> +++ work.git/drivers/char/hvc_irq.c	2009-01-08 04:07:47.000000000 -0600
> @@ -37,7 +37,7 @@ int notifier_add_irq(struct hvc_struct *
> 
>  void notifier_del_irq(struct hvc_struct *hp, int irq)
>  {
> -	if (!irq)
> +	if (!hp->irq_requested)
>  		return;
>  	free_irq(irq, hp);
>  	hp->irq_requested = 0;
> 

Looks sane.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
