Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.227])
	by ozlabs.org (Postfix) with ESMTP id D060FDDDEA
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 23:19:38 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1737990rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 05:19:36 -0700 (PDT)
Message-ID: <9e4733910810200519w4689131dv73bf3539c53d2bea@mail.gmail.com>
Date: Mon, 20 Oct 2008 08:19:36 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
In-Reply-To: <Pine.LNX.4.64.0810200754550.3941@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081013040703.GA11059@ime.usp.br>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
	<20081019025323.GA7887@ime.usp.br>
	<Pine.LNX.4.64.0810192147030.21665@axis700.grange>
	<9e4733910810191432o58d204adw490cb8e4fcc390ac@mail.gmail.com>
	<Pine.LNX.4.64.0810192347250.21665@axis700.grange>
	<9e4733910810191505u3ec1db0dl25e87bf3b78c740d@mail.gmail.com>
	<Pine.LNX.4.64.0810200022040.21665@axis700.grange>
	<9e4733910810191540p1000c28l89ca50794addae37@mail.gmail.com>
	<Pine.LNX.4.64.0810200754550.3941@axis700.grange>
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

On Mon, Oct 20, 2008 at 1:55 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Sun, 19 Oct 2008, Jon Smirl wrote:
>
>> Is i2c-mpc built into your kernel? It's not going to module auto-load
>> because the names don't match - fsl-i2c and i2c-mpc.
>
> It is built into the kernel.

Put a printk in it's init function to make sure it is initializing.

Next thing I do is put printks over in arch/powerpc/.. to tell me
which strings from the device tree are being looked for.

You can also look in /proc/device_tree and make sure fsl-i2c is in there.

When you find the problem is will probably be something simple like a
mismatch between _ and -. I have been down this path before and spent
a day figuring out why a module wouldn't load and it was a simple
typo.

>
> Thanks
> Guennadi
>
>>
>> But a message on init and make sure it is loading.
>> static int __init fsl_i2c_init(void)
>> {
>>       int rv;
>>
>>       rv = of_register_platform_driver(&mpc_i2c_driver);
>>       if (rv)
>>               printk(KERN_ERR DRV_NAME
>>                      " of_register_platform_driver failed (%i)\n", rv);
>>       return rv;
>> }
>>
>> >
>> > Thanks
>> > Guennadi
>> > ---
>> > Guennadi Liakhovetski, Ph.D.
>> > Freelance Open-Source Software Developer
>> >
>>
>>
>>
>> --
>> Jon Smirl
>> jonsmirl@gmail.com
>>
>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
>



-- 
Jon Smirl
jonsmirl@gmail.com
