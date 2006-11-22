Return-Path: <jens@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2F97367BFF
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 00:46:19 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id kAMDk4Bc129080
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 13:46:04 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kAMDnVUd3158114
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 14:49:31 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kAMDk2Pd012662
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 14:46:03 +0100
From: Jens Osterkamp <jens@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix __raw* accessors
Date: Wed, 22 Nov 2006 14:46:02 +0100
References: <1164072929.8073.45.camel@localhost.localdomain>
	<200611211129.59685.arnd@arndb.de>
In-Reply-To: <200611211129.59685.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611221446.02716.jens@de.ibm.com>
Cc: Jens Osterkamp <jens.osterkamp@de.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 21 November 2006 11:29, Arnd Bergmann wrote:
> On Tuesday 21 November 2006 02:35, Benjamin Herrenschmidt wrote:
> > The new IO accessor code allows to stick a token in the top bit of MMIO
> > addresses which gets masked out during actual accesses. However, the
> > __raw_* accessors forgot to mask it out. This fixes it.
>
> Jens, you debugged the problem originally. Does this patch fix it entirely,
> or is there something else missing?

The driver basically works, but I am seeing strange im_free messages,
probably because this code is not aware of the tokens in the ioremapped 
addresses.

<6>ib_mthca: Mellanox InfiniBand HCA driver v0.08 (February 14, 2006)
<6>ib_mthca: Initializing 0002:00:00.0
<3>Trying to im_free nonexistent area (d002080080930000)
<6>ib_mthca: Initializing 0004:00:00.0
<3>Trying to im_free nonexistent area (d003080082a37000)
<4>ib_mthca 0004:00:00.0: HCA FW version 4.6.0 is old (4.7.600 is current).
<4>ib_mthca 0004:00:00.0: If you have problems, try updating your HCA FW.

Jens
