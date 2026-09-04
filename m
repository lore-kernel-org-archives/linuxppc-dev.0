Return-Path: <linuxppc-dev+bounces-26583-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10F5C624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:06:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNBH2T39z2xlJ;
	Sat, 05 Sep 2026 16:06:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788512954;
	cv=none; b=mFiq7zo7bnDuJI5PykvKw3wZYoc/dr0kB1QdAD6AqZiIVzQhVmWDqTL9XrdM4ONjeZE3TJFI0Gt/n16caP7Q9n2R+vCwl/KZI7PVblVIIf3m7Jpa7xZkP+PYpLKKY9mj4y/JNGFrpok+Ji+J4gSU32BxOieILcqK+zQNi+qGp/lqg9GVPikgURAF3hGm7TDVFpbIq7mdJkxa0I9Gh14zlKZnqPnkTbMoE3uIYrnLFdq66BulbUyEnJrpXbcu05wKSZFlZEX5QSyahZRoJ33ZVGGiBQ/3RmADkcnIf9h49knhykBLrvwaSxPCBjI+DWR5qv0Gs5xIrntjW2CysDK5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788512954; c=relaxed/relaxed;
	bh=jeSwwPU8HH7uQiH/u+hsVibbM0HgI3yvXFGeul75aVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcCR+KZuQXGALc2/Oicrv/fPZL7SQnKVm72nwdpJXOY8ZK/aivQHT0du7O8G+VWzVJpHhq2N+GHUUEm5zinKU40khDNcw3Vw4vMl3Wr3sOh+eROdiQILk4+Z0O1uhNrpbLPrgMSVkg9RoO4hePQope5zwklrNV4DYAJKJC0xE9/OOZl4Ah3R8wU21fJd+Nqa/eYFWWkTJz0WssfEJI5juT3OMzHmv+eKcDFxB2mwH56lPsxZ4f4x1K7+qb6SG0JD2HxSJd25nrih/IOmF73NDHBfDQhkJ5/iPRnS6ODln21VHh5OXmeyusFcpPOyOH5Z3NzsXBCp7mXadcYLrN8NEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e5oSCX5Q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e5oSCX5Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbrHr6wlSz2xZV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 19:09:11 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2d94c868ea5so8180155ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788512949; x=1789117749; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jeSwwPU8HH7uQiH/u+hsVibbM0HgI3yvXFGeul75aVU=;
        b=e5oSCX5Qc/gXrM9e4mjOXV/LIPTVglcOYEH0eIV/OO08Dubdc3iX5jDy3MaqNquf+W
         TWpYYjxCgb3oWE1k09JrbktMH7aEEEDAzGUvF1YaiZIwf6EEffR4TjJo5myIO8tySPB3
         8Gt23QbdWXvTpBGeMAYKvA9YPKnpY3e5mEBY2XzMT3GaqmJ341ZbdU0ONyiJYYZDEc7h
         QJzj3bE2je+pXIKQ7RPXDp2cczJ2f+qjKQTAMkJ1Dx+UBnAeAs6+GY3/e9HV/apxZJMM
         wu3bo8My62A/WrEMB8ZShRCW1WiXdsvILV4Qc3I7lMuaqrGLHlBicoVs4aHkkp4BIeGn
         LzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512949; x=1789117749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jeSwwPU8HH7uQiH/u+hsVibbM0HgI3yvXFGeul75aVU=;
        b=nnoL9lQcZkbkWqxq07JqEcCoc+0TeMX3qdUZE1fAu/J5FGH04CSjHeBpD9sNzWR0/E
         qr6tsHytQhmcyYrGc4aa91vJPuSDp53a2q18x6SP3pKcsesr2HiZg+/eEk1Y2vPCD8cA
         tvo1GHn6yjcSGQGNL26Z4b33G5zfyDiBvQS4f72GBqL0HpibYGtITzTKeEUKOdJvJzTH
         mUbq3uVuqsQ47cidVWujJGDGJPpzatTFNXBjf5BrSKu5e6c1yS+SZlfOVJK/TBfvb6sX
         eiwWNFdYZNC5gXYvhkUe4pmS4JcDulvBbs1Y2vW5RXpzT+PhO+8szJfE6VZgngE/htiW
         eN4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzzzo3eyGhCu1w/Rn3yc2dtss8ndoGL/6CIgGeMpz8tXAjV200iWD5VINA1FACRJ4Y3AdNY++6djMe+IF8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n67brUjiDJu+aM4Z69negOAqQ1EH09Rbn4o9j0kEubmRW5Q4go
	LUHsd2ux2qyz9m+3izrBZ71QNtzEmbnygBijEsHi4zZHwJzTumvgdoyC
X-Gm-Gg: AYBFou0kE//LOenZPzudbSs9SOwLzndkLJ0WL5fQSJgXXubhbZucBWgSIF3HlTedzot
	ngRaF/OTaON2BvUwlkEaURYVXUltxEGCsJR7O/2t/qIEvO0QLCXCXIsiBUb2BL0GAjHowBRh4IR
	B9qey8nBj7kRW7Q8pe2/M1sHqFdymYEMNsAmRZJwCib+moEWd72cyP/Lkl9xgajkEF+IOaI51Da
	5RdswVkWWdZfnlE7qYlbQEil4Be0mxw4RIrKzse4HFL4iCQwYNuAPEUwy2z5EwczDktfdTxmdct
	+n3e47eOPY+QL/7ye34xYmtVTr6tduOKl1NzRT+yxR1lOQwI+/4eVRVAHBilBrytVxpaIsNQmb1
	fEOdSlxEYvBamnchY5cryKes/gztoM9zamKP1KcFNdAZ8VueLNirDXlrWFCte9taNdekJuLWeMt
	wr0ht/STOK3gKB8b661Zoc6siYFzEUhY++jnvaLUiGreQR61JFtn2lyNpUkOVS9gmTmo283Dg2T
	gsWB8GVaCTOtNSSr5mu9VPv+F6M3FmlMySQ
