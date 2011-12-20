Return-Path: <bill4carson@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 55976B7140
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 20:05:16 +1100 (EST)
Received: by mail-gy0-f179.google.com with SMTP id r11so4052622ghr.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 01:05:15 -0800 (PST)
From: bill4carson@gmail.com
To: bill4carson@gmail.com
Subject: [PATCH] Copy machine descriptor after probe succeed
Date: Tue, 20 Dec 2011 17:08:47 +0800
Message-Id: <1324372127-8552-2-git-send-email-bill4carson@gmail.com>
In-Reply-To: <1324372127-8552-1-git-send-email-bill4carson@gmail.com>
References: <1324372127-8552-1-git-send-email-bill4carson@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bill Carson <bill4carson@gmail.com>

It make more sense to copy machine descriptor AFTER machine probe return
succeed.

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/powerpc/kernel/setup-common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d426b1d..3362097 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -574,9 +574,9 @@ void probe_machine(void)
 	     machine_id < &__machine_desc_end;
 	     machine_id++) {
 		DBG("  %s ...", machine_id->name);
-		memcpy(&ppc_md, machine_id, sizeof(struct machdep_calls));
-		if (ppc_md.probe()) {
+		if (machine_id->probe()) {
 			DBG(" match !\n");
+			memcpy(&ppc_md, machine_id, sizeof(struct machdep_calls));
 			break;
 		}
 		DBG("\n");
-- 
1.6.3.1
