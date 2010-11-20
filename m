Return-Path: <highguy@gmail.com>
Received: from jacques.telenet-ops.be (jacques.telenet-ops.be [195.130.132.50])
	by ozlabs.org (Postfix) with ESMTP id 69FB31007D3
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Nov 2010 21:59:49 +1100 (EST)
Message-ID: <5F1D4949966C4C509360407B0F948EFE@HIGHGuY>
From: "Stijn Devriendt" <HIGHGuY@gmail.com>
To: "Wolfram Sang" <w.sang@pengutronix.de>
References: <1289995250-17927-1-git-send-email-w.sang@pengutronix.de>
	<1289995250-17927-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1289995250-17927-2-git-send-email-w.sang@pengutronix.de>
Subject: Re: [PATCH 1/3] misc: at24: parse OF-data, too
Date: Sat, 20 Nov 2010 11:54:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

I'm surprised that this would work. I've patched the at24 driver as well
to use OF data, but took a different approach.

As far as I could tell, using compatible = <24c64>; didn't load the right 
module
(module name is at24) and using at24 caused a device id mismatch because
at24 is not a known device ID. I could be wrong here and if so, I'd very 
much
like a source code hint as to why...

My patch worked by changing drivers/of/of_i2c.c to allow a generic
kind = " " statement that was filled in as i2c_board_info.type, to allow
the module name and the device id to be different.
This makes the at24 driver no longer rely on probing (which it claims
is buggy anyway) and also benefits other drivers that support multiple
devices, but where probing is difficult (e.g. lm90 driver).

I'm in the process of getting employer approval to get these patches 
upstream.

Regards,
Stijn

-----Oorspronkelijk bericht----- 
From: Wolfram Sang
Sent: Wednesday, November 17, 2010 1:00 PM
To: devicetree-discuss@ozlabs.org
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] misc: at24: parse OF-data, too

Information about the pagesize and read-only-status may also come from
the devicetree. Parse this data, too, and act accordingly. While we are
here, change the initialization printout a bit. write_max is useful to
know to detect performance bottlenecks, the rest is superfluous.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

Changes since last version:

- use __be32 instead of u32

Documentation/powerpc/dts-bindings/eeprom.txt |   28 +++++++++++++++++++++
drivers/misc/eeprom/at24.c                    |   33 
++++++++++++++++++++----
2 files changed, 55 insertions(+), 6 deletions(-)
create mode 100644 Documentation/powerpc/dts-bindings/eeprom.txt

diff --git a/Documentation/powerpc/dts-bindings/eeprom.txt 
b/Documentation/powerpc/dts-bindings/eeprom.txt
new file mode 100644
index 0000000..4342c10
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/eeprom.txt
@@ -0,0 +1,28 @@
+EEPROMs (I2C)
+
+Required properties:
+
+  - compatible : should be "<manufacturer>,<type>"
+ If there is no specific driver for <manufacturer>, a generic
+ driver based on <type> is selected. Possible types are:
+ 24c00, 24c01, 24c02, 24c04, 24c08, 24c16, 24c32, 24c64,
+ 24c128, 24c256, 24c512, 24c1024, spd
+
+  - reg : the I2C address of the EEPROM
+
+Optional properties:
+
+  - pagesize : the length of the pagesize for writing. Please consult the
+               manual of your device, that value varies a lot. A wrong 
value
+        may result in data loss! If not specified, a safety value of
+        '1' is used which will be very slow.
+
+  - read-only: this parameterless property disables writes to the eeprom
+
+Example:
+
+eeprom@52 {
+ compatible = "atmel,24c32";
+ reg = <0x52>;
+ pagesize = <32>;
+};
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 559b0b3..3a53efc 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -20,6 +20,7 @@
#include <linux/log2.h>
#include <linux/bitops.h>
#include <linux/jiffies.h>
+#include <linux/of.h>
#include <linux/i2c.h>
#include <linux/i2c/at24.h>

@@ -457,6 +458,27 @@ static ssize_t at24_macc_write(struct memory_accessor 
*macc, const char *buf,

/*-------------------------------------------------------------------------*/

+#ifdef CONFIG_OF
+static void at24_get_ofdata(struct i2c_client *client,
+ struct at24_platform_data *chip)
+{
+ const __be32 *val;
+ struct device_node *node = client->dev.of_node;
+
+ if (node) {
+ if (of_get_property(node, "read-only", NULL))
+ chip->flags |= AT24_FLAG_READONLY;
+ val = of_get_property(node, "pagesize", NULL);
+ if (val)
+ chip->page_size = be32_to_cpup(val);
+ }
+}
+#else
+static void at24_get_ofdata(struct i2c_client *client,
+ struct at24_platform_data *chip)
+{ }
+#endif /* CONFIG_OF */
+
static int at24_probe(struct i2c_client *client, const struct i2c_device_id 
*id)
{
  struct at24_platform_data chip;
@@ -485,6 +507,9 @@ static int at24_probe(struct i2c_client *client, const 
struct i2c_device_id *id)
  */
  chip.page_size = 1;

+ /* update chipdata if OF is present */
+ at24_get_ofdata(client, &chip);
+
  chip.setup = NULL;
  chip.context = NULL;
  }
@@ -597,19 +622,15 @@ static int at24_probe(struct i2c_client *client, const 
struct i2c_device_id *id)

  i2c_set_clientdata(client, at24);

- dev_info(&client->dev, "%zu byte %s EEPROM %s\n",
+ dev_info(&client->dev, "%zu byte %s EEPROM, %s, %u bytes/write\n",
  at24->bin.size, client->name,
- writable ? "(writable)" : "(read-only)");
+ writable ? "writable" : "read-only", at24->write_max);
  if (use_smbus == I2C_SMBUS_WORD_DATA ||
      use_smbus == I2C_SMBUS_BYTE_DATA) {
  dev_notice(&client->dev, "Falling back to %s reads, "
     "performance will suffer\n", use_smbus ==
     I2C_SMBUS_WORD_DATA ? "word" : "byte");
  }
- dev_dbg(&client->dev,
- "page_size %d, num_addresses %d, write_max %d, use_smbus %d\n",
- chip.page_size, num_addresses,
- at24->write_max, use_smbus);

  /* export data to kernel code */
  if (chip.setup)
-- 
1.7.2.3

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev 
