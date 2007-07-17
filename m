Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22D0FDDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 11:17:27 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] POWERPC 8xx: bump up initial memory limit for 8xx
Date: Tue, 17 Jul 2007 05:17:23 +0400
Message-ID: <20070717011723.23549.44672.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: John Traill <john.traill@freescale.com>

The 8xx can only support a max of 8M during early boot ( it seems a lot of
8xx boards only have 8M so the bug was never triggered ). The following
change makes it able to run with 128M.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 arch/powerpc/mm/init_32.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index e1f5ded..7cee86d 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -133,6 +133,9 @@ void __init MMU_init(void)
 	/* 601 can only access 16MB at the moment */
 	if (PVR_VER(mfspr(SPRN_PVR)) == 1)
 		__initial_memory_limit = 0x01000000;
+	/* 852 can only access 8MB at the moment */
+	if (PVR_VER(mfspr(SPRN_PVR)) == 0x50)
+		__initial_memory_limit = 0x00800000;
 
 	/* parse args from command line */
 	MMU_setup();
