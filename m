Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A7130B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 19:15:16 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Jul 2009 19:15:02 +1000
Subject: [PATCH 0/20] powerpc: base 64-bit Book3E processor support (v2)
Message-Id: <1248426902.401617.944220131651.qpush@grosgo>
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

v2. Various fixes, some addressing comments recieved and a whole
bunch fixing other issues including breakage of existing platforms
