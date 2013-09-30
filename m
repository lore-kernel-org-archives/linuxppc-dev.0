Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by ozlabs.org (Postfix) with ESMTP id CD8B52C0082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 23:21:56 +1000 (EST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MTX00FI8WNSJR20@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 30 Sep 2013 22:11:52 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/legacy_serial: fix incorrect placement of __initdata
 tag
Date: Mon, 30 Sep 2013 15:11:42 +0200
Message-id: <35419229.o6Cv8JYbpg@amdc1032>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, Kyungmin Park <kyungmin.park@samsung.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__initdata tag should be placed between the variable name and equal
sign for the variable to be placed in the intended .init.data section.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/powerpc/kernel/legacy_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 22e88dd..40bd7bd 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -35,7 +35,7 @@ static struct legacy_serial_info {
 	phys_addr_t			taddr;
 } legacy_serial_infos[MAX_LEGACY_SERIAL_PORTS];
 
-static struct __initdata of_device_id legacy_serial_parents[] = {
+static struct of_device_id legacy_serial_parents[] __initdata = {
 	{.type = "soc",},
 	{.type = "tsi-bridge",},
 	{.type = "opb", },
-- 
1.8.2.3
