Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F1EAEB709C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 09:40:57 +1000 (EST)
Received: from mail-px0-f182.google.com (mail-px0-f182.google.com
	[209.85.216.182]) by ozlabs.org (Postfix) with ESMTP id 6D6C5DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 09:40:55 +1000 (EST)
Received: by pxi12 with SMTP id 12so4006312pxi.17
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 16:40:54 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc: Fix spin_event_timeout() to be robust over context
	switches
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, timur@freescale.com,
	jonsmirl@gmail.com
Date: Mon, 29 Jun 2009 17:40:51 -0600
Message-ID: <20090629234035.12475.58493.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Current implementation of spin_event_timeout can be interrupted by an
IRQ or context switch after testing the condition, but before checking
the timeout.  This can cause the loop to report a timeout when the
condition actually became true in the middle.

This patch adds one final check of the condition upon exit of the loop
if the last test of the condition was still false.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/include/asm/delay.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/include/asm/delay.h b/arch/powerpc/include/asm/delay.h
index 1e2eb41..52e4d54 100644
--- a/arch/powerpc/include/asm/delay.h
+++ b/arch/powerpc/include/asm/delay.h
@@ -63,6 +63,8 @@ extern void udelay(unsigned long usecs);
 			udelay(delay);                                         \
 		else                                                           \
 			cpu_relax();                                           \
+	if (!__ret)                                                            \
+		__ret = (condition);                                           \
 	__ret;		                                                       \
 })
 
