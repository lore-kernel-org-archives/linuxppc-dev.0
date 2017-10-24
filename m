Return-Path: <keescook@chromium.org>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLq4L6lgWzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 21:18:57 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id j3so14144381pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 03:18:57 -0700 (PDT)
Date: Tue, 24 Oct 2017 03:18:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] drivers/macintosh: Convert timers to use timer_setup()
Message-ID: <20171024101853.GA69439@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/macintosh/smu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index ea9bdc85a21d..899ec1f4c833 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -103,7 +103,7 @@ static DEFINE_MUTEX(smu_part_access);
 static int smu_irq_inited;
 static unsigned long smu_cmdbuf_abs;
 
-static void smu_i2c_retry(unsigned long data);
+static void smu_i2c_retry(struct timer_list *t);
 
 /*
  * SMU driver low level stuff
@@ -582,9 +582,7 @@ static int smu_late_init(void)
 	if (!smu)
 		return 0;
 
-	init_timer(&smu->i2c_timer);
-	smu->i2c_timer.function = smu_i2c_retry;
-	smu->i2c_timer.data = (unsigned long)smu;
+	timer_setup(&smu->i2c_timer, smu_i2c_retry, 0);
 
 	if (smu->db_node) {
 		smu->db_irq = irq_of_parse_and_map(smu->db_node, 0);
@@ -755,7 +753,7 @@ static void smu_i2c_complete_command(struct smu_i2c_cmd *cmd, int fail)
 }
 
 
-static void smu_i2c_retry(unsigned long data)
+static void smu_i2c_retry(struct timer_list *unused)
 {
 	struct smu_i2c_cmd	*cmd = smu->cmd_i2c_cur;
 
@@ -795,7 +793,7 @@ static void smu_i2c_low_completion(struct smu_cmd *scmd, void *misc)
 		BUG_ON(cmd != smu->cmd_i2c_cur);
 		if (!smu_irq_inited) {
 			mdelay(5);
-			smu_i2c_retry(0);
+			smu_i2c_retry(NULL);
 			return;
 		}
 		mod_timer(&smu->i2c_timer, jiffies + msecs_to_jiffies(5));
-- 
2.7.4


-- 
Kees Cook
Pixel Security
