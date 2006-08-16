Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5F9CB67B76
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 09:30:33 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7GNUUGb031544
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 19:30:30 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7GNUUgf081236
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 17:30:30 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7GNUT0E014433
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 17:30:29 -0600
Date: Wed, 16 Aug 2006 18:30:28 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Message-ID: <20060816233028.GO20551@austin.ibm.com>
References: <44E38157.4070805@garzik.org> <200608162324.47235.arnd@arndb.de>
	<20060816.143203.11626235.davem@davemloft.net>
	<200608170016.47072.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200608170016.47072.arnd@arndb.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens.Osterkamp@de.ibm.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 17, 2006 at 12:16:46AM +0200, Arnd Bergmann wrote:
> Am Wednesday 16 August 2006 23:32 schrieb David Miller:
> > Can spidernet be told these kinds of parameters?  "N packets or
> > X usecs"?
> 
> It can not do exactly this but probably we can get close to it by

Why would you want o do this? It seems like a cruddier strategy 
than what we can already do  (which is to never get an transmit
interrupt, as long as the kernel can shove data into the device fast
enough to keep the queue from going empty.)  The whole *point* of a 
low-watermark interrupt is to never have to actually get the interrupt, 
if the rest of the system is on its toes and is supplying data fast
enough.

--linas
