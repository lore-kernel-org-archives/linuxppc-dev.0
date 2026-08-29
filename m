Return-Path: <linuxppc-dev+bounces-26178-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CE1C61DBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 04:19:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hX28431Kvz2xfq;
	Sat, 29 Aug 2026 14:19:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787977156;
	cv=none; b=nt6GHswt/BenUwNilR/y0UreooJIxSaFIjj4wtCwdR8lDs3tS7HfiATEV+NLx1hmRXtqKr7mLVSFw5XY+TdRzeNqBgF607uahXb8AWSIISTz9PJUWcjvwvjbmUkGdftqVPQ1ravI3tonpVbxynXmFJmEotLr4repLkGfasPnI6mPrHiHsdvTFHutkftAOcOSviY5UCLHKfTRfskcfCKNTib865+u5zunGe+06EuVygQBqQQPwSW3nseZoHxZVSsbOLog+/jwW3ITPFururP3x0XvdxCR1r+lRCdhTMsCWSF6pY2ttJb+jJKD8GypANtESh4pAsT7kEriRwVIE2NS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787977156; c=relaxed/relaxed;
	bh=MJ7RneC7sw/h/YzJ4NP50EyFONLT/Rk/VSXoFbvmUIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M2wS/kvlrnAj1f3RZvWDUzKA76pIqEADfZ2xpltN0ifiMH1ewfx035wzLinPNFm40bU0nWmROgZzgL+1zl9fXOM5S0Vkwe9PnRl0psg51ncFuhWrZ/7SCjvBnA5mE028I45Jv63LzKE4a4jKrS8wQCynssGtxrR+q1k3w3SOJcMF5gD6XdpiXpfl2O/otgDjfJDflRcVIk4ArKV3/lHSw0jDaESYM6lT9BDayjbXOWjaeVh3xj/2lsQqnm1gnduf1BH4fl/RWCxoHyrkN4aRMEH5kQYAI5MeUKU66HwFcUaqJ07xrgb5pSVQ5ELXWq9zD+Zn2BbzEU5se+9T1TeWVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BUHR864n; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BUHR864n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hX2824yh9z2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 14:19:13 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1535329a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 21:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787977150; x=1788581950; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MJ7RneC7sw/h/YzJ4NP50EyFONLT/Rk/VSXoFbvmUIw=;
        b=BUHR864n0O980SMyEKpGL7ECuYg7KoeGh+3NrPmADr0D5qo5DrQSO4NLsYtFRXFNwH
         J0KLQDJPPj/ho0QrQkJTAzeay0tmmzkAOuOAnyqdp71hLLVLsv+ZIa9/B2kXzshnhMPJ
         uBaP6vgdFK7h1QdA0x2Ff9Xt4QaO2DdevqH+uMpQZsuKJRz6ubO8AKCGXha2TKVHkhNx
         BFf4UmXQNVGkE86le7l9MB63Lz5/0dNRLmCr/FuwuK8xLZOLE673D91tM03dnd7Z0jie
         CZrKGiTff8hRgaua8H0fkStJAHPAvd6QCrOFIkHbJRtwM6VHqsTRklC2b7VdCMYXNObO
         HBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787977150; x=1788581950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MJ7RneC7sw/h/YzJ4NP50EyFONLT/Rk/VSXoFbvmUIw=;
        b=H5AuIYJGnjauwv54CtgCOpo/4nE4FsNwn5AdF5PPU1IpvfxWt2VuNaJ+K9bp2bNYYN
         M2jjuxFOSZN45xv/JxXNKna/r3++sBBUui9+fquEIi8pClTFY61MsaxxN88w0X6CoR1S
         tj3RLFcxZ67ntw6vRjulBC7TFbgcMY45x2X3vtb+tjkdwB96GVqb/cksu4E4oAMdZe2D
         nV8OvsZe0qgRY7Ru96yU8jS2XpHc6usibMbtKr1b8dorUPE4Nibn6xL5X6IvtvRR8F70
         /35eopb1nTiXD26nZt2wisOYdny6kYidzyNzRxkUuVZ1Q9Uoyg6lXgX4vSCxyfatPms+
         TtuQ==
X-Gm-Message-State: AFuF++n/vwgx9DOvFUOZmIKDM2BtjahnSt/FSDN3w6xJF18YBcmaMWs7
	rG+FaBMuJkeiye0KTnk6zrzxj9FLumxzscO2w5gxnpjzQtDkBa+uY5ZrYQ1anw==
