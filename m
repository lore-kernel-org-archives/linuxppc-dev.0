Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EAE1267A77
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 04:09:45 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k51I9amm005358
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2006 14:09:36 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k51I9aSm121930
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2006 14:09:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k51I9ZMZ005485
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2006 14:09:36 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] use msleep() for RTAS delays
Date: Thu, 1 Jun 2006 20:09:34 +0200
References: <1149103929.2524.8.camel@sinatra.austin.ibm.com>
	<1149139866.28307.32.camel@localhost.localdomain>
	<17534.32164.268580.217501@cargo.ozlabs.ibm.com>
In-Reply-To: <17534.32164.268580.217501@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606012009.35082.arnd.bergmann@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 01 June 2006 07:39, Paul Mackerras wrote:
> 
> > rtas_call_waitbusy(...);
> 
> That's a good idea...

Do we also need an atomic version of that? Maybe there are
places where we actually need to call a slow rtas call
under a spinlock.

At the very least, rtas_call_waitbusy() should have a
might_sleep() in it to find those places.

	Arnd <><
