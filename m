Return-Path: <eha@doredevelopment.dk>
Received: from bq8.dotserv.com (bq8.dotserv.com [193.201.35.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCB77DDED7
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 17:24:12 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] cpm: rounding of brg clockdivider
MIME-Version: 1.0
Date: Tue, 2 Oct 2007 09:24:03 +0200
From: Esben Haabendal <eha@doredevelopment.dk>
Message-ID: <9edac4e26b9461b125012c7e025c847f@127.0.0.1>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Do rounding of brg clockdivider instead of truncate to get more precise baudrates

Something similar might be needed for cpm_fastbrg...

---
commit 52d631eb8f64cef794d6aa66494e253cf268894e
tree 956149a0eb5beb9afb280f4593615929eab7b779
parent 300070dd6b5e71af0c6fbecd32388905dbdd3ea5
author Esben Haabendal <eha@doredevelopment.dk> Wed, 19 Sep 2007 13:18:59 +0200
committer Esben Haabendal <esben@esben.doredevelopment.dk> Wed, 19 Sep 2007 13:18:59 +0200

 arch/powerpc/sysdev/cpm2_common.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 9058da2..a2c8157 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -102,7 +102,9 @@ cpm_setbrg(uint brg, uint rate)
                brg -= 4;
        }
        bp += brg;
-       out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
+       /* Set the BRG clock divider to get the best match to the requested
+        * baudrate (rounding required) */
+       out_be32(bp, ((((((BRG_UART_CLK*2)/rate)+1)/2)-1) << 1) | CPM_BRG_EN);
 
        cpm2_unmap(bp);
 }




!-------------------------------------------------------------flip-

-- 
Esben Haabendal
Embedded Software Consultant
Doré Development ApS
