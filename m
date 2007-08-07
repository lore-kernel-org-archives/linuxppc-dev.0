Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DE9DFDDE2D
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 08:33:02 +1000 (EST)
Date: Wed, 8 Aug 2007 00:32:58 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>,
	Scott Wood <scottwood@freescale.com>
Subject: [PATCH] powerpc: fix i2c device string format
In-Reply-To: <46B0F030.9030007@freescale.com>
Message-ID: <Pine.LNX.4.60.0708080023030.8493@poirot.grange>
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

On Wed, 1 Aug 2007, Segher Boessenkool wrote:

> strncpy() won't put a terminating zero on there, is everything
> that uses the resulting string okay with that?  Also, if the
> name gets cut short, it might match some _other_ expected name.

On Wed, 1 Aug 2007, Scott Wood wrote:

> You could use strlcpy() instead, which always leaves a zero terminator.

The patch below does exactly this - uses strlcpy() to guarantee strings in 
i2c device type and driver_name fields are 0-terminated.

Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>

---

Trying to follow the "canonical" patch format: Paul, please queue this 
patch for 2.6.24. It is not critical, as there no strings at the moment in 
fsl_soc.c, that exceed i2c limits. So, it's just a precaution measure.

Thanks
Guennadi

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 727453d..2ef7036 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -327,8 +327,8 @@ static int __init of_find_i2c_driver(struct device_node *node, struct i2c_board_
 	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
 		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
 			continue;
-		strncpy(info->driver_name, i2c_devices[i].i2c_driver, KOBJ_NAME_LEN);
-		strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
+		strlcpy(info->driver_name, i2c_devices[i].i2c_driver, KOBJ_NAME_LEN);
+		strlcpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
 		return 0;
 	}
 	return -ENODEV;
