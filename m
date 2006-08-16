Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E62A67A3F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 06:30:50 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7GKUipH031403
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 16:30:44 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7GKUi5N280694
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 16:30:44 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7GKUhwW017313
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 16:30:44 -0400
Date: Wed, 16 Aug 2006 15:30:43 -0500
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2]:  powerpc/cell spidernet bottom half
Message-ID: <20060816203043.GJ20551@austin.ibm.com>
References: <20060811170337.GH10638@austin.ibm.com>
	<20060816161856.GD20551@austin.ibm.com>
	<44E34825.2020105@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44E34825.2020105@garzik.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 16, 2006 at 12:30:29PM -0400, Jeff Garzik wrote:
> Linas Vepstas wrote:
> >
> >The recent set of low-waterark patches for the spider result in a
> 
> Let's not reinvented NAPI, shall we...

?? 

I was under the impression that NAPI was for the receive side only.
This round of patches were for the transmit queue.

Let me describe the technical problem; perhaps there's some other
solution for it?  

The default socket size seems to be 128KB; (cat
/proc/sys/net/core/wmem_default) if a user application
writes more than 128 KB to a socket, the app is blocked by the 
kernel till there's room in the socket for more.  At gigabit speeds,
a network card can drain 128KB in about a millisecond, or about
four times a jiffy (assuming  HZ=250).  If the network card isn't
generaing interrupts, (and there are no other interrupts flying 
around) then the tcp stack only wakes up once a jiffy, and so 
the user app is scheduled only once a jiffy.  Thus, the max
bandwidth that the app can see is (HZ * wmem_default) bytes per 
second, or about 250 Mbits/sec for my system.  Disappointing 
for a gigabit adapter.

There's three ways out of this: 

(1) tell the sysadmin to 
    "echo 1234567 > /proc/sys/net/core/wmem_default" which 
    violates all the rules.

(2) Poll more frequently than once-a-jiffy. Arnd Bergmann and I 
    got this working, using hrtimers. It worked pretty well,
    but seemed like a hack to me.

(3) Generate transmit queue low-watermark interrupts, 
    which is an admitedly olde-fashioned but common
    engineering practice.  This round of patches implement 
    this.


--linas
