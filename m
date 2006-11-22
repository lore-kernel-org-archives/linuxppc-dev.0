Return-Path: <benh@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58FC867C29
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 08:17:51 +1100 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id kAMLT6PL036940
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 08:29:06 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAMLKxw2116012
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 08:21:09 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAMLHWq9026926
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 08:17:32 +1100
Subject: Re: [PATCH] powerpc: Fix __raw* accessors
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Jens Osterkamp <jens@de.ibm.com>
In-Reply-To: <200611221446.02716.jens@de.ibm.com>
References: <1164072929.8073.45.camel@localhost.localdomain>
	<200611211129.59685.arnd@arndb.de> <200611221446.02716.jens@de.ibm.com>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 08:18:09 +1100
Message-Id: <1164230289.5653.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>, Jens Osterkamp <jens.osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-22 at 14:46 +0100, Jens Osterkamp wrote:
> On Tuesday 21 November 2006 11:29, Arnd Bergmann wrote:
> > On Tuesday 21 November 2006 02:35, Benjamin Herrenschmidt wrote:
> > > The new IO accessor code allows to stick a token in the top bit of MMIO
> > > addresses which gets masked out during actual accesses. However, the
> > > __raw_* accessors forgot to mask it out. This fixes it.
> >
> > Jens, you debugged the problem originally. Does this patch fix it entirely,
> > or is there something else missing?
> 
> The driver basically works, but I am seeing strange im_free messages,
> probably because this code is not aware of the tokens in the ioremapped 
> addresses.

Or becasue ioumap isn't properly masking out the token... I'll check
that.

Ben.

> <6>ib_mthca: Mellanox InfiniBand HCA driver v0.08 (February 14, 2006)
> <6>ib_mthca: Initializing 0002:00:00.0
> <3>Trying to im_free nonexistent area (d002080080930000)
> <6>ib_mthca: Initializing 0004:00:00.0
> <3>Trying to im_free nonexistent area (d003080082a37000)
> <4>ib_mthca 0004:00:00.0: HCA FW version 4.6.0 is old (4.7.600 is current).
> <4>ib_mthca 0004:00:00.0: If you have problems, try updating your HCA FW.
> 
> Jens
