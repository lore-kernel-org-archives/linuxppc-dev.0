Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 92977DDE11
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 17:44:02 +1100 (EST)
Date: Mon, 19 Nov 2007 17:44:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] 2.6.24-rc2-mm1 powerpc (iseries)- build failure - mm/stab.c
Message-Id: <20071119174405.7ae746f1.sfr@canb.auug.org.au>
In-Reply-To: <20071119062611.GA11135@linux.vnet.ibm.com>
References: <20071114105410.GA16846@linux.vnet.ibm.com>
	<20071119133849.bcfe52c1.sfr@canb.auug.org.au>
	<20071119062611.GA11135@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, anton@au1.ibm.com,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

The kernel builds fails with following error, with randconfig

  CC      arch/powerpc/mm/stab.o
arch/powerpc/mm/stab.c: In function ‘stab_initialize’:
arch/powerpc/mm/stab.c:282: error: implicit declaration of function ‘HvCall1’
arch/powerpc/mm/stab.c:282: error: ‘HvCallBaseSetASR’ undeclared (first use in this function)
arch/powerpc/mm/stab.c:282: error: (Each undeclared identifier is reported only once
arch/powerpc/mm/stab.c:282: error: for each function it appears in.)
make[1]: *** [arch/powerpc/mm/stab.o] Error 1
make: *** [arch/powerpc/mm] Error 2

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/stab.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

On Mon, 19 Nov 2007 11:56:11 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
>
> Resubmitting the patch titled 
> powerpc-iseries-build-failure-mm-stabc.patch in the -mm tree.

Paulus, this should be fine for merging like above.

Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/stab.c b/arch/powerpc/mm/stab.c
index 9e85bda..50448d5 100644
--- a/arch/powerpc/mm/stab.c
+++ b/arch/powerpc/mm/stab.c
@@ -20,6 +20,7 @@
 #include <asm/lmb.h>
 #include <asm/abs_addr.h>
 #include <asm/firmware.h>
+#include <asm/iseries/hv_call.h>
 
 struct stab_entry {
 	unsigned long esid_data;
-- 
1.5.3.5
