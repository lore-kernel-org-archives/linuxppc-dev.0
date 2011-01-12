Return-Path: <anton@samba.org>
Date: Wed, 12 Jan 2011 16:51:31 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 8/9] powerpc: Check RTAS extended log flag before checking
	length
Message-ID: <20110112165131.21910131@kryten>
In-Reply-To: <20110112164318.753a435b@kryten>
References: <20110112164318.753a435b@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The spec suggests we should first check the extended log flag before checking
the length field. 

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/rtasd.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/rtasd.c	2010-09-27 21:19:32.405475768 +1000
+++ powerpc.git/arch/powerpc/kernel/rtasd.c	2010-10-15 13:23:42.321361102 +1100
@@ -160,7 +160,7 @@ static int log_rtas_len(char * buf)
 	/* rtas fixed header */
 	len = 8;
 	err = (struct rtas_error_log *)buf;
-	if (err->extended_log_length) {
+	if (err->extended && err->extended_log_length) {
 
 		/* extended header */
 		len += err->extended_log_length;
