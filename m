Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc2-s8.bay0.hotmail.com (bay0-omc2-s8.bay0.hotmail.com
	[65.54.246.144]) by ozlabs.org (Postfix) with ESMTP id 744A3DDED1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 11:54:57 +1000 (EST)
Message-ID: <BLU119-DAV9BAEF385061105909DC9FBB840@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: "Scott Wood" <scottwood@freescale.com>
References: <BLU119-DAV11096F9EACC27956DCC87BBB8F0@phx.gbl>
	<58A20A281BAF1047B4EAE68DE5C0BDC2010573E9@zch01exm21.fsl.freescale.net>
	<BLU119-DAV61F2F984D2E145D1E4AA1BB8F0@phx.gbl>
	<20080722175508.GA13940@loki.buserror.net>
Subject: Re: Failure of request_irq()  for MPC8313 using arch=powerpc
Date: Tue, 22 Jul 2008 18:54:50 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Cc: Liu Dave <DaveLiu@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Scott,

I forgot to mention that I have less error if I use the existing device node 
"spi" in the DTS file

# Start of error capture

Got device node from device tree
Got Virtual IRQ
PPC : interrupt hook failed (-22)

# End of capture

So it's able to access the device node and to map "virq" while I had total 
failure in using "gpio" I put into DTS

I must make mistake in creating the node "gpio" in the DTS file

I'm using FreeScale Eva board MPC8313ERDB

Thanks,

Duy-Ky

----- Original Message ----- 
From: "Scott Wood" <scottwood@freescale.com>
To: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
Cc: "Liu Dave" <DaveLiu@freescale.com>; <linuxppc-embedded@ozlabs.org>
Sent: Tuesday, July 22, 2008 10:55 AM
Subject: Re: Failure of request_irq() for MPC8313 using arch=powerpc


> On Tue, Jul 15, 2008 at 08:43:59PM -0700, Duy-Ky Nguyen wrote:
>> Hi Dave,
>>
>> I've just tried it and it failed.
>
> Could you elaborate on exactly what you tried?  Did you pass the GPIO 
> device
> tree node?
>
>> Before I had tried using the function
>> int virq = of_irq_to_resource(GPIO_IRQ, 0, NULL);
>> and it failed the same way
>
> The first argument of of_irq_to_resource is a device node pointer, not an
> IRQ number.  Surely the compiler warned you about this.
>
> -Scott
> 
