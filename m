Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id A51711007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Jun 2010 00:55:48 +1000 (EST)
Received: by gxk5 with SMTP id 5so1343gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 07:55:47 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <DC0A9AAD98D847FC97F74D4B04C4E898@kos>
References: <57F24E98919C4D22A784127E6CF1C9DA@kos>
	<AANLkTimArb-UjJMe84Qrd4iNquGHEehbGW1Uciq_zGYm@mail.gmail.com>
	<EBEDB9C789D344D9A8D459B6FCB1A0AD@kos>
	<AANLkTinBJgwL9qcw0Ouzuvc55C1Gs2KtIoY2NbBy34V2@mail.gmail.com>
	<162C87D14617439384076F797228B1EF@kos>
	<AANLkTim8kD9PH7BqOIV0GvElIfOgUDMw1VfWcOJhj-8r@mail.gmail.com>
	<DC0A9AAD98D847FC97F74D4B04C4E898@kos>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 17 Jun 2010 08:55:27 -0600
Message-ID: <AANLkTim6YGVdQrJ0lQIbceWgxIwMAyJjLxwyDP8IYt7I@mail.gmail.com>
Subject: Re: Porting a driver to powerpc using FDT
To: Chris Alfred <c.alfred@internode.on.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 16, 2010 at 10:25 PM, Chris Alfred
<c.alfred@internode.on.net> wrote:
>>>>> dsa_of_init is successfully called; but dsa_of_probe is not
>>>>> called.
>>>>
>>>> That means the node is not being used to register an of_device. I
>>>> need some more information to suggest how best to fix this.
>>>
>>>> What SoC are you using?
>>>> What file in arch/powerpc/platforms/* is used to setup your
>>>> machine?
>>>
>>> We are using the MPC5200. Very similar to the Lite5200.
>>
>> So you're board is driver by
>> arch/powerpc/platforms/52xx/mpc5200_simple.c then?
>
> The Lite5200 is based on arch/powerpc/platforms/52xx/lite5200.c
>
> We have only done a text search/replace lite5200 to jkc5200.
> Based on your email, we have now also changed fsl,jkc5200n8 to
> jkc,jkc5200n8

Unless you need to add a bunch of board specific setup, you shouldn't
need to do this.  It should be sufficient to add jkc,jkc5200n8 to the
list of boards in mpc5200_simple.c.  The Lite5200 has a separate board
file because the original u-boot firmware for it didn't setup clocks
or port_config correctly.  Almost every other board uses
mpc5200_simple.c

media5200 is the other exception because it needs to add a whole other
irq controller.

>> As mentioned, drop the reg property and be more specific in the
>> compatible value.
>
> Done, changed fsl,jkc5200n8 to jkc,jkc5200n8
>
>> If you do the
>> following, then it should start working:
>>
>> virtual-devices {
>> =A0 =A0 =A0 =A0 compatible =3D "simple-bus";
>> =A0 =A0 =A0 =A0 dsa {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "<vendor>,jkc5200n8-dsa";
>> =A0 =A0 =A0 =A0 };
>> };
>
> Where did "simple-bus" come from?
>
> Did you mean "mpc5200-simple-platform" from:
>
> =A0 =A0define_machine(mpc5200_simple_platform) {
> =A0 =A0 .name =A0=3D "mpc5200-simple-platform",

No, mpc5200-simple-platform is just a name shown to users.  It doesn't
actually match against anything in the device tree.

"simple-bus" means that a node represents a simple transparent bridge
device.  Linux uses that value to decide that the bus node contains
device nodes that it should register.  Take a look at the ePAPR spec.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
