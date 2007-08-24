Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2F567DDE00
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 07:35:18 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7OLZFlc009628
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 17:35:15 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7OLZF5R518562
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 17:35:15 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7OLZFKu003184
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 17:35:15 -0400
Date: Fri, 24 Aug 2007 16:35:14 -0500
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: RFC: issues concerning the next NAPI interface
Message-ID: <20070824213514.GL4282@austin.ibm.com>
References: <8VHRR-45R-17@gated-at.bofh.it> <8VKwj-8ke-27@gated-at.bofh.it>
	<E1IOeSm-0000bm-Jo@be1.lrz> <20070824204243.GI4282@austin.ibm.com>
	<46CF499C.60009@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46CF499C.60009@de.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Bodo Eggert <7eggert@gmx.de>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2007 at 11:11:56PM +0200, Jan-Bernd Themann wrote:
> (when they are available for
> POWER in our case). 

hrtimer worked fine on the powerpc cell arch last summer.
I assume they work on p5 and p6 too, no ??

> I tried to implement something with "normal" timers, but the result
> was everything but great. The timers seem to be far too slow.
> I'm not sure if it helps to increase it from 1000HZ to 2500HZ
> or more.

Heh. Do the math. Even on 1gigabit cards, that's not enough:

(1gigabit/sec) x (byte/8 bits) x (packet/1500bytes) x (sec/1000 jiffy) 

is 83 packets a jiffy (for big packets, even more for small packets, 
and more again for 10 gigabit cards). So polling once per jiffy is a 
latency disaster.

--linas  
