Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (unknown [71.74.56.123])
	by ozlabs.org (Postfix) with ESMTP id 4CA4EB70E4
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 01:12:58 +1000 (EST)
Received: from crust.elkhashab.com (localhost [127.0.0.1])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	o8NFCkEx017185
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 10:12:46 -0500
Received: (from ayman@localhost)
	by crust.elkhashab.com (8.14.3/8.14.3/Submit) id o8NFCk9S017184
	for linuxppc-dev@ozlabs.org; Thu, 23 Sep 2010 10:12:46 -0500
Date: Thu, 23 Sep 2010 10:12:46 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: linuxppc-dev@ozlabs.org
Subject: ppc44x - how do i optimize driver for tlb hits
Message-ID: <20100923151246.GA17015@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've implemented a working driver on my 460EX.  it allocates a couple
of buffers of 4MB each.  I have a custom memcmp algorithm in asm that
is extremely fast in user space, but 1/2 as fast when run on these
buffers.

my tests are showing that the algorithm seems to be memory bandwidth
bound.  my guess is that i am having tlb or cache misses (my algo
uses the dbct) that is slowing performance.  curiously when in user
space, i can affect the performance by small changes in the size of
the buffer, i.e. 4MB + 32B is fast, 4MB + 4K is much worse.

Can i adjust my driver code that is using kmalloc to make sure that
the ppc44x has 4MB tlb entries for these and that they stay put?

thanks
ayman
