Return-Path: <vitb@kernel.crashing.org>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 958F4DDF4F
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 03:07:54 +1000 (EST)
Message-ID: <462F8953.1020201@kernel.crashing.org>
Date: Wed, 25 Apr 2007 21:01:07 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH][RFC][POWERPC] i2c: adds support for i2c bus on 8xx
References: <20070420082714.4f10f186@localhost.localdomain>
	<20070423025709.GA28805@lixom.net>
In-Reply-To: <20070423025709.GA28805@lixom.net>
Content-Type: multipart/alternative;
	boundary="------------020303090202040904030106"
Cc: Jean Delvare <khali@linux-fr.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020303090202040904030106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Olof Johansson wrote:
> On Fri, Apr 20, 2007 at 08:27:14AM +0400, Vitaly Bordug wrote:
>
>   
>> diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
>> index 9bd81c7..d32e066 100644
>> --- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
>> +++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
>> @@ -51,6 +51,7 @@ static void init_smc1_uart_ioports(struc
>>  static void init_smc2_uart_ioports(struct fs_uart_platform_info* fpi);
>>  static void init_scc3_ioports(struct fs_platform_info* ptr);
>>  static void init_irda_ioports(void);
>> +static void init_i2c_ioports(void);
>>  
>>  void __init mpc885ads_board_setup(void)
>>  {
>> @@ -120,6 +121,10 @@ #endif
>>  #ifdef CONFIG_8XX_SIR
>>  	init_irda_ioports();
>>  #endif
>> +
>> +#ifdef CONFIG_I2C_RPXLITE
>> +	init_i2c_ioports();
>> +#endif
>>     
>
> Does it hurt to always do it, even when the driver is not enabled? THat'd
> do away with an ifdef.
>
>   
Well it will hurt - 8xx has conflicting io pin configurations, and 
nothing should be set up "just in case".

> Also, if you move the static function up, you don't need a prototype. That
> goes for other stuff in this file too.
>
>   
>>  }
>>  
>>  
>> @@ -361,6 +366,15 @@ static void init_irda_ioports()
>>  	immr_unmap(cp);
>>  }
>>  
>> +static void init_i2c_ioports()
>> +{
>> +	cpm8xx_t *cp = (cpm8xx_t *)immr_map(im_cpm);
>> +
>> +        setbits32(&cp->cp_pbpar, 0x00000030);
>> +        setbits32(&cp->cp_pbdir, 0x00000030);
>> +        setbits16(&cp->cp_pbodr, 0x0030);
>> +}
>>     
>
> Looks like you moved this out of the driver and into the platform
> code. What happens to other platforms where it's used?
>
>   
i2c && 8xx combo never work with 2.6 at least in mainstream. That's why 
related stuff were scheduled to removal by Jean even,
before I came up with this stuff.
>> +
>>  int platform_device_skip(const char *model, int id)
>>  {
>>  #ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
>> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
>> index 419b688..7ecd537 100644
>> --- a/arch/powerpc/sysdev/fsl_soc.c
>> +++ b/arch/powerpc/sysdev/fsl_soc.c
>> @@ -331,7 +331,7 @@ static int __init fsl_i2c_of_init(void)
>>  	for (np = NULL, i = 0;
>>  	     (np = of_find_compatible_node(np, "i2c", "fsl-i2c")) != NULL;
>>  	     i++) {
>> -		struct resource r[2];
>> +		struct resource r[3];
>>     
>
> Why? No code that uses it has been changed. Is it a bugfix?
>
>   
maybe something stray...
>>  		struct fsl_i2c_platform_data i2c_data;
>>  		const unsigned char *flags = NULL;
>>  
>> @@ -1215,4 +1215,63 @@ err:
>>  
>>  arch_initcall(fs_irda_of_init);
>>  
>> +static const char *i2c_regs = "regs";
>> +static const char *i2c_pram = "pram";
>> +static const char *i2c_irq = "interrupt";
>> +
>> +static int __init fsl_i2c_cpm_of_init(void)
>> +{
>> +	struct device_node *np;
>> +	unsigned int i;
>> +	struct platform_device *i2c_dev;
>> +	int ret;
>> +
>> +	for (np = NULL, i = 0;
>> +	     (np = of_find_compatible_node(np, "i2c", "fsl-i2c-cpm")) != NULL;
>> +	     i++) {
>> +		struct resource r[3];
>> +		struct fsl_i2c_platform_data i2c_data;
>> +
>> +		memset(&r, 0, sizeof(r));
>> +		memset(&i2c_data, 0, sizeof(i2c_data));
>> +
>> +		ret = of_address_to_resource(np, 0, &r[0]);
>> +		if (ret)
>> +			goto err;
>> +		r[0].name = i2c_regs;
>> +
>> +		ret = of_address_to_resource(np, 1, &r[1]);
>> +		if (ret)
>> +			goto err;
>> +		r[1].name = i2c_pram;
>> +
>> +		r[2].start = r[2].end = irq_of_parse_and_map(np, 0);
>> +		r[2].flags = IORESOURCE_IRQ;
>> +		r[2].name = i2c_irq;
>> +
>> +		i2c_dev = platform_device_register_simple("fsl-i2c-cpm", i, &r[0], 3);
>> +		if (IS_ERR(i2c_dev)) {
>> +			ret = PTR_ERR(i2c_dev);
>> +			goto err;
>> +		}
>> +
>> +		ret =
>> +		    platform_device_add_data(i2c_dev, &i2c_data,
>> +					     sizeof(struct
>> +						    fsl_i2c_platform_data));
>> +		if (ret)
>> +			goto unreg;
>> +	}
>> +
>> +	return 0;
>> +
>> +unreg:
>> +	platform_device_unregister(i2c_dev);
>> +err:
>> +	return ret;
>> +}
>> +
>> +arch_initcall(fsl_i2c_cpm_of_init);
>>     
>
> This could all be done with an of_platform driver instead, and avoid the above.
> (Someone else already suggested that I believe).
>
>   
I know i know. But it was decided, while both ppc/ and powerpc/ wander 
around, platform devices way is preferrable.
It is apparent why - so far only mpc885 is alive in arch/powerpc, and it 
is not going to change soon for 8xx. OTOH,
some stuff from arch/ppc might use it/add BSP configuration etc.

Having some devices on of_device and some on pdev look kinda messy.
Thanks,
Vitaly


--------------020303090202040904030106
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=us-ascii" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Olof Johansson wrote:
<blockquote cite="mid20070423025709.GA28805@lixom.net" type="cite">
  <pre wrap="">On Fri, Apr 20, 2007 at 08:27:14AM +0400, Vitaly Bordug wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 9bd81c7..d32e066 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -51,6 +51,7 @@ static void init_smc1_uart_ioports(struc
 static void init_smc2_uart_ioports(struct fs_uart_platform_info* fpi);
 static void init_scc3_ioports(struct fs_platform_info* ptr);
 static void init_irda_ioports(void);
+static void init_i2c_ioports(void);
 
 void __init mpc885ads_board_setup(void)
 {
@@ -120,6 +121,10 @@ #endif
 #ifdef CONFIG_8XX_SIR
 	init_irda_ioports();
 #endif
+
+#ifdef CONFIG_I2C_RPXLITE
+	init_i2c_ioports();
+#endif
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Does it hurt to always do it, even when the driver is not enabled? THat'd
do away with an ifdef.

  </pre>
</blockquote>
Well it will hurt - 8xx has conflicting io pin configurations, and
nothing should be set up "just in case".<br>
<br>
<blockquote cite="mid20070423025709.GA28805@lixom.net" type="cite">
  <pre wrap="">Also, if you move the static function up, you don't need a prototype. That
goes for other stuff in this file too.

  </pre>
  <blockquote type="cite">
    <pre wrap=""> }
 
 
@@ -361,6 +366,15 @@ static void init_irda_ioports()
 	immr_unmap(cp);
 }
 
+static void init_i2c_ioports()
+{
+	cpm8xx_t *cp = (cpm8xx_t *)immr_map(im_cpm);
+
+        setbits32(&amp;cp-&gt;cp_pbpar, 0x00000030);
+        setbits32(&amp;cp-&gt;cp_pbdir, 0x00000030);
+        setbits16(&amp;cp-&gt;cp_pbodr, 0x0030);
+}
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Looks like you moved this out of the driver and into the platform
code. What happens to other platforms where it's used?

  </pre>
</blockquote>
i2c &amp;&amp; 8xx combo never work with 2.6 at least in mainstream.
That's why related stuff were scheduled to removal by Jean even,<br>
before I came up with this stuff.<br>
<blockquote cite="mid20070423025709.GA28805@lixom.net" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">+
 int platform_device_skip(const char *model, int id)
 {
 #ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 419b688..7ecd537 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -331,7 +331,7 @@ static int __init fsl_i2c_of_init(void)
 	for (np = NULL, i = 0;
 	     (np = of_find_compatible_node(np, "i2c", "fsl-i2c")) != NULL;
 	     i++) {
-		struct resource r[2];
+		struct resource r[3];
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Why? No code that uses it has been changed. Is it a bugfix?

  </pre>
</blockquote>
maybe something stray...<br>
<blockquote cite="mid20070423025709.GA28805@lixom.net" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap=""> 		struct fsl_i2c_platform_data i2c_data;
 		const unsigned char *flags = NULL;
 
@@ -1215,4 +1215,63 @@ err:
 
 arch_initcall(fs_irda_of_init);
 
+static const char *i2c_regs = "regs";
+static const char *i2c_pram = "pram";
+static const char *i2c_irq = "interrupt";
+
+static int __init fsl_i2c_cpm_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+	struct platform_device *i2c_dev;
+	int ret;
+
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "i2c", "fsl-i2c-cpm")) != NULL;
+	     i++) {
+		struct resource r[3];
+		struct fsl_i2c_platform_data i2c_data;
+
+		memset(&amp;r, 0, sizeof(r));
+		memset(&amp;i2c_data, 0, sizeof(i2c_data));
+
+		ret = of_address_to_resource(np, 0, &amp;r[0]);
+		if (ret)
+			goto err;
+		r[0].name = i2c_regs;
+
+		ret = of_address_to_resource(np, 1, &amp;r[1]);
+		if (ret)
+			goto err;
+		r[1].name = i2c_pram;
+
+		r[2].start = r[2].end = irq_of_parse_and_map(np, 0);
+		r[2].flags = IORESOURCE_IRQ;
+		r[2].name = i2c_irq;
+
+		i2c_dev = platform_device_register_simple("fsl-i2c-cpm", i, &amp;r[0], 3);
+		if (IS_ERR(i2c_dev)) {
+			ret = PTR_ERR(i2c_dev);
+			goto err;
+		}
+
+		ret =
+		    platform_device_add_data(i2c_dev, &amp;i2c_data,
+					     sizeof(struct
+						    fsl_i2c_platform_data));
+		if (ret)
+			goto unreg;
+	}
+
+	return 0;
+
+unreg:
+	platform_device_unregister(i2c_dev);
+err:
+	return ret;
+}
+
+arch_initcall(fsl_i2c_cpm_of_init);
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This could all be done with an of_platform driver instead, and avoid the above.
(Someone else already suggested that I believe).

  </pre>
</blockquote>
I know i know. But it was decided, while both ppc/ and powerpc/ wander
around, platform devices way is preferrable.<br>
It is apparent why - so far only mpc885 is alive in arch/powerpc, and
it is not going to change soon for 8xx. OTOH,<br>
some stuff from arch/ppc might use it/add BSP configuration etc.<br>
<br>
Having some devices on of_device and some on pdev look kinda messy.<br>
<blockquote cite="mid20070423025709.GA28805@lixom.net" type="cite">
  <pre wrap=""></pre>
</blockquote>
Thanks,<br>
Vitaly<br>
<br>
</body>
</html>

--------------020303090202040904030106--
