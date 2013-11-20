Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 Ulrich.Weigand@de.ibm.com, alistair@popple.id.au
Subject: [PATCH 4/9] powerpc: Set eflags correctly for ELF ABIv2 core dumps.
Date: Wed, 20 Nov 2013 22:15:01 +1100
Message-Id: <1384946106-18200-5-git-send-email-anton@samba.org>
In-Reply-To: <1384946106-18200-1-git-send-email-anton@samba.org>
References: <1384946106-18200-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rusty Russell <rusty@rustcorp.com.au>

We leave it at zero (though it could be 1) for old tasks.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 6d0e236..935b5e7 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -31,6 +31,8 @@
 extern unsigned long randomize_et_dyn(unsigned long base);
 #define ELF_ET_DYN_BASE		(randomize_et_dyn(0x20000000))
 
+#define ELF_CORE_EFLAGS (is_elf2_task() ? 2 : 0)
+
 /*
  * Our registers are always unsigned longs, whether we're a 32 bit
  * process or 64 bit, on either a 64 bit or 32 bit kernel.
-- 
1.8.3.2