X-Received: by 2002:a17:902:d492:b0:2d9:68b7:c324 with SMTP id d9443c01a7336-2db125cce1bmr63911345ad.3.1788512948933;
        Fri, 04 Sep 2026 02:09:08 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.52.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db18a1eb47sm5254225ad.48.2026.09.04.02.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:09:08 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	sshegde@linux.ibm.com,
	mkchauras@gmail.com,
	mchauras@linux.ibm.com,
	ritesh.list@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH V3] powerpc/entry: Fix irq_soft_mask corruption on replayed interrupt exit
Date: Fri,  4 Sep 2026 14:38:58 +0530
Message-ID: <20260904090858.128563-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When __replay_soft_interrupts() replays a pending interrupt (e.g.
PACA_IRQ_DEC -> timer_interrupt), it calls the handler directly with a
synthetic pt_regs. The DEFINE_INTERRUPT_HANDLER_ASYNC wrapper around
each handler calls arch_interrupt_async_exit_prepare() on the way out,
which calls arch_interrupt_exit_prepare() -> local_irq_disable() ->
arch_local_irq_disable(), which does:

    irq_soft_mask_set(IRQS_DISABLED)   /* 0x1 */

This unconditionally overwrites irq_soft_mask with IRQS_DISABLED (0x1),
stripping the IRQS_PMI_DISABLED (0x2) bit. The result is that
irq_soft_mask is 0x1 instead of IRQS_ALL_DISABLED (0x3) when the
handler returns to __replay_soft_interrupts().

For a normally-taken interrupt this is harmless: the next interrupt
always enters through arch_interrupt_enter_prepare() which
unconditionally sets irq_soft_mask to IRQS_ALL_DISABLED. But during
replay, next_interrupt() is called directly between replayed handlers
without going back through arch_interrupt_enter_prepare(), so the
stripped bit is never restored. next_interrupt() then fires a WARNING:

    WARNING: arch/powerpc/kernel/irq_64.c:75
    WARN_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED)

The warning was observed early in boot on a POWER10 pseries guest
during kmem_cache_init_late(), where a spinlock release triggers
interrupt replay that processes a pending timer interrupt.

Debugger state confirming the bug:
  Before timer_interrupt(&regs):
    irq_soft_mask = 0x3 (IRQS_ALL_DISABLED)   correct
    irq_happened  = 0x41 (HARD_DIS|REPLAYING)  correct
  After timer_interrupt(&regs) returns:
    irq_soft_mask = 0x1 (IRQS_DISABLED)        WRONG - PMI bit stripped
    irq_happened  = 0x41                        unchanged

The fix is to replace local_irq_disable() with hard_irq_disable().

hard_irq_disable() is the right primitive here for two reasons:

1. On PPC64 (hw_irq.h:301) it calls irq_soft_mask_set_return(IRQS_ALL_DISABLED),
   setting the soft mask to 0x3 (both IRQS_DISABLED and IRQS_PMI_DISABLED),
   which preserves the PMI bit and fixes the WARNING. The additional
   work it does (__hard_irq_disable(), PACA_IRQ_HARD_DIS |=) is
   redundant but safe since both are already set at this point in the
   exit path; the trace_hardirqs_off() inside is guarded by
   if (!arch_irqs_disabled_flags(flags)) so it will not double-fire.

2. On PPC32 (hw_irq.h:467) hard_irq_disable() maps to
   arch_local_irq_disable() -> __hard_irq_disable(), which clears
   MSR[EE] in hardware. This is exactly correct: PPC32 has no soft-mask
   PACA mechanism, so the hardware disable is the right way to satisfy
   irqentry_exit()'s requirement. This also fixes a build error on PPC32
   where irq_soft_mask_set() is only defined under CONFIG_PPC64:

       arch/powerpc/include/asm/entry-common.h:273: error: implicit
       declaration of function 'irq_soft_mask_set'

   Using hard_irq_disable() requires no #ifdef and is consistent with
   how the rest of the entry code (e.g. entry-common.h:463) handles the
   same PPC32/PPC64 split.

Fixes: 334f3f6d7a16 ("powerpc/entry: Disable interrupts before irqentry_exit")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com/
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
Change log:
V2 -> V3:
	- Revert to hard_irq_disable
	- Removed some dead code
V2: https://lore.kernel.org/all/20260820134718.2176411-1-mkchauras@gmail.com
V1 -> V2:
	- Instead of using hard_irq_disable use irq_soft_mask_set
V1: https://lore.kernel.org/all/20260812152035.1661781-1-mkchauras@gmail.com
 arch/powerpc/include/asm/entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index 94083516df57..80b07750b531 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -270,7 +270,7 @@ static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
 	}
 
 	/* irqentry_exit expects to be called with interrupts disabled */
-	local_irq_disable();
+	hard_irq_disable();
 }
 
 static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
-- 
2.55.0


