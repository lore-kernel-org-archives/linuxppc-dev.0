Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402gxM46WMzF13F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 21:02:31 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y186so3968456pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 03:02:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 3/4] powerpc/powernv/nvram: opal_nvram_write handle
 unknown OPAL errors
Date: Fri, 16 Mar 2018 20:02:11 +1000
Message-Id: <20180316100212.5110-4-npiggin@gmail.com>
In-Reply-To: <20180316100212.5110-1-npiggin@gmail.com>
References: <20180316100212.5110-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

opal_nvram_write currently just assumes success if it encounters an
error other than OPAL_BUSY or OPAL_BUSY_EVENT. Have it return -EIO
on other errors instead.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-nvram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c
index 9db4398ded5d..13bf625dc3e8 100644
--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -59,6 +59,8 @@ static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
 	}
+	if (rc)
+		return -EIO;
 	*index += count;
 	return count;
 }
-- 
2.16.1
