Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 62409679E9
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 00:13:41 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: marcelo@kvack.org
Subject: [PATCH] ppc: cs4218_tdm remove extra brace
Date: Thu, 30 Nov 2006 13:48:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200611301348.59401.m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

	I tried to find where does this line come from. Googled a bit with
no luck. Probably somewhere between 2.5.10 and 2.5.20 some patch generated
this leftover.


static struct timer_list beep_timer = {
        function: cs_nosound
};

changed to:

static struct timer_list beep_timer = TIMER_INITIALIZER(cs_nosound, 0, 0);
};


The patch below removes this extra line.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/ppc/8xx_io/cs4218_tdm.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/arch/ppc/8xx_io/cs4218_tdm.c	2006-11-28 12:16:29.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/arch/ppc/8xx_io/cs4218_tdm.c	2006-11-29 16:12:22.000000000 +0100
@@ -1379,7 +1379,6 @@ static void cs_nosound(unsigned long xx)
 }
 
 static DEFINE_TIMER(beep_timer, cs_nosound, 0, 0);
-};
 
 static void cs_mksound(unsigned int hz, unsigned int ticks)
 {


-- 
Regards,

	Mariusz Kozlowski
