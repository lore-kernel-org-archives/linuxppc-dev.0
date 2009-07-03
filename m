Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 11C6AB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 17:01:49 +1000 (EST)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 5E0B3DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 17:01:47 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 5so982024qwd.15
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Jul 2009 00:01:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090618142610.GC10629@pengutronix.de>
References: <20090618025030.12363.69402.stgit@localhost.localdomain>
	<20090618065814.GA12942@pengutronix.de>
	<fa686aa40906180635g45724119x99cd4d1e4ede59f9@mail.gmail.com>
	<20090618142610.GC10629@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 3 Jul 2009 01:01:24 -0600
Message-ID: <fa686aa40907030001r731d3d29h3873803d588cdf15@mail.gmail.com>
Subject: Re: [spi-devel-general] [PATCH v4] powerpc/5200: Add mpc5200-spi
	(non-PSC) device driver
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 18, 2009 at 8:26 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:
>> There used to be a sysfs interface for dumping these, but it was an
>> ugly misuse. =A0I'd like to leave these in. =A0I still have the sysfs bi=
ts
>> in a private patch and I'm going to rework them for debugfs.
>
> Okay. Maybe a comment stating the future use will be nice.

okay

>> > But I wonder more about the usage of the SS pin and if this chipsel is=
 needed
>> > at all (sadly I cannot test as I don't have any board with SPI connect=
ed to
>> > that device). You define the SS-pin as output, but do not set the SSOE=
-bit.
>> > More, you use the MODF-feature, so the SS-pin should be defined as inp=
ut?
>> > According to Table 17.3 in the PM, you have that pin defined as generi=
c purpose
>> > output.
>>
>> That's right. =A0The SS handling by the SPI device is completely
>> useless, so this driver uses it as a GPIO and asserts it manually.
>
> That definately needs a comment :D (perhaps with some more details if you=
 know them).
>
>> The MODF irq is probably irrelevant, but I'd like to leave it in for
>> completeness.
>
> But it won't work if the pin is set to output, no?

yes

> Are you sure there are no side-effects?

I'm sure.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
