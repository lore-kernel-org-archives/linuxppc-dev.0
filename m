Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id 8F20ADDDD8
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 09:40:14 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1390588rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 15:40:13 -0700 (PDT)
Message-ID: <9e4733910810191540p1000c28l89ca50794addae37@mail.gmail.com>
Date: Sun, 19 Oct 2008 18:40:13 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
In-Reply-To: <Pine.LNX.4.64.0810200022040.21665@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
	<20081019025323.GA7887@ime.usp.br>
	<Pine.LNX.4.64.0810192147030.21665@axis700.grange>
	<9e4733910810191432o58d204adw490cb8e4fcc390ac@mail.gmail.com>
	<Pine.LNX.4.64.0810192347250.21665@axis700.grange>
	<9e4733910810191505u3ec1db0dl25e87bf3b78c740d@mail.gmail.com>
	<Pine.LNX.4.64.0810200022040.21665@axis700.grange>
Cc: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 19, 2008 at 6:28 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Sun, 19 Oct 2008, Jon Smirl wrote:
>
>> i2c-mpc.c has:
>>
>> static const struct of_device_id mpc_i2c_of_match[] = {
>>       {.compatible = "fsl-i2c",},
>>       {},
>> };
>> MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
>>
>>
>> /* Structure for a device driver */
>> static struct of_platform_driver mpc_i2c_driver = {
>>       .match_table    = mpc_i2c_of_match,
>>       .probe          = fsl_i2c_probe,
>>       .remove         = __devexit_p(fsl_i2c_remove),
>>       .driver         = {
>>               .owner  = THIS_MODULE,
>>               .name   = DRV_NAME,
>>       },
>> };
>>
>> That should match:
>>
>>               i2c@80003000 {
>>                       #address-cells = <1>;
>>                       #size-cells = <0>;
>>                       cell-index = <0>;
>>                       compatible = "fsl-i2c";
>>                       reg = <0x80003000 0x1000>;
>>                       interrupts = <5 2>;
>>                       interrupt-parent = <&mpic>;
>>
>>                       rtc@32 {
>>                               device_type = "rtc";
>>                               compatible = "ricoh,rs5c372a";
>>                               reg = <0x32>;
>>                       };
>>               };
>
> It should, but it doesn't.
>
>> This code works on my mpc5200 board.
>
> Don't know which 5200 board you have, but, for example lite5200 has
>
>                        compatible = "fsl,mpc5200-i2c","fsl-i2c";
>
> see the difference?
>
>> Maybe fsl_i2c_probe() is failing?
>
> It has a printk at each error case (ok, except kzalloc, but I don't think
> that is the case), I see none of them.
>
>> Add some printks in i2c-mpc to help debug the problem.
>> Any errors from i2c-mpc in dmesg?
>
> None, and, as I said, there are no error messages from it, so, it doesn't
> get called at all. To be quite sure I added a printk at the entry - as
> expected it didn't get printed.

Is i2c-mpc built into your kernel? It's not going to module auto-load
because the names don't match - fsl-i2c and i2c-mpc.

But a message on init and make sure it is loading.
static int __init fsl_i2c_init(void)
{
	int rv;

	rv = of_register_platform_driver(&mpc_i2c_driver);
	if (rv)
		printk(KERN_ERR DRV_NAME
		       " of_register_platform_driver failed (%i)\n", rv);
	return rv;
}

>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
>



-- 
Jon Smirl
jonsmirl@gmail.com
