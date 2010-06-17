Return-Path: <c.alfred@internode.on.net>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
	[150.101.137.131]) by ozlabs.org (Postfix) with ESMTP id 43D04B7D84
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 14:25:02 +1000 (EST)
Message-ID: <DC0A9AAD98D847FC97F74D4B04C4E898@kos>
From: "Chris Alfred" <c.alfred@internode.on.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
References: <57F24E98919C4D22A784127E6CF1C9DA@kos><AANLkTimArb-UjJMe84Qrd4iNquGHEehbGW1Uciq_zGYm@mail.gmail.com>
	<EBEDB9C789D344D9A8D459B6FCB1A0AD@kos><AANLkTinBJgwL9qcw0Ouzuvc55C1Gs2KtIoY2NbBy34V2@mail.gmail.com>
	<162C87D14617439384076F797228B1EF@kos>
	<AANLkTim8kD9PH7BqOIV0GvElIfOgUDMw1VfWcOJhj-8r@mail.gmail.com>
Subject: Re: Porting a driver to powerpc using FDT
Date: Thu, 17 Jun 2010 14:25:00 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>> dsa_of_init is successfully called; but dsa_of_probe is not 
>>>> called.
>>>
>>> That means the node is not being used to register an of_device. I
>>> need some more information to suggest how best to fix this.
>>
>>> What SoC are you using?
>>> What file in arch/powerpc/platforms/* is used to setup your 
>>> machine?
>>
>> We are using the MPC5200. Very similar to the Lite5200.
>
> So you're board is driver by
> arch/powerpc/platforms/52xx/mpc5200_simple.c then?

The Lite5200 is based on arch/powerpc/platforms/52xx/lite5200.c

We have only done a text search/replace lite5200 to jkc5200.
Based on your email, we have now also changed fsl,jkc5200n8 to 
jkc,jkc5200n8

> As mentioned, drop the reg property and be more specific in the
> compatible value.

Done, changed fsl,jkc5200n8 to jkc,jkc5200n8

> If you do the
> following, then it should start working:
>
> virtual-devices {
>         compatible = "simple-bus";
>         dsa {
>               compatible = "<vendor>,jkc5200n8-dsa";
>         };
> };

Where did "simple-bus" come from?

Did you mean "mpc5200-simple-platform" from:

    define_machine(mpc5200_simple_platform) {
     .name  = "mpc5200-simple-platform",

     ...
    };

> You can look under /sys/devices to see if your device actually gets
> registered or not.

Not there unfortunately, and probe is still not called.

Regards,
Chris
