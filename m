Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbXcj4KP3zDrJg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 22:12:21 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id t3so3187445pgt.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 05:12:21 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, ludovic.desroches@microchip.com, wsa@the-dreams.de,
 jochen@scram.de, vadimp@mellanox.com, michaelsh@mellanox.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 andy.gross@linaro.org, david.brown@linaro.org, ldewangan@nvidia.com,
 thierry.reding@gmail.com, jonathanh@nvidia.com, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] i2c: busses: make i2c_adapter_quirks const
Date: Mon, 21 Aug 2017 17:42:04 +0530
Message-Id: <1503317524-21276-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make these const as they are only stored as a reference in the quirks
field of an i2c_adapter structure, which is const.

Done using Coccinelle:
@match disable optional_qualifier@
identifier s;
@@
static struct i2c_adapter_quirks s = {...};

@ref@
position p;
identifier match.s;
@@
s@p

@good1@
identifier y;
position ref.p;
identifier match.s;
@@
struct i2c_adapter y = {...,.quirks=&s@p,...};

@good2@
struct i2c_adapter y;
identifier match.s;
position ref.p;
@@
y.quirks = &s@p

@bad depends on  !good1 && !good2@
position ref.p;
identifier match.s;
@@
s@p

@depends on forall !bad disable optional_qualifier@
identifier match.s;
@@
static
+ const
struct i2c_adapter_quirks s;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/i2c/busses/i2c-at91.c     | 2 +-
 drivers/i2c/busses/i2c-cpm.c      | 2 +-
 drivers/i2c/busses/i2c-mlxcpld.c  | 2 +-
 drivers/i2c/busses/i2c-opal.c     | 2 +-
 drivers/i2c/busses/i2c-powermac.c | 2 +-
 drivers/i2c/busses/i2c-qup.c      | 2 +-
 drivers/i2c/busses/i2c-tegra.c    | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 38dd61d..bfd1fdf 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -809,7 +809,7 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
  * The hardware can handle at most two messages concatenated by a
  * repeated start via it's internal address feature.
  */
-static struct i2c_adapter_quirks at91_twi_quirks = {
+static const struct i2c_adapter_quirks at91_twi_quirks = {
 	.flags = I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | I2C_AQ_COMB_SAME_ADDR,
 	.max_comb_1st_msg_len = 3,
 };
diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index d89bde2..8a8ca94 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -413,7 +413,7 @@ static u32 cpm_i2c_func(struct i2c_adapter *adap)
 };
 
 /* CPM_MAX_READ is also limiting writes according to the code! */
-static struct i2c_adapter_quirks cpm_i2c_quirks = {
+static const struct i2c_adapter_quirks cpm_i2c_quirks = {
 	.max_num_msgs = CPM_MAXBD,
 	.max_read_len = CPM_MAX_READ,
 	.max_write_len = CPM_MAX_READ,
diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
index d271e6a..4c28fa2 100644
--- a/drivers/i2c/busses/i2c-mlxcpld.c
+++ b/drivers/i2c/busses/i2c-mlxcpld.c
@@ -433,7 +433,7 @@ static u32 mlxcpld_i2c_func(struct i2c_adapter *adap)
 	.functionality	= mlxcpld_i2c_func
 };
 
-static struct i2c_adapter_quirks mlxcpld_i2c_quirks = {
+static const struct i2c_adapter_quirks mlxcpld_i2c_quirks = {
 	.flags = I2C_AQ_COMB_WRITE_THEN_READ,
 	.max_read_len = MLXCPLD_I2C_DATA_REG_SZ - MLXCPLD_I2C_MAX_ADDR_LEN,
 	.max_write_len = MLXCPLD_I2C_DATA_REG_SZ,
diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
index 11e2a1f..0aabb7e 100644
--- a/drivers/i2c/busses/i2c-opal.c
+++ b/drivers/i2c/busses/i2c-opal.c
@@ -204,7 +204,7 @@ static u32 i2c_opal_func(struct i2c_adapter *adapter)
  * For two messages, we basically support simple smbus transactions of a
  * write-then-anything.
  */
-static struct i2c_adapter_quirks i2c_opal_quirks = {
+static const struct i2c_adapter_quirks i2c_opal_quirks = {
 	.flags = I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | I2C_AQ_COMB_SAME_ADDR,
 	.max_comb_1st_msg_len = 4,
 };
diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index ef9c858..f2a2067 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -197,7 +197,7 @@ static u32 i2c_powermac_func(struct i2c_adapter * adapter)
 	.functionality	= i2c_powermac_func,
 };
 
-static struct i2c_adapter_quirks i2c_powermac_quirks = {
+static const struct i2c_adapter_quirks i2c_powermac_quirks = {
 	.max_num_msgs = 1,
 };
 
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 1902d8a..08f8e01 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1396,7 +1396,7 @@ static u32 qup_i2c_func(struct i2c_adapter *adap)
  * the end of the read, the length of the read is specified as one byte
  * which limits the possible read to 256 (QUP_READ_LIMIT) bytes.
  */
-static struct i2c_adapter_quirks qup_i2c_quirks = {
+static const struct i2c_adapter_quirks qup_i2c_quirks = {
 	.max_read_len = QUP_READ_LIMIT,
 };
 
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index a238844..60292d2 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -793,7 +793,7 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
 };
 
 /* payload size is only 12 bit */
-static struct i2c_adapter_quirks tegra_i2c_quirks = {
+static const struct i2c_adapter_quirks tegra_i2c_quirks = {
 	.max_read_len = 4096,
 	.max_write_len = 4096,
 };
-- 
1.9.1
