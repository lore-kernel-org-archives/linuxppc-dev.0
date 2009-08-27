Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A69D1B7B81
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 17:21:25 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04C0DDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 17:21:24 +1000 (EST)
Subject: [PATCH] lmb: Remove __init from lmb_end_of_DRAM()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 17:20:30 +1000
Message-Id: <1251357630.20467.42.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We call lmb_end_of_DRAM() to test whether a DMA mask
is ok on a machine without IOMMU, but this function is
marked as __init.

I don't think there's a clean way to get the top of RAM
max_pfn doesn't appear to include highmem or I missed
(or we have a bug :-) so for now, let's just avoid having
a broken 2.6.31 by making this function non-__init and we
can revisit later.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

David, you use lmb too, any objection there ?

diff --git a/lib/lmb.c b/lib/lmb.c
index e4a6482..0343c05 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -429,7 +429,7 @@ u64 __init lmb_phys_mem_size(void)
 	return lmb.memory.size;
 }
 
-u64 __init lmb_end_of_DRAM(void)
+u64 lmb_end_of_DRAM(void)
 {
 	int idx = lmb.memory.cnt - 1;
 
