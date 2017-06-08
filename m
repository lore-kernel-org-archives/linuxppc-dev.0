Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjt8K4Dy2zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 14:42:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [RESEND PATCH] input/joystick/analog: Use get_cycles() on PPC
Date: Thu,  8 Jun 2017 14:42:53 +1000
Message-Id: <1496896973-13848-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The analog joystick driver spits a warning at us:

  drivers/input/joystick/analog.c:176:2: warning: #warning Precise timer
  not defined for this architecture.

PPC has get_cycles() so use that.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/input/joystick/analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 3d8ff09eba57..06962b63f3a6 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -163,7 +163,7 @@ static unsigned int get_time_pit(void)
 #define GET_TIME(x)	do { x = (unsigned int)rdtsc(); } while (0)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"TSC"
-#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_TILE)
+#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_TILE) || defined(CONFIG_PPC)
 #define GET_TIME(x)	do { x = get_cycles(); } while (0)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"get_cycles"
-- 
2.7.4
