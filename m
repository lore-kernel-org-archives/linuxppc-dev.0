Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17671.23111.41138.571176@cargo.ozlabs.ibm.com>
Date: Wed, 13 Sep 2006 11:09:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: Perhaps git-update-server-info needs to be run on
	.../paulus/powerpc.git?
In-Reply-To: <20060911150549.0e08bbcd.kim.phillips@freescale.com>
References: <20060808193555.301bc229.kim.phillips@freescale.com>
	<17625.18896.977702.640753@cargo.ozlabs.ibm.com>
	<17669.7544.599959.442534@cargo.ozlabs.ibm.com>
	<20060911150549.0e08bbcd.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kim Phillips writes:

> funnily enough, I can't seem to clone your tree again today; I'm
> using the http: protocol.
> 
> hopefully, the fix should only be a matter of:
> 
> chmod +x hooks/post-update

Nope.  This patch (to git) from Junio Hamano seems to fix it, though.

Paul.

diff --git a/http-fetch.c b/http-fetch.c
index fac1760..d870390 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -559,7 +559,13 @@ static void process_alternates_response(
 			char *target = NULL;
 			char *path;
 			if (data[i] == '/') {
-				serverlen = strchr(base + 8, '/') - base;
+				/* This counts
+				 * http://git.host/pub/scm/linux.git
+				 * 1234567----here^
+				 * so strcpy(dst, base, serverlen) will
+				 * copy up to "...git.host/"
+				 */
+				serverlen = strchr(base + 7, '/') - base;
 				okay = 1;
 			} else if (!memcmp(data + i, "../", 3)) {
 				i += 3;
@@ -586,7 +592,7 @@ static void process_alternates_response(
 			/* skip 'objects' at end */
 			if (okay) {
 				target = xmalloc(serverlen + posn - i - 6);
-				strlcpy(target, base, serverlen);
+				memcpy(target, base, serverlen);
 				strlcpy(target + serverlen, data + i, posn - i - 6);
 				if (get_verbosely)
 					fprintf(stderr,
