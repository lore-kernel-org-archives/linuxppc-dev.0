Return-Path: <B48286@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0EB6A2C00CA
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jan 2014 18:47:48 +1100 (EST)
From: "B48286@freescale.com" <B48286@freescale.com>
To: 'Brian Norris' <computersforpeace@gmail.com>
Subject: RE: [PATCH] mtd: m25p80: Add Power Management support
Date: Mon, 6 Jan 2014 07:32:46 +0000
Message-ID: <d1263353f32444328abe7566a48881d7@DM2PR03MB301.namprd03.prod.outlook.com>
References: <1386749970-22021-1-git-send-email-b48286@freescale.com>
 <20140103190049.GG5631@ld-irv-0074>
In-Reply-To: <20140103190049.GG5631@ld-irv-0074>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>On Wed, Dec 11, 2013 at 04:19:30PM +0800, Hou Zhiqiang wrote:
>> Add PM support using callback function suspend and resume in .driver=20
>> of spi_driver.
>>=20
>> Signed-off-by: Hou Zhiqiang <b48286@freescale.com>
>> ---
>>  drivers/mtd/devices/m25p80.c | 37=20
>> +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>=20
>> diff --git a/drivers/mtd/devices/m25p80.c=20
>> b/drivers/mtd/devices/m25p80.c index 7eda71d..b0c2b8c 100644
>> --- a/drivers/mtd/devices/m25p80.c
>> +++ b/drivers/mtd/devices/m25p80.c
>> @@ -66,6 +66,8 @@
>> =20
>>  /* Used for Spansion flashes only. */
>>  #define	OPCODE_BRWR		0x17	/* Bank register write */
>> +#define	OPCODE_DP		0xb9	/* Enter deep power down mode */
>> +#define	OPCODE_RES		0xab	/* Exit deep power down mode */
>
>Where did you get these opcodes from? They are not in the Spansion datashe=
ets I'm reading. And in fact, they are overloaded as RES (Read Electronic S=
ignature, 0xab) and Bank Register Access (0xb9) in the datasheet I'm lookin=
g at. So this patch is wrong.
>

In datasheet S25FL128P, Deep Power Down command is b9h and Release from Dee=
p Power Down command is abh. In S25FL-A to S25FL-P Migration Guide those co=
mmands are the same.

>Also, can you describe the purpose of these "deep power down" modes?
>I've never seen PM states where the *flash* needs to be put into a lower p=
ower mode. Typically the flash is pretty low-power when idle, and it may ev=
en be powered off completely when the system enters a lower-power state. An=
yway, please describe why this patch is needed.
>

In standby mode, the MAX currunt consumption is 200mA, and in Deep Power Do=
wn mode, the MAX is 20mA. In actually the typically value of currunt consum=
ption is 3mA, so it save power consumption significantly I think.

>> =20
>>  /* Status Register bits. */
>>  #define	SR_WIP			1	/* Write in progress */
>> @@ -1128,11 +1130,46 @@ static int m25p_remove(struct spi_device *spi)
>>  	return mtd_device_unregister(&flash->mtd);
>>  }
>> =20
>> +#ifdef CONFIG_PM
>> +static int m25p_suspend(struct device *dev, pm_message_t mesg) {
>> +	struct m25p *flash =3D dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	flash->command[0] =3D OPCODE_DP;
>
>As mentioned above, this opcode is not recognized by many flash supported =
in this driver. So we might want one or more of the following:
>
> (1) to assign different suspend/resume opcodes for use in
>     m25p_suspend/resume
> (2) to provide over-loadable callbacks so that different flash could
>     use different suspend/resume routines
>
>And of course, we need to avoid sending these commands at all to unsupport=
ed flash.
>

Yeah, in m25p_probe we can get spi flash specified PM commands from somewhe=
re, but where can we set the PM commands, in struct spi_device_id?
Do you have some good suggestion?

>> +	mutex_lock(&flash->lock);
>> +	/* Wait until finished previous write/erase command. */
>> +	ret =3D wait_till_ready(flash);
>> +	if (ret) {
>> +		mutex_unlock(&flash->lock);
>> +		return ret;
>> +	}
>> +	ret =3D spi_write(flash->spi, flash->command, 1);
>> +	mutex_unlock(&flash->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int m25p_resume(struct device *dev) {
>> +	struct m25p *flash =3D dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	flash->command[0] =3D OPCODE_RES;
>> +	ret =3D spi_write(flash->spi, flash->command, 1);
>> +
>> +	return ret;
>> +}
>> +#endif /* CONFIG_PM */
>> =20
>>  static struct spi_driver m25p80_driver =3D {
>>  	.driver =3D {
>>  		.name	=3D "m25p80",
>>  		.owner	=3D THIS_MODULE,
>> +#ifdef CONFIG_PM
>> +		.suspend =3D m25p_suspend,
>> +		.resume =3D m25p_resume,
>> +#endif
>>  	},
>>  	.id_table	=3D m25p_ids,
>>  	.probe	=3D m25p_probe,
>
>Brian

Zhiqiang Hou
