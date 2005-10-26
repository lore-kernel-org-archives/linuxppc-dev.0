Return-Path: <galak@freescale.com>
Date: Wed, 26 Oct 2005 09:55:41 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510260955150.6094@linen.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: Fix warning related to do_dabr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

do_dabr() is not relevant on 40x or Book-E processors so dont build it

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit 76b3884004db7ea66b3ef801dd0fa1e2337025a8
tree e60f8a2af4bc06303ca3a81d28831fb6ae0a0097
parent e19eaf379ab1a633eea2d5ff0e0d99ca834324f1
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 26 Oct 2005 09:39:58 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 26 Oct 2005 09:39:58 -0500

 arch/powerpc/mm/fault.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -80,6 +80,7 @@ static int store_updates_sp(struct pt_re
 	return 0;
 }
 
+#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 static void do_dabr(struct pt_regs *regs, unsigned long error_code)
 {
 	siginfo_t info;
@@ -101,6 +102,7 @@ static void do_dabr(struct pt_regs *regs
 	info.si_addr = (void __user *)regs->nip;
 	force_sig_info(SIGTRAP, &info, current);
 }
+#endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
 
 /*
  * For 600- and 800-family processors, the error_code parameter is DSISR
