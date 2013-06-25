Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2DA652C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 16:36:09 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 02:36:07 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9D93938C8045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 02:35:33 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P6ZYfY326526
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 02:35:34 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P6ZXoE026224
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 02:35:34 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] powerpc/eeh: Avoid warning on P8
Date: Tue, 25 Jun 2013 14:35:28 +0800
Message-Id: <1372142128-18077-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372142128-18077-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372142128-18077-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To replace down() with down_interrutible() to avoid following
warning:

[c00000007ba7b710] [c000000000014410] .__switch_to+0x1b0/0x380
[c00000007ba7b7c0] [c0000000007b408c] .__schedule+0x3ec/0x970
[c00000007ba7ba50] [c0000000007b1f24] .schedule_timeout+0x1a4/0x2b0
[c00000007ba7bb30] [c0000000007b34a4] .__down+0xa4/0x104
[c00000007ba7bbf0] [c0000000000b9230] .down+0x60/0x70
[c00000007ba7bc80] [c0000000000336d0] .eeh_event_handler+0x70/0x190
[c00000007ba7bd30] [c0000000000b1a58] .kthread+0xe8/0xf0
[c00000007ba7be30] [c00000000000a05c] .ret_from_kernel_thread+0x5c/0x8

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_event.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index 39bcd81..d27c5af 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -55,7 +55,8 @@ static int eeh_event_handler(void * dummy)
 	struct eeh_pe *pe;
 
 	while (!kthread_should_stop()) {
-		down(&eeh_eventlist_sem);
+		if (down_interruptible(&eeh_eventlist_sem))
+			break;
 
 		/* Fetch EEH event from the queue */
 		spin_lock_irqsave(&eeh_eventlist_lock, flags);
-- 
1.7.5.4
