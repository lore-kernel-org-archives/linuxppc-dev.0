Return-Path: <cornelia.huck@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 88AB7DDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 19:26:08 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l6J9Q2v7288678
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 09:26:02 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6J9Q24M2953426
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 10:26:02 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6J9Pj1P002042
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 10:25:46 +0100
Date: Thu, 19 Jul 2007 11:26:02 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 1/3] ps3: Disk Storage Driver
Message-ID: <20070719112602.5e3cb21a@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.62.0707191039430.8661@pademelon.sonytel.be>
References: <20070716161539.075822000@pademelon.sonytel.be>
	<20070716162206.392129000@pademelon.sonytel.be>
	<20070718163637.3f0e0164.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707191039430.8661@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>,
	linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@vision.unipv.it>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 19 Jul 2007 10:57:53 +0200 (CEST),
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> Were .probe()/.remove() made concurrent again? I thought that idea was dropped
> because it caused too many problems?

Well, for a given device, ->probe()/->remove() are locked by dev->sem,
so that there cannot be two probes/removes for the same device at the
same time. However, if you have multiple hotplug events pending at the
same time, it depends on your bus whether it does some serialization or
whether it allows multiple probes/removes running for different devices.
(Initial probing of a bus and probing of all devices with a new driver
is done serialized again, I think that's what you're referring to.)
