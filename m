Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6977CDE032
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 16:00:27 +1000 (EST)
Date: Fri, 12 Oct 2007 07:00:19 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] missed bio_endio() in axonram
Message-ID: <20071012060019.GY8181@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: axboe@kernel.dk, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index ab037a3..46fd9c6 100644
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
