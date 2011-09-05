Return-Path: <B13201@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93307B7283
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Sep 2011 20:05:45 +1000 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 3/3] math_emu/efp: Look for errata handler when type mismatches
Date: Mon, 5 Sep 2011 17:01:23 +0800
Message-ID: <1315213283-3800-4-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1315213283-3800-3-git-send-email-yu.liu@freescale.com>
References: <1315213283-3800-1-git-send-email-yu.liu@freescale.com>
	<1315213283-3800-2-git-send-email-yu.liu@freescale.com>
	<1315213283-3800-3-git-send-email-yu.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Liu Yu <yu.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We already have cpu a005 errata handler when instruction cannot be recgnized.
Before we lookup the inst, there's type checking, and we also need to
handle it in errata handler when the type checking failed.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
 arch/powerpc/math-emu/math_efp.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/math_efp.c
index 96dbbae..707da4c 100644
--- a/arch/powerpc/math-emu/math_efp.c
+++ b/arch/powerpc/math-emu/math_efp.c
@@ -173,8 +173,7 @@ static unsigned long insn_type(unsigned long speinsn)
 	case EFDSUB:	ret = AB;	break;
 
 	default:
-		printk(KERN_ERR "\nOoops! SPE instruction no type found.");
-		printk(KERN_ERR "\ninst code: %08lx\n", speinsn);
+		break;
 	}
 
 	return ret;
@@ -195,7 +194,7 @@ int do_spe_mathemu(struct pt_regs *regs)
 
 	type = insn_type(speinsn);
 	if (type == NOTYPE)
-		return -ENOSYS;
+		goto illegal;
 
 	func = speinsn & 0x7ff;
 	fc = (speinsn >> 21) & 0x1f;
-- 
1.6.4
