Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0A34767B6B
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 11:54:23 +1000 (EST)
Date: Tue, 26 Sep 2006 11:54:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] fix spin lock nesting in hvc_iseries
Message-Id: <20060926115416.46b86d82.sfr@canb.auug.org.au>
In-Reply-To: <20060926005838.d0cd5d7e.sfr@canb.auug.org.au>
References: <b6fcc0a0609250547p551f49bcgab46192e7fa55a39@mail.gmail.com>
	<20060926005838.d0cd5d7e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Alexey Dobriyan <adobriyan@gmail.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We had nested spinlocks using the same flags variable, but it turns out
that we don't need the nested locks at all (the lock protects a static
buffer that we aren't using here), so just remove the extra locks.

Spotted by Alexey Dobriyan.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/hvc_iseries.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
index ea36201..f144a94 100644
--- a/drivers/char/hvc_iseries.c
+++ b/drivers/char/hvc_iseries.c
@@ -154,9 +154,7 @@ static int put_chars(uint32_t vtermno, c
 	spin_lock_irqsave(&consolelock, flags);
 
 	if (viochar_is_console(pi) && !viopath_isactive(pi->lp)) {
-		spin_lock_irqsave(&consoleloglock, flags);
 		HvCall_writeLogBuffer(buf, count);
-		spin_unlock_irqrestore(&consoleloglock, flags);
 		sent = count;
 		goto done;
 	}
@@ -172,11 +170,8 @@ static int put_chars(uint32_t vtermno, c
 
 		len = (count > VIOCHAR_MAX_DATA) ? VIOCHAR_MAX_DATA : count;
 
-		if (viochar_is_console(pi)) {
-			spin_lock_irqsave(&consoleloglock, flags);
+		if (viochar_is_console(pi))
 			HvCall_writeLogBuffer(buf, len);
-			spin_unlock_irqrestore(&consoleloglock, flags);
-		}
 
 		init_data_event(viochar, pi->lp);
 
-- 
1.4.2.1
