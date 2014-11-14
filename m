Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E33201A0BB4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Nov 2014 03:11:41 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BCEF814009B
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2014 03:11:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Sat, 15 Nov 2014 02:11:39 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8E38B357805B
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2014 03:11:37 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAEGBJY936634670
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2014 03:11:20 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAEGBaWI017342
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2014 03:11:36 +1100
Message-ID: <5466295A.1040005@linux.vnet.ibm.com>
Date: Fri, 14 Nov 2014 21:40:02 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
References: <20141110060424.9407.2498.stgit@localhost.localdomain>
 <20141113075817.GA1288@katana>
In-Reply-To: <20141113075817.GA1288@katana>
Content-Type: multipart/alternative;
 boundary="------------040702070404030300020900"
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040702070404030300020900
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/13/2014 01:28 PM, Wolfram Sang wrote:
> Hi,
>
> I am basically fine if this goes via the powerpc-tree and I was hoping
> that I could ack it right now. However, the driver looks a bit rushed
> and definately needs updates before it is ready to go.
>
> On Mon, Nov 10, 2014 at 11:35:39AM +0530, Neelesh Gupta wrote:
>> The patch exposes the available i2c busses on the PowerNV platform
>> to the kernel and implements the bus driver to support i2c and
>> smbus commands.
>> The driver uses the platform device infrastructure to probe the busses
>> on the platform and registers them with the i2c driver framework.
>>
>> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Review for the I2C parts:
>
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index 78d56c5..350aa86 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -102,5 +102,6 @@ obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
>>   obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
>>   obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
>>   obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
>> +obj-$(CONFIG_I2C_OPAL)		+= i2c-opal.o
> Please sort it properly, not simply at the end.

I don't find match under any 'comment' in this file so keeping it under
"Other I2C/SMBus bus drivers".

