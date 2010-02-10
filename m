Return-Path: <anton@ozlabs.org>
Date: Wed, 10 Feb 2010 22:07:19 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 5/6] powerpc: Fix lwsync patching code on 64bit
Message-ID: <20100210110719.GE3399@kryten>
References: <20100210105728.GA3399@kryten> <20100210110236.GB3399@kryten>
	<20100210110306.GC3399@kryten> <20100210110406.GD3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100210110406.GD3399@kryten>
Cc: npiggin@suse.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


do_lwsync_fixups doesn't work on 64bit, we end up writing lwsyncs to the
wrong addresses:

0:mon> di c0000001000bfacc
c0000001000bfacc  7c2004ac      lwsync

Since the lwsync section has negative offsets we need to use a signed int
pointer so we sign extend the value.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/lib/feature-fixups.c
===================================================================
--- powerpc.git.orig/arch/powerpc/lib/feature-fixups.c	2010-02-10 18:34:32.645573355 +1100
+++ powerpc.git/arch/powerpc/lib/feature-fixups.c	2010-02-10 18:35:18.525571521 +1100
@@ -112,7 +112,7 @@ void do_feature_fixups(unsigned long val
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {
-	unsigned int *start, *end, *dest;
+	int *start, *end, *dest;
 
 	if (!(value & CPU_FTR_LWSYNC))
 		return ;
