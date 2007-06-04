Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F585DDFE0
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 22:43:10 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l54Ch65O039994
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 12:43:06 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l54Ch5vN3207298
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 14:43:05 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l54Ch49d023564
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 14:43:05 +0200
In-Reply-To: <20070531134118.GA30501@infradead.org>
Subject: Re: [PATCH 2/2] ehea: Receive SKB Aggregation
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <OF7723C01B.9DD0E9DC-ONC12572F0.0040CA22-C12572F0.0042AC08@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Mon, 4 Jun 2007 14:09:47 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Thomas Q Klein <tklein@de.ibm.com>, ossthema@linux.vnet.ibm.com,
	Jeff Garzik <jeff@garzik.org>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, tklein@linux.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Christoph Hellwig wrote on 31.05.2007 15:41:18:

> I'm still very unhappy with having all this in various drivers.  There's
> a lot of code that can be turned into generic library functions, and even
> more code that could be made generic with some amount of refactoring.

Yes, we'd also prefer to use a generic function, but we first would want to
get
some "real world" experience how our driver behaves with LRO to be even
able to
define requirements for such a generic function. A lot of this is tied into
pathlengths,
caching, and why does that help compared to a different TCP receive side
processing?
In a perfect world we shouldn't see a diffference if this is enabled or
not,
but measurements indicate something completely different at 10gbit.

Gruss / Regards
Christoph Raisch
