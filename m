Return-Path: <cornelia.huck@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C27C8DDDF2
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 06:32:15 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l08JW5iR026700
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jan 2007 19:32:05 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id l08JW5WY3215554
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jan 2007 20:32:05 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l08JW4jX003856
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jan 2007 20:32:04 +0100
Date: Mon, 8 Jan 2007 20:32:58 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.20-rc3-mm1
Message-ID: <20070108203258.751aa353@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <1168032284.22458.33.camel@localhost.localdomain>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
	<200701051723.08112.m.kozlowski@tuxland.pl>
	<1168030536.22458.28.camel@localhost.localdomain>
	<20070105131516.bd9d8f45.akpm@osdl.org>
	<1168032284.22458.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 06 Jan 2007 08:24:44 +1100,
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/broken-out/driver-core-per-subsystem-multithreaded-probing.patch
> 
> Hrm. I disagree with this change. I have a few cases where drivers
> actually want to explicitely do that. I suppose they can always fire off
> a thread themselves from probe() but I don't see the reason to move it
> to the bus type...

The idea behind this is to have a probing thread for each device that
does the actual work (call probe for the matching drivers) so that
multiple devices can be probed in parallel. The decision to do this can
only be made at the bus level.

Previously, the code made it possible to have a probing thread for each
matching driver for the same device in parallel. I didn't see any
benefit in that, but maybe I'm just dense...

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
