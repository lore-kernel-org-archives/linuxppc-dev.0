Return-Path: <geoff@infradead.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BF5E6B6F18
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2011 05:42:38 +1100 (EST)
Subject: [PATCH] powerpc/ps3: Fix lv1_gpu_attribute hcall
From: Geoff Levand <geoff@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Oct 2011 11:42:13 -0700
Message-ID: <1318444933.3496.15.camel@gum>
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
 cbe-oss-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The lv1_gpu_attribute hcall takes three, not five input
arguments.  Adjust the lv1 hcall table and all calls.

Signed-off-by: Geoff Levand <geoff@infradead.org>
CC: Takashi Iwai <tiwai@suse.de>
---
 arch/powerpc/include/asm/lv1call.h |    2 +-
 sound/ppc/snd_ps3.c                |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/include/asm/lv1call.h
+++ b/arch/powerpc/include/asm/lv1call.h
@@ -315,7 +315,7 @@ LV1_CALL(gpu_context_free,              
 LV1_CALL(gpu_context_iomap,                             5, 0, 221 )
 LV1_CALL(gpu_context_attribute,                         6, 0, 225 )
 LV1_CALL(gpu_context_intr,                              1, 1, 227 )
-LV1_CALL(gpu_attribute,                                 5, 0, 228 )
+LV1_CALL(gpu_attribute,                                 3, 0, 228 )
 LV1_CALL(get_rtc,                                       0, 2, 232 )
 LV1_CALL(set_ppe_periodic_tracer_frequency,             1, 0, 240 )
 LV1_CALL(start_ppe_periodic_tracer,                     5, 0, 241 )
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -875,7 +875,7 @@ static void __devinit snd_ps3_audio_set_
 		(0x0fUL << 12) |
 		(PS3_AUDIO_IOID);
 
-	ret = lv1_gpu_attribute(0x100, 0x007, val, 0, 0);
+	ret = lv1_gpu_attribute(0x100, 0x007, val);
 	if (ret)
 		pr_info("%s: gpu_attribute failed %d\n", __func__,
 			ret);
