Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>
MIME-Version: 1.0
Subject: Possible eHEA performance issue
Date: Thu, 19 Jul 2007 20:02:04 -0700
Message-ID: <4634.1184900524@neuling.org>
Cc: anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From ehea_start_xmit in ehea_main.c we have:

    if (unlikely(atomic_read(&pr->swqe_avail) <= 1)) {
	    spin_lock_irqsave(&pr->netif_queue, flags);
	    if (unlikely(atomic_read(&pr->swqe_avail) <= 1)) {
		    pr->p_stats.queue_stopped++;
		    netif_stop_queue(dev);
		    pr->queue_stopped = 1;
	    }
	    spin_unlock_irqrestore(&pr->netif_queue, flags);
    }

Since the conditions are the same, isn't it likely that the second 'if'
is going to be taken.  Hence, shouldn't the second 'unlikely' hint be
removed or even changed to likely?

Either way, some documentation here as to why it's done this way would
be useful.  I assume the atomic_read is cheap compared to the
spin_unlock_irqsave, so we quickly check swqe_avail before we check it
again properly with the lock on so we can change some stuff.

Mikey
