Return-Path: <krautilein@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 5821D1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 Nov 2009 02:44:44 +1100 (EST)
Date: Fri, 27 Nov 2009 16:44:33 +0100
From: Bolko Maass <krautilein@gmx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2.6.31] windfarm: add detection for second cpu pump
Message-Id: <20091127164433.0b5087de.krautilein@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: bmaass@math.uni-bremen.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Windfarm SMU control is explicitly missing support for a second CPU pump in G5 PowerMacs. Such machines actually exist  (specifically Quads with a second pump), so this patch adds detection for it.



diff -uprN a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
--- a/drivers/macintosh/windfarm_smu_controls.c 2009-11-27 16:24:55.000000000 +0100
+++ b/drivers/macintosh/windfarm_smu_controls.c 2009-11-16 18:22:33.000000000 +0100
@@ -202,6 +202,8 @@ static struct smu_fan_control *smu_fan_c
                fct->ctrl.name = "cpu-front-fan-1";
        else if (!strcmp(l, "CPU A PUMP"))
                fct->ctrl.name = "cpu-pump-0";
+       else if (!strcmp(l, "CPU B PUMP"))
+               fct->ctrl.name = "cpu-pump-1";
        else if (!strcmp(l, "Slots Fan") || !strcmp(l, "Slots fan") ||
                 !strcmp(l, "EXPANSION SLOTS INTAKE"))
                fct->ctrl.name = "slots-fan";



Signed-off by: Bolko Maass <bmaass@math.uni-bremen.de>
