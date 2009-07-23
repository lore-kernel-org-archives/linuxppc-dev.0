Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7973C1054FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 16:02:30 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C226BDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 16:02:29 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n6N62JLj002677
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 01:02:20 -0500
Subject: [PATCH 0/20] powerpc: base 64-bit Book3E processor support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 23 Jul 2009 16:02:18 +1000
Message-Id: <1248328938.3367.46.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is a series of patches that implement some basic support
for 64-bit Book3E processors that comply to architecture 2.06.

There is no specific processor announced yet. The patches make
some shortcut which means they currently rely on an implementation
that supports MMU v2 with support for the "HES" feature (HW entry
select) and with support for the "TLB reservation" feature. They
also assume a single unified TLB array. I shouldn't be very hard
to implement support for other variants of the architecture on
top of this though.

The current set of patch has no proper support yet for hugetlb,
nor for "special" interrupt levels (debug, critical and machine
check). Some minimal support for debug/critical levels is provided
specifically for the "Debug" interrupt (single step etc...) only
when it occurs from within user space code. 

The intend is to merge these in 2.6.32. They rely on pretty much
all the other patches I've been posting lately including the
generic changes to add the virtual address argument to pte_free_tlb.
