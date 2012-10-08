Return-Path: <weiyj.lk@gmail.com>
MIME-Version: 1.0
Date: Mon, 8 Oct 2012 20:39:52 +0800
Message-ID: <CAPgLHd-=SuxABDRiUp3V-HzOnaJVhzOJd4XxPax+NjUJ9xjwVg@mail.gmail.com>
Subject: [PATCH] powerpc/83xx: use module_i2c_driver to simplify the code
From: Wei Yongjun <weiyj.lk@gmail.com>
To: galak@kernel.crashing.org, benh@kernel.crashing.org, paulus@samba.org,
 grant.likely@secretlab.ca, rob.herring@calxeda.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use the module_i2c_driver() macro to make the code smaller
and a bit simpler.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index ef6537b..d91799e 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -232,17 +232,7 @@ static struct i2c_driver mcu_driver = {
 	.id_table = mcu_ids,
 };
 
-static int __init mcu_init(void)
-{
-	return i2c_add_driver(&mcu_driver);
-}
-module_init(mcu_init);
-
-static void __exit mcu_exit(void)
-{
-	i2c_del_driver(&mcu_driver);
-}
-module_exit(mcu_exit);
+module_i2c_driver(mcu_driver);
 
 MODULE_DESCRIPTION("Power Management and GPIO expander driver for "
 		   "MPC8349E-mITX-compatible MCU");
