Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 18DE1DDEFE
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 06:46:58 +1000 (EST)
Date: Thu, 9 Aug 2007 22:46:55 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix i2c device string format
In-Reply-To: <3368b27f860fafb35d10f6352e9055bf@kernel.crashing.org>
Message-ID: <Pine.LNX.4.60.0708092233130.5995@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707180010330.3535@poirot.grange>
	<87DC7695-382B-4641-B9D9-75ACB49D41A4@kernel.crashing.org>
	<Pine.LNX.4.60.0707191932300.3365@poirot.grange>
	<719AE7E4-FE6D-4973-8887-F787EC8ABC85@kernel.crashing.org>
	<Pine.LNX.4.60.0707202219340.3946@poirot.grange>
	<235e0ff22961e25016727c0e74fd0c0f@kernel.crashing.org>
	<Pine.LNX.4.60.0708010739560.4228@poirot.grange>
	<19a13f8700d078abc4cab0064a7d0183@kernel.crashing.org>
	<Pine.LNX.4.60.0708012053240.7394@poirot.grange>
	<46B0F030.9030007@freescale.com>
	<Pine.LNX.4.60.0708080023030.8493@poirot.grange>
	<3368b27f860fafb35d10f6352e9055bf@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 9 Aug 2007, Segher Boessenkool wrote:

> > > strncpy() won't put a terminating zero on there, is everything
> > > that uses the resulting string okay with that?  Also, if the
> > > name gets cut short, it might match some _other_ expected name.
> > 
> > On Wed, 1 Aug 2007, Scott Wood wrote:
> > 
> > > You could use strlcpy() instead, which always leaves a zero terminator.
> > 
> > The patch below does exactly this - uses strlcpy() to guarantee strings in
> > i2c device type and driver_name fields are 0-terminated.
> 
> You're not checking the return values of these calls.  This would
> be a good function to put attribute warn_unused_result on :-)

hm... Well, the worst that could happen, if an "evil" programmer defines 
too long a name, it gets truncated, and then binds to a wrong driver, 
well, the worst that can happen is that your hardware gets damaged, not a 
big thing. However, some might disagree, so, below is a new version... 
Wrap some long lines while at that.

Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 727453d..c0d66df 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -320,21 +320,26 @@ static struct i2c_driver_device i2c_devices[] __initdata = {
 	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
 };
 
-static int __init of_find_i2c_driver(struct device_node *node, struct i2c_board_info *info)
+static int __init of_find_i2c_driver(struct device_node *node,
+				     struct i2c_board_info *info)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
 		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
 			continue;
-		strncpy(info->driver_name, i2c_devices[i].i2c_driver, KOBJ_NAME_LEN);
-		strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
+		if (strlcpy(info->driver_name, i2c_devices[i].i2c_driver,
+			    KOBJ_NAME_LEN) >= KOBJ_NAME_LEN ||
+		    strlcpy(info->type, i2c_devices[i].i2c_type,
+			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
+			return -ENOMEM;
 		return 0;
 	}
 	return -ENODEV;
 }
 
-static void __init of_register_i2c_devices(struct device_node *adap_node, int bus_num)
+static void __init of_register_i2c_devices(struct device_node *adap_node,
+					   int bus_num)
 {
 	struct device_node *node = NULL;
 
