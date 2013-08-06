Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 30/63] powerpc: Emulate instructions in little endian mode
Date: Wed,  7 Aug 2013 02:01:47 +1000
Message-Id: <1375804940-22050-31-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alistair noticed we got a SIGILL on userspace mfpvr instructions.

Remove the little endian check in the emulation code, it is
probably there to protect against the old pseudo little endian
implementations but doesn't make sense for real little endian.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bf33c22..e601220 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -964,7 +964,7 @@ static int emulate_instruction(struct pt_regs *regs)
 	u32 instword;
 	u32 rd;
 
-	if (!user_mode(regs) || (regs->msr & MSR_LE))
+	if (!user_mode(regs))
 		return -EINVAL;
 	CHECK_FULL_REGS(regs);
 
-- 
1.8.1.2
