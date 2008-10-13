Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A46ADDF3E
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 19:47:19 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m9D8lFDo209388
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 08:47:15 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9D8lEVP1867876
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 09:47:14 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9D8lD0r022865
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 09:47:13 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions with
	callbacks
Date: Mon, 13 Oct 2008 10:47:12 +0200
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200810130951.31733.borntraeger@de.ibm.com>
	<1223886972.8157.241.camel@pasglop>
In-Reply-To: <1223886972.8157.241.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810131047.12748.borntraeger@de.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Montag, 13. Oktober 2008 schrieb Benjamin Herrenschmidt:
> 
> >  	if (--hp->count == 0) {
> > -		if (hp->ops->notifier_del)
> > -			hp->ops->notifier_del(hp, hp->data);
> > -
> >  		/* We are done with the tty pointer now. */
> >  		hp->tty = NULL;
> >  		spin_unlock_irqrestore(&hp->lock, flags);
> >  
> > +		if (hp->ops->notifier_del)
> > +			hp->ops->notifier_del(hp, hp->data);
> > +
> 
> I will try. Of course the risk here is that the interrupt happens
> after we set hp->tty to NULL, so we probably need to check within the
> interrupt handler for a NULL tty. I haven't checked if that's the case
> (I'm not in front of the code right now).

Even the old code (without my patch) was setting hp->tty to NULL before doing 
the irq_free, so that should be ok.

Christian
