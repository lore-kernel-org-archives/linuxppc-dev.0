Return-Path: <fenkes@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59B91DDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 04:27:36 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6BIRVPJ130606
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 18:27:31 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l6BIRVqR1208538
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 20:27:31 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6BIRVNY014931
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 20:27:31 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jim.houston@ccur.com
Subject: DEFINE_IDR() and the layer cache
Date: Wed, 11 Jul 2007 20:27:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707112027.30490.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

while the idr discussion is still hot, there's another thing that caught my
eye recently:

As to my reading of idr.h, I have two choices of initializing a global idr:
 a) static struct idr foo; /* ... */ idr_init(&foo);
 b) static DEFINE_IDR(foo);

idr_init(), when called for the first time, sets up the layer
cache. idr_get_new() and friends expect the cache to exist. Now, what happens
if the first call to idr_get_new() targets an idr initialized using
DEFINE_IDR() before idr_init() has been called at least once? Could this
happen?

My $0.02,
  Joachim
