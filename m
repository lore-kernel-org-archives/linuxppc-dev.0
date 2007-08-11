Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C34E4DDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 19:46:27 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7B9kMt0108708
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 09:46:22 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l7B9kMZ72252976
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 11:46:22 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7B9kIKf003850
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 11:46:19 +0200
Subject: Re: 2.6.23-rc2-mm2 build error on MIPS and ARM
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
In-Reply-To: <20070811025802.GA15885@Krystal>
References: <20070811025802.GA15885@Krystal>
Content-Type: text/plain
Date: Sat, 11 Aug 2007 11:50:00 +0200
Message-Id: <1186825800.32314.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Reply-To: schwidefsky@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-08-10 at 22:58 -0400, Mathieu Desnoyers wrote:
> I got the following errors when building 2.6.23-rc2-mm2 on both mips and
> arm. Both errors are very much alike.

That attached patch should fix it for arm and mips. I'll try a few more
architectures until I'm fed up with compiling cross-compilers..

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
---
Subject: [PATCH] move mm_struct and vm_area_struct, compile fix.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Include <asm/page.h> in <linux/mm_types.h> to make mips and arm
compile again after mm_struct and vm_area_struct have been moved.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/mm_types.h |    1 +
 1 file changed, 1 insertion(+)

diff -urpN linux-2.6/include/linux/mm_types.h
linux-2.6-patched/include/linux/mm_types.h
--- linux-2.6/include/linux/mm_types.h	2007-08-11 11:30:10.000000000
+0200
+++ linux-2.6-patched/include/linux/mm_types.h	2007-08-11
11:32:42.000000000 +0200
@@ -11,6 +11,7 @@
 #include <linux/rwsem.h>
 #include <linux/completion.h>
 #include <asm/mmu.h>
+#include <asm/page.h>
 
 struct address_space;
 
