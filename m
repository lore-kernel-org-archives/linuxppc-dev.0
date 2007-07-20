Return-Path: <osstklei@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 752D3DDF36
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 18:17:39 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6K8HZPg075394
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 08:17:35 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6K8HZOr1216628
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 10:17:35 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6K8HIuF004923
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 10:17:18 +0200
Message-ID: <46A06F7E.901@de.ibm.com>
Date: Fri, 20 Jul 2007 10:17:02 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Possible eHEA performance issue
References: <4634.1184900524@neuling.org>
In-Reply-To: <4634.1184900524@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> From ehea_start_xmit in ehea_main.c we have:
> 
>     if (unlikely(atomic_read(&pr->swqe_avail) <= 1)) {
> 	    spin_lock_irqsave(&pr->netif_queue, flags);
> 	    if (unlikely(atomic_read(&pr->swqe_avail) <= 1)) {
> 		    pr->p_stats.queue_stopped++;
> 		    netif_stop_queue(dev);
> 		    pr->queue_stopped = 1;
> 	    }
> 	    spin_unlock_irqrestore(&pr->netif_queue, flags);
>     }
> 
> Since the conditions are the same, isn't it likely that the second 'if'
> is going to be taken.  Hence, shouldn't the second 'unlikely' hint be
> removed or even changed to likely?
> 
> Either way, some documentation here as to why it's done this way would
> be useful.  I assume the atomic_read is cheap compared to the
> spin_unlock_irqsave, so we quickly check swqe_avail before we check it
> again properly with the lock on so we can change some stuff.
> 
> Mikey

Hi Mike,

good point the second if could be a likely(). The impact isn't that big
because the if statement is true in the unlikely() case that the send queue
is full - which doesn't happen often. Anyway we will modify this in one of
the next driver versions. Thanks for the hint!

Thomas
