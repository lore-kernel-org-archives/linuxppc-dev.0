Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcW1YYkzF1P2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:07 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id t3so13276757wmc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:07 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 11/21] powerpc: Add missing prototype for hdec_interrupt
Date: Sun, 25 Feb 2018 18:22:26 +0100
Message-Id: <20180225172236.29650-12-malat@debian.org>
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit dabe859ec636 ("powerpc: Give hypervisor decrementer interrupts
their own handler") an empty body function was added, but no prototype was
declared. Fix warning (treated as error in W=1):

  CC      arch/powerpc/kernel/time.o
arch/powerpc/kernel/time.c:629:6: error: no previous prototype for ‘hdec_interrupt’ [-Werror=missing-prototypes]
 void hdec_interrupt(struct pt_regs *regs)
      ^~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/time.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index b240666b7bc1..a7a8a9ac5991 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -31,6 +31,7 @@ extern void to_tm(int tim, struct rtc_time * tm);
 extern void tick_broadcast_ipi_handler(void);
 
 extern void generic_calibrate_decr(void);
+extern void hdec_interrupt(struct pt_regs *regs);
 
 /* Some sane defaults: 125 MHz timebase, 1GHz processor */
 extern unsigned long ppc_proc_freq;
-- 
2.11.0
