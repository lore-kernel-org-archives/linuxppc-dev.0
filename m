Return-Path: <weiyj.lk@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B41D32C008D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2012 15:43:02 +1100 (EST)
Received: by mail-qc0-f179.google.com with SMTP id b14so1154189qcs.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Oct 2012 21:42:59 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 22 Oct 2012 12:42:59 +0800
Message-ID: <CAPgLHd-kHAx5Eb8Jd8iH4=KoCv1mjrtaLWd4D7bWJ2zLQoJe3g@mail.gmail.com>
Subject: [PATCH] TTY: hvcs: fix missing unlock on error in hvcs_initialize()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: gregkh@linuxfoundation.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing unlock on the error handling path in function
hvcs_initialize().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/hvc/hvcs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index cab5c7a..744c3b8 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1496,8 +1496,10 @@ static int __devinit hvcs_initialize(void)
 		num_ttys_to_alloc = hvcs_parm_num_devs;
 
 	hvcs_tty_driver = alloc_tty_driver(num_ttys_to_alloc);
-	if (!hvcs_tty_driver)
+	if (!hvcs_tty_driver) {
+		mutex_unlock(&hvcs_init_mutex);
 		return -ENOMEM;
+	}
 
 	if (hvcs_alloc_index_list(num_ttys_to_alloc)) {
 		rc = -ENOMEM;
