Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C95EB7D06
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Apr 2010 22:27:44 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id o36BdwMl023841
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Apr 2010 17:09:58 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o36CRfTa3223596
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Apr 2010 17:57:41 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o36CRes5001525
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Apr 2010 22:27:41 +1000
Message-ID: <4BBB28BB.2080102@in.ibm.com>
Date: Tue, 06 Apr 2010 17:57:39 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 4/7] hvc_console: Fix race between hvc_close and hvc_remove
References: <20100319151326.GC8541@kroah.com>
	<1269011916-8836-4-git-send-email-gregkh@suse.de>
	<1269119079.8599.65.camel@pasglop>
	<20100321043725.GA21566@amit-x200.redhat.com>
	<20100324121902.GJ15789@amit-x200.redhat.com>
	<4BAC7AD4.4030309@in.ibm.com>
	<20100326095821.GA7039@amit-x200.redhat.com>
	<4BAC9D9E.5070901@in.ibm.com>
	<20100326124340.GB7039@amit-x200.redhat.com>
	<20100406114238.GN5594@kryten>
In-Reply-To: <20100406114238.GN5594@kryten>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Greg Kroah-Hartman <gregkh@suse.de>, a.p.zijlstra@chello.nl,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Amit Shah <amit.shah@redhat.com>, tglx@linutronix.de,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard wrote:
> The patch below changes things to call tty_kref_put once for every
> hvc_close call, and with that my machine boots fine.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>   
Works for me. Thanks Anton.

Regards
-Sachin

> diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
> index d3890e8..35cca4c 100644
> --- a/drivers/char/hvc_console.c
> +++ b/drivers/char/hvc_console.c
> @@ -368,16 +368,12 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
>  	hp = tty->driver_data;
>
>  	spin_lock_irqsave(&hp->lock, flags);
> -	tty_kref_get(tty);
>
>  	if (--hp->count == 0) {
>  		/* We are done with the tty pointer now. */
>  		hp->tty = NULL;
>  		spin_unlock_irqrestore(&hp->lock, flags);
>
> -		/* Put the ref obtained in hvc_open() */
> -		tty_kref_put(tty);
> -
>  		if (hp->ops->notifier_del)
>  			hp->ops->notifier_del(hp, hp->data);
>
>
>   


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
