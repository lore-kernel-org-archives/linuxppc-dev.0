Return-Path: <FENKES@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 72A8FDDE42
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Sep 2007 03:47:06 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7VHl1uh118298
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 17:47:01 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7VHl1tU2306258
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 19:47:01 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7VHl0S5018645
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 19:47:00 +0200
In-Reply-To: <200708311908.05255.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.23] ibmebus: Prevent bus_id collisions
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF9A956FFB.6A9B925D-ONC1257348.006146CE-C1257348.0061ACF6@de.ibm.com>
Date: Fri, 31 Aug 2007 19:46:58 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: Thomas Q Klein <tklein@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > The plaintiff makes a valid point. How about a staging approach: We 
put 
> > the patch as it is now into 2.6.23 so the problem is fixed, and I'll 
post 
> > a "nice" version with autoloading support and a generic of_make_bus_id 

> > function for 2.6.24. Agree?
> 
> Ok, sounds fair. Can you make sure that the resulting bus_id is the same
> for the final version then?

No, it would change once more -- the current, minimal-invasive, variant of 
the fix uses the full_name -> "ehca@12345678", while of_make_bus_id uses 
another format: "12345678.ehca". I don't think this makes much of a 
difference, though, and users shouldn't rely on the bus_id having a 
certain format anyway, so IMHO we can live with this.

Regards,
  Joachim
