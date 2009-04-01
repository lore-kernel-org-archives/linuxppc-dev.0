Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 54F4DDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 16:38:10 +1100 (EST)
Subject: Broken CONFIG_HIGHPTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Content-Type: text/plain
Date: Wed, 01 Apr 2009 16:38:00 +1100
Message-Id: <1238564280.17330.119.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

Just noticed... And I'll be travelling for a while so with no much
time to look at it.

Your changes to use the PTE page free batch via RCU on ppc32 broke
CONFIG_HIGHPTE for hash32...

You rely on passing a page_address() of the PTE page down to the
freeing layer. That doesn't work for highmem pages. That needs to
be changes to a struct page * on 32-bit (not on 64-bit where we
are using slabs though)

Cheers,
Ben.
