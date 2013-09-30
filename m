Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by ozlabs.org (Postfix) with ESMTP id 9CAF22C0091
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 23:24:13 +1000 (EST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MTX00072WRMTJT0@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 30 Sep 2013 22:14:10 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] powerpc/8xx: tqm8xx: fix incorrect placement of __initdata tag
Date: Mon, 30 Sep 2013 15:13:55 +0200
Message-id: <1589399.KSlGuZSdd2@amdc1032>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: Marcelo Tosatti <marcelo@kvack.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
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
 arch/powerpc/platforms/8xx/tqm8xx_setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/tqm8xx_setup.c b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
index 8d21ab7..ef0778a 100644
--- a/arch/powerpc/platforms/8xx/tqm8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
@@ -48,7 +48,7 @@ struct cpm_pin {
 	int port, pin, flags;
 };
 
-static struct __initdata cpm_pin tqm8xx_pins[] = {
+static struct cpm_pin tqm8xx_pins[] __initdata = {
 	/* SMC1 */
 	{CPM_PORTB, 24, CPM_PIN_INPUT}, /* RX */
 	{CPM_PORTB, 25, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TX */
@@ -63,7 +63,7 @@ static struct __initdata cpm_pin tqm8xx_pins[] = {
 	{CPM_PORTC, 11, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_GPIO},
 };
 
-static struct __initdata cpm_pin tqm8xx_fec_pins[] = {
+static struct cpm_pin tqm8xx_fec_pins[] __initdata = {
 	/* MII */
 	{CPM_PORTD, 3, CPM_PIN_OUTPUT},
 	{CPM_PORTD, 4, CPM_PIN_OUTPUT},
-- 
1.8.2.3
