Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1884D1A0886
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 14:37:29 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 572B9140139
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Aug 2014 14:37:28 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s7B4bNTS013225
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Aug 2014 23:37:24 -0500
Message-ID: <1407731842.4508.70.camel@pasglop>
Subject: [PATCH] powerpc/boot: Use correct zlib types for comparison
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Mon, 11 Aug 2014 14:37:22 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avoids this warning:

arch/powerpc/boot/gunzip_util.c:118:9: warning: comparison of distinct pointer types lacks a cast

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/boot/gunzip_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/gunzip_util.c b/arch/powerpc/boot/gunzip_util.c
index ef2aed0..9dc5250 100644
--- a/arch/powerpc/boot/gunzip_util.c
+++ b/arch/powerpc/boot/gunzip_util.c
@@ -112,10 +112,10 @@ int gunzip_partial(struct gunzip_state *state, void *dst, int dstlen)
 		r = zlib_inflate(&state->s, Z_FULL_FLUSH);
 		if (r != Z_OK && r != Z_STREAM_END)
 			fatal("inflate returned %d msg: %s\n\r", r, state->s.msg);
-		len = state->s.next_out - (unsigned char *)dst;
+		len = state->s.next_out - (Byte *)dst;
 	} else {
 		/* uncompressed image */
-		len = min(state->s.avail_in, (unsigned)dstlen);
+		len = min(state->s.avail_in, (uLong)dstlen);
 		memcpy(dst, state->s.next_in, len);
 		state->s.next_in += len;
 		state->s.avail_in -= len;
