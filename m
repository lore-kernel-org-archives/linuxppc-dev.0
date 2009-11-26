Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id 69567B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 05:50:29 +1100 (EST)
Received: by gxk23 with SMTP id 23so495348gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 10:50:27 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091126184157.GA16607@oksana.dev.rtsoft.ru>
References: <200911161742.46663.to-fleischer@t-online.de>
	<200911211708.47253.to-fleischer@t-online.de>
	<fa686aa40911241633q38dc0cf8x8b23038fe2fdf10d@mail.gmail.com>
	<200911252141.59549.to-fleischer@t-online.de>
	<fa686aa40911251411t13dd0131od6b497399641ce3d@mail.gmail.com>
	<20091126121204.GA3558@oksana.dev.rtsoft.ru>
	<fa686aa40911261016p489981a2g1fac393264c4d1c7@mail.gmail.com>
	<20091126184157.GA16607@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 26 Nov 2009 11:50:05 -0700
Message-ID: <fa686aa40911261050g3f7ae231mc82c41f058ff8530@mail.gmail.com>
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

On Thu, Nov 26, 2009 at 11:41 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Nov 26, 2009 at 11:16:34AM -0700, Grant Likely wrote:
> [...]
>> The spi-cs-high property is defined in
>> Documentation/powerpc/dts-bindings/spi-bus.txt, but it definitely was
>> a mistake
>
> Yup.
>
>> Currently the spi-cs-high property is parsed in the
>> of_register_spi_devices() function, but the CS polarity needs to be
>> known before registering devices. =A0It needs to be factored out into
>> another utility function callable by spi bus drivers so that it can
>> get polarity data at probe time.
>
> Untill we have this, Torsten's patch is a real improvement, and
> works for non-broken hw/fw.
>
> So I think it should be applied.

I disagree since it only band-aids the problem and uglifies the driver
in the process.  In the immediate term the driver needs to be changed
to read the spi-cs-high property out of the child nodes before
registering the devices.  I'm not going to apply this patch.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