X-Gm-Gg: AYBFou1G2BljpieJ2gadDSTstK2XNiQ5efzJyrrvCOyw/WyrllNH/v7sqq8EencbDg4
	sE9VZflVva+Uh71JjbDxbpLZJfLbalKvwv11lTl+v+lvwtVVE5MFKhjIIjLJDVN7yhbmZcDNMac
	5WGYVdWm+5t1DEs+PSf7Iuirw4evlsLw71E3r1DIEF7rZLedj1M/asq9+980eHepLY++NiiMWfu
	MArX3JR6TXEhKrXHFKj/b+/wSxxWRPbpMRVtYh/oXuTlfJ/kccKIzuisniMfoPSj3xIJnjMTrfo
	Q8xeMFJaViCx8aNG6Y4u35S3BGfCcLWlO1RYjrgZ/LKiNSnTznajsNXv4WcHrs7OHRLI02sDisj
	PblSFDsfgv9KDrqJ7nO0N47xGo7tLtPgMm3IBrlrl5Ce9Z5gX8F4r5Cz1Z/3lEadXMaTcO1pxxI
	NCLYvyuYGduRaHKgleVhKi+sFQKvqhPIBOEo0+PGQkrg2Fkpq4V7+SGCp+oIfyF8oywt/ALUiwT
	+Xq8t6gUqlQ1ZL6smS44ob7KswzyrPE5VDVXMMgGHcL16l/39Yc
X-Received: by 2002:a17:90b:5408:b0:398:9be6:f995 with SMTP id 98e67ed59e1d1-3989be6fa97mr6528787a91.20.1787977150241;
        Fri, 28 Aug 2026 21:19:10 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f783c37sm12186602eec.6.2026.08.28.21.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 21:19:09 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] powerpc: Don't drop _TIF_RESTOREALL on syscall restart
Date: Sat, 29 Aug 2026 09:49:00 +0530
Message-Id: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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

So the syscall return sequence is as follows:
A syscall return to userspace is prepared and then a short asm sequence
that actually does the RFI. Note that this asm range is restartable i.e.
EE is still on, so an interrupt (e.g. decrementer or external interrupt)
can hit while SRR/GPRs are being loaded. This is defined via:

RESTART_TABLE(.Lsyscall_rst_start, .Lsyscall_rst_end, syscall_restart)

This restart table then sends us to syscall_restart rather than resuming
in the middle of the RFI. The same stub is also used if irq_happened
already has a pending bit (soft-masked irq that has not been replayed
yet (PowerPC special case of local_irq_disable())).

Here is a bit of a flow of sequence of code to visualize:
  syscall_exit_prepare
      decide full-GPR restore (_TIF_RESTOREALL) for signal,
      rt_sigreturn or syscall trace
      save that in regs->exit_result and return it in r3
           |
           v
  .Lsyscall_rst_start .. _end     EE still on
      irq_happened set or interrupt in this range?
           | no                         | yes
           v                            v
      cmpdi r3,0                  syscall_exit_restart
      restore all / zero            replay irq, try exit again
      volatiles; RFI                must return flags in r3
                                    again for the same cmpdi

Now r3 after prepare is the flags word, not the actual syscall return. A nested
interrupt clobbers it, so the restart stub reloads RESULT into r3 and the
C handler (syscall_exit_restart()) should put the flags back (because later asm
checks whether r3 returned from C has _TIF_RESTOREALL set or not):
	cmpdi r3, 0
	bne	.Lsyscall_restore_regs

Note that syscall_exit_restart() already ORs any new _TIF_RESTOREALL into
exit_result, but then it only returns the new sample and not the full
regs->exit_result.

That sample could be often 0 even when restore-all is still required:

  - rt_sigreturn / syscall trace set the bit in prepare's local
    ret and in exit_result. They never set exit_flags, which is
    what restart samples.

  - a signal does set exit_flags but restart clears it. A
    second pass through the stub then returns 0 while
    exit_result still has the bit.

The asm as mentioned earlier then treats r3==0 as the fast path and
zeros r0/r4-r12. That means the userspace that needed the full register
set could SIGSEGVs, (which could happen often in ld64.so.2 like while
doing a parallel kernel build as reported by Venkat).

So we should instead return the accumulated exit_result, like how we do
in interrupt_exit_user_restart(). Note that prior to this commit
263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for ptrace")
we were returning regs->exit_result from syscall_exit_restart(), but
this commit changed that behaviour.

Fixes: 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for ptrace")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/75419f88-eab9-444b-bf97-28a9765819ad@linux.ibm.com/
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
Sorry about the long commit msg. It took sometime for me to fully understand
that complex path, so I thought I may as well document that properly.

 arch/powerpc/kernel/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 5b88bf72786c..55f9c0c9922a 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -175,7 +175,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
 	current_thread_info()->exit_flags &= ~_TIF_RESTOREALL;
 	regs->exit_result |= ret;

-	return ret;
+	return regs->exit_result;
 }
 #endif

--
2.39.5


