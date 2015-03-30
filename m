Return-Path: <joel@jms.id.au>
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 351C91A054F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 13:15:52 +1100 (AEDT)
Received: by pddn5 with SMTP id n5so43928125pdd.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2015 19:15:50 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/powernv: Reboot when requested by firmware
Date: Mon, 30 Mar 2015 12:45:33 +1030
Message-Id: <1427681733-25488-2-git-send-email-joel@jms.id.au>
In-Reply-To: <1427681733-25488-1-git-send-email-joel@jms.id.au>
References: <1427681733-25488-1-git-send-email-joel@jms.id.au>
Cc: rusty@rustcorp.com.au, fabf@skynet.be, jk@ozlabs.org,
 akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use orderly_reboot so userspace will to shut itself down via the reboot
path. This is required for graceful reboot initiated by the BMC, such
as when a user uses ipmitool to issue a 'chassis power cycle' command.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/platforms/powernv/opal-power.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-power.c b/arch/powerpc/platforms/powernv/opal-power.c
index 48bf5b0..ac46c2c 100644
--- a/arch/powerpc/platforms/powernv/opal-power.c
+++ b/arch/powerpc/platforms/powernv/opal-power.c
@@ -29,8 +29,9 @@ static int opal_power_control_event(struct notifier_block *nb,
 
 	switch (type) {
 	case SOFT_REBOOT:
-		/* Fall through. The service processor is responsible for
-		 * bringing the machine back up */
+		pr_info("OPAL: reboot requested\n");
+		orderly_reboot();
+		break;
 	case SOFT_OFF:
 		pr_info("OPAL: poweroff requested\n");
 		orderly_poweroff(true);
-- 
2.1.4
