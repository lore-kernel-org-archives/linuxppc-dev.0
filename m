Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id 907BFDDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 09:05:21 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1382911rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 15:05:20 -0700 (PDT)
Message-ID: <9e4733910810191505u3ec1db0dl25e87bf3b78c740d@mail.gmail.com>
Date: Sun, 19 Oct 2008 18:05:19 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
In-Reply-To: <Pine.LNX.4.64.0810192347250.21665@axis700.grange>
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

On Sun, Oct 19, 2008 at 5:49 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Sun, 19 Oct 2008, Jon Smirl wrote:
>
>> On Sun, Oct 19, 2008 at 4:59 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> >
>> > Yes, there seems to be a problem here now. The i2c adapter does not get
>> > probed, i.e., of-matching doesn't work. A quick look through other
>> > device-trees, using the same i2c driver, through git-logs of the i2c
>> > driver and the dts didn't bring me to a solution. Can anyone spot what's
>> > wrong with kuroboxHG.dts? lsprop output looks reasonable. Last working
>> > kernel was 2.6.25-rc6-ish.
>> >
>> >> I just saw that in the default config:
>> >>
>> >> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>> >> # CONFIG_PPC_CLOCK is not set
>> >> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>> >
>> > No, kurobox uses generic RTC class.
>>
>> I don't see anything obviously wrong.
>>
>> Is rtc-rs5c372 built into your kernel?
>>
>> You may need to add some debug statements in drivers/of/of_i2c.c to
>> figure out what is wrong.
>> It could be something like a _ not matching a -.
>
> Above I said:
>
>> > Yes, there seems to be a problem here now. The i2c adapter does not get
>> > probed, i.e., of-matching doesn't work. A quick look through other
>
> i.e., i2c-mpc is not matched against its fdt-node, not the rtc.

i2c-mpc.c has:

static const struct of_device_id mpc_i2c_of_match[] = {
	{.compatible = "fsl-i2c",},
	{},
};
MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);


/* Structure for a device driver */
static struct of_platform_driver mpc_i2c_driver = {
	.match_table	= mpc_i2c_of_match,
	.probe		= fsl_i2c_probe,
	.remove		= __devexit_p(fsl_i2c_remove),
	.driver		= {
		.owner	= THIS_MODULE,
		.name	= DRV_NAME,
	},
};

That should match:

		i2c@80003000 {
			#address-cells = <1>;
			#size-cells = <0>;
			cell-index = <0>;
			compatible = "fsl-i2c";
			reg = <0x80003000 0x1000>;
			interrupts = <5 2>;
			interrupt-parent = <&mpic>;

			rtc@32 {
				device_type = "rtc";
				compatible = "ricoh,rs5c372a";
				reg = <0x32>;
			};
		};

This code works on my mpc5200 board.

Maybe fsl_i2c_probe() is failing?

Add some printks in i2c-mpc to help debug the problem.
Any errors from i2c-mpc in dmesg?


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
