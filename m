Return-Path: <anton@ozlabs.org>
Date: Sun, 11 Jun 2006 01:01:45 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Link error when futexes are disabled on 64bit architectures
Message-ID: <20060610150145.GU23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


If futexes are disabled we fail to link on ppc64.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: kernel/kernel/exit.c
===================================================================
--- kernel.orig/kernel/exit.c	2006-04-16 20:50:51.000000000 -0500
+++ kernel/kernel/exit.c	2006-04-16 21:05:32.570315496 -0500
@@ -906,7 +906,7 @@ fastcall NORET_TYPE void do_exit(long co
 	}
 	if (unlikely(tsk->robust_list))
 		exit_robust_list(tsk);
-#ifdef CONFIG_COMPAT
+#if defined(CONFIG_FUTEX) && defined(CONFIG_COMPAT)
 	if (unlikely(tsk->compat_robust_list))
 		compat_exit_robust_list(tsk);
 #endif
