Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 924E5DFAB2
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:28:23 +1000 (EST)
Date: Wed, 5 Sep 2007 14:28:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 6/9] 8xx: Set initial memory limit.
Message-ID: <20070905192815.GE32398@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: John Traill <john.traill@freescale.com>

The 8xx can only support a max of 8M during early boot (it seems a lot of
8xx boards only have 8M so the bug was never triggered), but the early
allocator isn't aware of this.  The following change makes it able to run
with larger memory.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/mm/init_32.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index d65995a..e09513a 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -132,6 +132,9 @@ void __init MMU_init(void)
 	/* 601 can only access 16MB at the moment */
 	if (PVR_VER(mfspr(SPRN_PVR)) == 1)
 		__initial_memory_limit = 0x01000000;
+	/* 8xx can only access 8MB at the moment */
+	if (PVR_VER(mfspr(SPRN_PVR)) == 0x50)
+		__initial_memory_limit = 0x00800000;
 
 	/* parse args from command line */
 	MMU_setup();
-- 
1.5.3
