Return-Path: <Yang.Shi@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvWPh0CpDzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 04:11:35 +1000 (AEST)
From: Yang Shi <yang.shi@windriver.com>
To: <alistair@popple.id.au>, <mporter@kernel.crashing.org>,
 <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>, <yang.shi@windriver.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc/4xx: make sam440ep_setup_rtc init
Date: Tue, 26 Apr 2016 09:49:38 -0700
Message-ID: <1461689378-10978-1-git-send-email-yang.shi@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sam440ep_setup_rtc is just called by machine_device_initcall, and it calls
i2c_register_board_info which is init too, so the lack of __init may cause
mismatch warning when linking kernel.

Signed-off-by: Yang Shi <yang.shi@windriver.com>
---
 arch/powerpc/platforms/44x/sam440ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/44x/sam440ep.c b/arch/powerpc/platforms/44x/sam440ep.c
index 3ee4a03..fbecfc1 100644
--- a/arch/powerpc/platforms/44x/sam440ep.c
+++ b/arch/powerpc/platforms/44x/sam440ep.c
@@ -72,7 +72,7 @@ static struct i2c_board_info sam440ep_rtc_info = {
 	.irq = -1,
 };
 
-static int sam440ep_setup_rtc(void)
+static int __init sam440ep_setup_rtc(void)
 {
 	return i2c_register_board_info(0, &sam440ep_rtc_info, 1);
 }
-- 
2.0.2
