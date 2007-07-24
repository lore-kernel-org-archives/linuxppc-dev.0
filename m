Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 07F1EDDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 09:29:27 +1000 (EST)
Date: Wed, 25 Jul 2007 09:29:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: fix section mismatch warning in lpevents
Message-Id: <20070725092919.7091fa95.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

WARNING: vmlinux.o(.text+0x4f568): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.setup_hvlpevent_queue' and '.process_hvlpevents')

setup_hvlpevent_queue is only called from __init code so make it __init
as well.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/lpevents.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/lpevents.c b/arch/powerpc/platforms/iseries/lpevents.c
index 91df52a..34bdbbe 100644
--- a/arch/powerpc/platforms/iseries/lpevents.c
+++ b/arch/powerpc/platforms/iseries/lpevents.c
@@ -182,7 +182,7 @@ static int set_spread_lpevents(char *str)
 }
 __setup("spread_lpevents=", set_spread_lpevents);
 
-void setup_hvlpevent_queue(void)
+void __init setup_hvlpevent_queue(void)
 {
 	void *eventStack;
 
-- 
1.5.2.4
