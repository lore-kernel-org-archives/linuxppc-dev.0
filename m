Return-Path: <anton@samba.org>
Date: Wed, 12 Jan 2011 16:46:29 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/9] powerpc: Never halt RTAS error logging after receiving
	an unrecoverable machine check
Message-ID: <20110112164629.47585ca9@kryten>
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


Newer versions of the System p firwmare send a partial RTAS error log in the
machine check handler with a more detailed response appearing sometime later
via check event.

This means at machine check time we do not have enough information to
ascertain exactly what went on. Furthermore, I have found the RTAS error
logs in the machine check handler contain no useful information, so halting on
them makes little sense. If we want to halt it would make more sense to do
it following the error log received sometime later via check event.

In light of this, never halt the error log in the pseries machine
check handler.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/pseries/ras.c	2010-09-27 21:19:32.805480948 +1000
+++ powerpc.git/arch/powerpc/platforms/pseries/ras.c	2010-10-15 13:23:34.161268941 +1100
@@ -281,7 +281,7 @@ static int recover_mce(struct pt_regs *r
 		nonfatal = 1;
 	}
 
-	log_error((char *)err, ERR_TYPE_RTAS_LOG, !nonfatal);
+	log_error((char *)err, ERR_TYPE_RTAS_LOG, 0);
 
 	return nonfatal;
 }
