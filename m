Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 6EB451007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 06:17:56 +1100 (EST)
Received: by ywh17 with SMTP id 17so944742ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 11:17:55 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091126190101.GA19404@oksana.dev.rtsoft.ru>
References: <200911161742.46663.to-fleischer@t-online.de>
	<200911211708.47253.to-fleischer@t-online.de>
	<fa686aa40911241633q38dc0cf8x8b23038fe2fdf10d@mail.gmail.com>
	<200911252141.59549.to-fleischer@t-online.de>
	<fa686aa40911251411t13dd0131od6b497399641ce3d@mail.gmail.com>
	<20091126121204.GA3558@oksana.dev.rtsoft.ru>
	<fa686aa40911261016p489981a2g1fac393264c4d1c7@mail.gmail.com>
	<20091126184157.GA16607@oksana.dev.rtsoft.ru>
	<fa686aa40911261050g3f7ae231mc82c41f058ff8530@mail.gmail.com>
	<20091126190101.GA19404@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 26 Nov 2009 12:17:35 -0700
Message-ID: <fa686aa40911261117y4744e56bmf4d1d8260c7a51d0@mail.gmail.com>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Torsten Fleischer <to-fleischer@t-online.de>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 26, 2009 at 12:01 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Nov 26, 2009 at 11:50:05AM -0700, Grant Likely wrote:
>> On Thu, Nov 26, 2009 at 11:41 AM, Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>> > On Thu, Nov 26, 2009 at 11:16:34AM -0700, Grant Likely wrote:
>> > [...]
>> >> The spi-cs-high property is defined in
>> >> Documentation/powerpc/dts-bindings/spi-bus.txt, but it definitely was
>> >> a mistake
>> >
>> > Yup.
>> >
>> >> Currently the spi-cs-high property is parsed in the
>> >> of_register_spi_devices() function, but the CS polarity needs to be
>> >> known before registering devices. =A0It needs to be factored out into
>> >> another utility function callable by spi bus drivers so that it can
>> >> get polarity data at probe time.
>> >
>> > Untill we have this, Torsten's patch is a real improvement, and
>> > works for non-broken hw/fw.
>> >
>> > So I think it should be applied.
>>
>> I disagree since it only band-aids the problem and uglifies the driver
>> in the process. =A0In the immediate term the driver needs to be changed
>> to read the spi-cs-high property out of the child nodes before
>> registering the devices.
>
> Hm. I thought we agreed that spi-cs-high is not good? Why do you
> encourage using it then? We'll have to uglify the driver with
> legacy device-tree handling code.

spi-cs-high is definitely not a complete solution, but it isn't
actively evil either.  Plus it is documented and (presumably) in
active use. so support for it should not be dropped.

Regardless, there needs to be a library function for parsing all the
SPI child nodes and returning the active state for each GPIO chip
select.  All the code for parsing the old spi-cs-high properties can
be contained in the same place as a new yet-to-be-defined bus node cs
polarity property.  The rework to the driver itself is not ugly.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
