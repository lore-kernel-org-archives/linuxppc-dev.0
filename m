Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1F3C9DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 16:03:53 +1000 (EST)
Date: Fri, 12 Oct 2007 16:03:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix axonram bio_io_error and bio_endio calls
Message-Id: <20071012160348.87b50734.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Maxim Shchetynin <maxim@de.ibm.com>, Bergmann <arnd.bergmann@de.ibm.com>,
	Neil Brown <neilb@suse.de>, Jens, Axboe <jens.axboe@oracle.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Arnd
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 6712ecf8f648118c3363c142196418f89a510b90 (Drop 'size' argument
from bio_endio and bi_end_io) dropped the second argument.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/sysdev/axonram.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

I am not sure if this is all that is required, but it does build.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index 4d3ba63..5eaf3e3 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -117,7 +117,7 @@ axon_ram_make_request(struct request_queue *queue, struct bio *bio)
 	transfered = 0;
 	bio_for_each_segment(vec, bio, idx) {
 		if (unlikely(phys_mem + vec->bv_len > phys_end)) {
-			bio_io_error(bio, bio->bi_size);
+			bio_io_error(bio);
 			rc = -ERANGE;
 			break;
 		}
@@ -131,7 +131,7 @@ axon_ram_make_request(struct request_queue *queue, struct bio *bio)
 		phys_mem += vec->bv_len;
 		transfered += vec->bv_len;
 	}
-	bio_endio(bio, transfered, 0);
+	bio_endio(bio, 0);
 
 	return rc;
 }
-- 
1.5.3.4
