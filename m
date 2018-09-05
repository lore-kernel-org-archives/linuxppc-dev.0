Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424nGk1rwKzF37S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 12:10:19 +1000 (AEST)
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so2616340pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 19:10:19 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, joel@jms.id.au,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 1/2] powerpc/prom: Remove VLA in prom_check_platform_support()
Date: Wed,  5 Sep 2018 12:09:50 +1000
Message-Id: <20180905020951.10372-2-sjitindarsingh@gmail.com>
In-Reply-To: <20180905020951.10372-1-sjitindarsingh@gmail.com>
References: <20180905020951.10372-1-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In prom_check_platform_support() we retrieve and parse the
"ibm,arch-vec-5-platform-support" property of the chosen node.
Currently we use a variable length array however to avoid this use an
array of constant length 8.

This property is used to indicate the supported options of vector 5
bytes 23-26 of the ibm,architecture.vec node. Each of these options
is a pair of bytes, thus for 4 options we have a max length of 8 bytes.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/kernel/prom_init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 9b38a2e5dd35..ce5fc03dc69f 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1131,12 +1131,15 @@ static void __init prom_check_platform_support(void)
 				       "ibm,arch-vec-5-platform-support");
 	if (prop_len > 1) {
 		int i;
-		u8 vec[prop_len];
+		u8 vec[8];
 		prom_debug("Found ibm,arch-vec-5-platform-support, len: %d\n",
 			   prop_len);
+		if (prop_len > sizeof(vec))
+			prom_printf("WARNING: ibm,arch-vec-5-platform-support longer "\
+				    " than expected (len: %d)\n", prop_len);
 		prom_getprop(prom.chosen, "ibm,arch-vec-5-platform-support",
 			     &vec, sizeof(vec));
-		for (i = 0; i < prop_len; i += 2) {
+		for (i = 0; i < sizeof(vec); i += 2) {
 			prom_debug("%d: index = 0x%x val = 0x%x\n", i / 2
 								  , vec[i]
 								  , vec[i + 1]);
-- 
2.13.6
