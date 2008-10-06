Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4D91DDDFBA
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 04:08:40 +1100 (EST)
Date: Mon, 6 Oct 2008 21:08:39 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v3] powerpc/83xx: don't probe broken PCI on mpc837x_mds boards
Message-ID: <20081006170839.GA21726@oksana.dev.rtsoft.ru>
References: <20081002151852.GA8823@oksana.dev.rtsoft.ru>
	<504AAC96-2F7E-4A06-B544-1F2169BB2176@kernel.crashing.org>
	<20081003160814.GA26115@oksana.dev.rtsoft.ru>
	<01391274-EE23-4DE0-BEA9-BC2BCBD16789@kernel.crashing.org>
	<20081003162709.GB31740@oksana.dev.rtsoft.ru>
	<D4BCDA24-B860-4D21-8115-2A22CD01B480@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <D4BCDA24-B860-4D21-8115-2A22CD01B480@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the standalone setup the board's CPLD disables the PCI internal
arbiter, thus any access to the PCI bus will hang the board.

The common way to disable particular devices in the device tree is to
put the "status" property with any value other than "ok" or "okay"
into the device node we want to disable.

So, when there is no PCI arbiter on the bus the u-boot adds status =
"broken (no arbiter)" property into the PCI controller's node, and so
marks the PCI controller as unavailable.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Fri, Oct 03, 2008 at 12:51:41PM -0500, Kumar Gala wrote:
[...]
>>> yes, but should we just have "status = disabled" since that is the
>>> effect?
>>
>> I don't know, should we? For the unavailable/disabled case the status
>> can be anything but not 'ok' or 'okay' (the only status values for the
>> available devices). So if we can encode the reason, why not do this?
>
> that works for me, just add the fact to the commit msg that the "valid  
> status's are 'ok' and 'okay' and everything else is treated as "not  
> available or disabled"

Done.

 arch/powerpc/platforms/83xx/mpc837x_mds.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index be62de2..8bb13c8 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -85,8 +85,14 @@ static void __init mpc837x_mds_setup_arch(void)
 		ppc_md.progress("mpc837x_mds_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci") {
+		if (!of_device_is_available(np)) {
+			pr_warning("%s: disabled by the firmware.\n",
+				   np->full_name);
+			continue;
+		}
 		mpc83xx_add_bridge(np);
+	}
 #endif
 	mpc837xmds_usb_cfg();
 }
-- 
1.5.6.3
