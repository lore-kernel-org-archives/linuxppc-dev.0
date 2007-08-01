Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id EDEB1DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 06:36:18 +1000 (EST)
Date: Wed, 1 Aug 2007 22:36:04 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
In-Reply-To: <19a13f8700d078abc4cab0064a7d0183@kernel.crashing.org>
Message-ID: <Pine.LNX.4.60.0708012053240.7394@poirot.grange>
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

> > > > > > +		strncpy(info->driver_name, i2c_devices[i].i2c_driver,
> > > > > > KOBJ_NAME_LEN);
> > > > > > +		strncpy(info->type, i2c_devices[i].i2c_type,
> > > > > > I2C_NAME_SIZE);
> > > > > 
> > > > > Why not just strcpy(), btw?
> > > > 
> > > > Because target strings are finite length, and sources are just pointers
> > > > to
> > > > some constant strings, which one might make arbitrarily long.
> > > 
> > > So it's no problem if the name or type string gets cut short?
> > > Just checking :-)
> > 
> > Then it just won't match.
> 
> strncpy() won't put a terminating zero on there, is everything
> that uses the resulting string okay with that?

Ok, this might be a problem, I guess. E.g., in 
drivers/i2c/i2c-core.c::i2c_device_uevent():

	if (add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
			"MODALIAS=%s", client->driver_name))

and in a couple more places.

> Also, if the
> name gets cut short, it might match some _other_ expected name.

Don't think this could happen. At least the generic strcmp compares the 
'\0' too.

Now, the bad news (for me at least, as well as for some on #mklinux). To 
fix the bug I wrote the patch below. Yes, it is lacking a "Signed-..." - 
on purpose. Here's why. Having written it, I verified, that

	c[4] = "01234";

causes a nice compiler warning like:

warning: initializer-string for array of chars is too long

Then I asked myself what happens if you do

	c[4] = "0123";

? To my surprise, there was no warning. So, for example, declaring a 
struct like

struct t {
	char c[4];
	int i;
} z;

and doing

	strcpy(z.c, c);

silently corrupts z.i. Verified with gcc 3.3.x, 3.4.5, 4.1.2. 4.2 Does 
emit a warning... Now, am I right that there are lots of places in 
the kernel where we just initialize arrays of chars like above and then 
use ctrcpy to copy it to another equally-long string? Which means, if the 
initialization string is exactly the array length - without the '\0' - we 
get random memory corruption... And the only safe way is 

	strncpy(z.c, c, 3);
	z.c[3] = '\0';

with compilers < 4.2?...

Thanks
Guennadi
---

Fix a bug introduced by my earlier patch, whereby strncpy of too long a 
line could leave the result unterminated. Instead, just use fixed-size 
arrays and let the compiler verify the length for us. No need to try to 
save a few bytes of __initdata anyway. Thanks to Segher Boessenkool for 
pointing out.

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 727453d..1e567d5 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -309,8 +309,8 @@ arch_initcall(gfar_of_init);
 #include <linux/i2c.h>
 struct i2c_driver_device {
 	char	*of_device;
-	char	*i2c_driver;
-	char	*i2c_type;
+	char	i2c_driver[KOBJ_NAME_LEN];
+	char	i2c_type[I2C_NAME_SIZE];
 };
 
 static struct i2c_driver_device i2c_devices[] __initdata = {
@@ -327,8 +327,8 @@ static int __init of_find_i2c_driver(struct device_node *node, struct i2c_board_
 	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
 		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
 			continue;
-		strncpy(info->driver_name, i2c_devices[i].i2c_driver, KOBJ_NAME_LEN);
-		strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
+		strcpy(info->driver_name, i2c_devices[i].i2c_driver);
+		strcpy(info->type, i2c_devices[i].i2c_type);
 		return 0;
 	}
 	return -ENODEV;