>
>>   
>>   ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
>> diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
>> new file mode 100644
>> index 0000000..3261716
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-opal.c
>> +
>> +	return rc;
>> +}
>> +
>> +static int i2c_opal_remove(struct platform_device *pdev)
>> +{
>> +	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
>> +
>> +	i2c_del_adapter(adapter);
>> +
>> +	kfree(adapter);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id i2c_opal_of_match[] = {
>> +	{
>> +		.compatible = "ibm,power8-i2c-port",
>> +	},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, i2c_opal_of_match);
>> +
>> +static struct platform_driver i2c_opal_driver = {
>> +	.probe	= i2c_opal_probe,
>> +	.remove	= i2c_opal_remove,
>> +	.driver	= {
>> +		.name		= "i2c-opal",
>> +		.owner		= THIS_MODULE,
> Not needed.

I didn't get this.

>
>> +		.of_match_table	= i2c_opal_of_match,
>> +	},
>> +};
>> +
>> +static int __init i2c_opal_init(void)
>> +{
>> +	if (!firmware_has_feature(FW_FEATURE_OPAL))
>> +		return -ENODEV;
>> +
>> +	return platform_driver_register(&i2c_opal_driver);
>> +}
>> +
>> +static void __exit i2c_opal_exit(void)
>> +{
>> +	return platform_driver_unregister(&i2c_opal_driver);
>> +}
>> +
>> +MODULE_AUTHOR("Neelesh Gupta <neelegup@linux.vnet.ibm.com>");
>> +MODULE_DESCRIPTION("IBM OPAL I2C driver");
>> +MODULE_LICENSE("GPL");
>> +
>> +module_init(i2c_opal_init);
>> +module_exit(i2c_opal_exit);
> Please put thos right below the functions it references.

Okay.

- Neelesh
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------040702070404030300020900
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <div class="moz-cite-prefix">On 11/13/2014 01:28 PM, Wolfram Sang
      wrote:<br>
    </div>
    <blockquote cite="mid:20141113075817.GA1288@katana" type="cite">
      <pre wrap="">Hi,

I am basically fine if this goes via the powerpc-tree and I was hoping
that I could ack it right now. However, the driver looks a bit rushed
and definately needs updates before it is ready to go.

On Mon, Nov 10, 2014 at 11:35:39AM +0530, Neelesh Gupta wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">The patch exposes the available i2c busses on the PowerNV platform
to the kernel and implements the bus driver to support i2c and
smbus commands.
The driver uses the platform device infrastructure to probe the busses
on the platform and registers them with the i2c driver framework.

Signed-off-by: Neelesh Gupta <a class="moz-txt-link-rfc2396E" href="mailto:neelegup@linux.vnet.ibm.com">&lt;neelegup@linux.vnet.ibm.com&gt;</a>
Signed-off-by: Benjamin Herrenschmidt <a class="moz-txt-link-rfc2396E" href="mailto:benh@kernel.crashing.org">&lt;benh@kernel.crashing.org&gt;</a>
</pre>
      </blockquote>
      <pre wrap="">
Review for the I2C parts:

</pre>
      <blockquote type="cite">
        <pre wrap="">diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 78d56c5..350aa86 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -102,5 +102,6 @@ obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
 obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
+obj-$(CONFIG_I2C_OPAL)		+= i2c-opal.o
</pre>
      </blockquote>
      <pre wrap="">
Please sort it properly, not simply at the end.</pre>
    </blockquote>
    <br>
    I don't find match under any 'comment' in this file so keeping it
    under<br>
    "Other I2C/SMBus bus drivers".<br>
    <br>
    <blockquote cite="mid:20141113075817.GA1288@katana" type="cite">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap=""> 
 ccflags-$(CONFIG_I2C_DEBUG_BUS) := -DDEBUG
diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
new file mode 100644
index 0000000..3261716
--- /dev/null
+++ b/drivers/i2c/busses/i2c-opal.c
+
+	return rc;
+}
+
+static int i2c_opal_remove(struct platform_device *pdev)
+{
+	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
+
+	i2c_del_adapter(adapter);
+
+	kfree(adapter);
+
+	return 0;
+}
+
+static const struct of_device_id i2c_opal_of_match[] = {
+	{
+		.compatible = "ibm,power8-i2c-port",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, i2c_opal_of_match);
+
+static struct platform_driver i2c_opal_driver = {
+	.probe	= i2c_opal_probe,
+	.remove	= i2c_opal_remove,
+	.driver	= {
+		.name		= "i2c-opal",
+		.owner		= THIS_MODULE,
</pre>
      </blockquote>
      <pre wrap="">
Not needed.</pre>
    </blockquote>
    <br>
    I didn't get this.<br>
    <br>
    <blockquote cite="mid:20141113075817.GA1288@katana" type="cite">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">+		.of_match_table	= i2c_opal_of_match,
+	},
+};
+
+static int __init i2c_opal_init(void)
+{
+	if (!firmware_has_feature(FW_FEATURE_OPAL))
+		return -ENODEV;
+
+	return platform_driver_register(&amp;i2c_opal_driver);
+}
+
+static void __exit i2c_opal_exit(void)
+{
+	return platform_driver_unregister(&amp;i2c_opal_driver);
+}
+
+MODULE_AUTHOR("Neelesh Gupta <a class="moz-txt-link-rfc2396E" href="mailto:neelegup@linux.vnet.ibm.com">&lt;neelegup@linux.vnet.ibm.com&gt;</a>");
+MODULE_DESCRIPTION("IBM OPAL I2C driver");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_opal_init);
+module_exit(i2c_opal_exit);
</pre>
      </blockquote>
      <pre wrap="">
Please put thos right below the functions it references.</pre>
    </blockquote>
    <br>
    Okay.<br>
    <br>
    - Neelesh<br>
    <blockquote cite="mid:20141113075817.GA1288@katana" type="cite">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to <a class="moz-txt-link-abbreviated" href="mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</a>
More majordomo info at  <a class="moz-txt-link-freetext" href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a>
</pre>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap="">_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------040702070404030300020900--
