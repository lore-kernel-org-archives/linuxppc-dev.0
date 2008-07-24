Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13FC6DE1E4
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 05:19:16 +1000 (EST)
Received: from mailgate01.slac.stanford.edu (mailgate01.slac.stanford.edu
	[134.79.18.80])
	by nospam3.slac.stanford.edu (8.13.8/8.13.8) with ESMTP id
	m6OJJEcI017603
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 12:19:14 -0700 (PDT)
	(envelope-from rmachet@slac.stanford.edu)
Received: from pcds-ts102.slac.stanford.edu (pcds-ts102.slac.stanford.edu
	[134.79.128.151])
	by mailgate01.slac.stanford.edu (8.13.8/8.13.8) with ESMTP id
	m6OJJDxP000431
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 12:19:13 -0700 (PDT)
	(envelope-from rmachet@slac.stanford.edu)
Subject: Hard-coded virtual address used by dma_alloc_coherent
From: Remi Machet <rmachet@slac.stanford.edu>
To: Linux PPC <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 24 Jul 2008 12:19:11 -0700
Message-Id: <1216927153.19203.62.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I have noticed that the DMA allocation for non-coherent PowerPC
architecture is using a hard coded virtual memory address for its memory
pool. This address is typically 0xFF100000 (set by
CONFIG_CONSISTENT_START) and can conflict with early ioremap in systems
that enable HIGHMEM.

Is there any reason why we have to use an arbitrary virtual address ? If
the virtual address must be known at compile time, can't we use fixmap ?

I also can't figure out why we need to use a virtual address known at
compilation time and cannot just allocate pages using get_free_pages and
mark them as non cacheable and non swappable.

For those of you that want to check it out, the code is in
arch/powerpc/lib/dma-noncoherent.c

Thanks,

Remi
