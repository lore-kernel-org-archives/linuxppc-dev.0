Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f203.google.com (mail-iw0-f203.google.com
	[209.85.223.203]) by ozlabs.org (Postfix) with ESMTP id 9A703B7D57
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 04:29:28 +1100 (EST)
Received: by iwn41 with SMTP id 41so2862423iwn.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 09:29:27 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B712DA5.4000802@petalogix.com>
References: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
	<4B712DA5.4000802@petalogix.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 10:29:07 -0700
Message-ID: <fa686aa41002090929i12b4db72we17ed52aa17bc567@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Implement refcounting for OF GPIO chips
To: michal.simek@petalogix.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Simek <monstr@monstr.eu>,
	David Brownell <dbrownell@users.sourceforge.net>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, avorontsov@ru.mvista.com,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 9, 2010 at 2:40 AM, Michal Simek <michal.simek@petalogix.com> w=
rote:
> Anton Vorontsov wrote:
>>
>> Hi all,
>>
>> OF GPIO infrastructure is using dynamic GPIO bases, so it is possible
>> that of_get_gpio()'s returned GPIO number will be no longer valid, or
>> worse, it may point to an unexpected GPIO controller.
>>
>> This scenario is possible:
>>
>> driver A: =A0 =A0 =A0 =A0 =A0 =A0 =A0 driver B: =A0 =A0 =A0 =A0 =A0 =A0 =
=A0driver C:
>> --------- =A0 =A0 =A0 =A0 =A0 =A0 =A0 --------- =A0 =A0 =A0 =A0 =A0 =A0 =
=A0---------
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpiochip_add()
>> gpio =3D of_get_gpio()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpiochip_remove()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 gpiochip_add()
>> gpio_request(gpio);
>> gpio_set_value(gpio);
>>
>> That is, driver A assumes that it is working with GPIO from driver B,
>> but in practice it may disappear and driver C will take its GPIO base
>> number, so it will provide the same GPIO numbers.
>>
>> The above situation is hard to trigger, but the issue is there
>> nonetheless, and so needs fixing.
>
>
> I tested xilinx gpio driver, heartbeat trigger and access through sysfs a=
nd
> I haven't found any problem. There is only small part of code for Microbl=
aze
> and it is the same with PowerPC. If is Ben OK with it, I am ok too.

I'm not convinced the changes take the best approach, so I'm not okay
with it yet.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
