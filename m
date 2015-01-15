Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 822F11A0D80
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 19:58:20 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Thu, 15 Jan 2015 08:58:16 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id AC7571B0806B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 08:58:50 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F8wEGP57344016
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 08:58:14 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F8wD2N016735
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 01:58:13 -0700
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] x86/spinlock: Leftover conversion ACCESS_ONCE->READ_ONCE
Date: Thu, 15 Jan 2015 09:58:30 +0100
Message-Id: <1421312314-72330-5-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
 Oleg Nesterov <oleg@redhat.com>, kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 78bff1c8684f ("x86/ticketlock: Fix spin_unlock_wait() livelock")
introduced another ACCESS_ONCE case in x86 spinlock.h.

Change that as well.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 arch/x86/include/asm/spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 625660f..9264f0f 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -186,7 +186,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
 	__ticket_t head = ACCESS_ONCE(lock->tickets.head);
 
 	for (;;) {
-		struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
+		struct __raw_tickets tmp = READ_ONCE(lock->tickets);
 		/*
 		 * We need to check "unlocked" in a loop, tmp.head == head
 		 * can be false positive because of overflow.
-- 
1.9.3
