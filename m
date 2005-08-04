Return-Path: <kate@katix.org>
Received: from ns.iti.fi (unknown [195.218.81.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B26F767D95
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 18:08:46 +1000 (EST)
Message-ID: <52060.192.100.124.219.1123142844.squirrel@www.iti.fi>
Date: Thu, 4 Aug 2005 11:07:24 +0300 (EEST)
From: "Kate Alhola" <kate@katix.org>
To: <yuli@arabellasw.com>
In-Reply-To: <17136.47842.293993.900265@astp0002.localdomain>
References: <528646bc050723070419b8f914@mail.gmail.com>
	<17124.46441.807442.139506@astp0002.localdomain>
	<63137.192.100.124.219.1122287941.squirrel@www.iti.fi>
	<17124.61231.988084.399036@astp0002.localdomain>
	<528646bc0507281025661032ba@mail.gmail.com>
	<17136.47842.293993.900265@astp0002.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 0/3] Support for SPI busses and devices
Reply-To: kate@katix.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> The current I2C subsystem is not perfect but it's well established and
> used by different user-space applications. Changing the interfaces for
> SPI means that all the applications for SPI-connected peripherals must
> be developed more or less from scratch. Almost every serial EEPROM or
> temperature sensor exists in both I2C and SPI versions, and I don't
> think we'd like to have separate applications for these two
> versions. The I2C subsystem will be updated sooner or later to match
> current coding conventions, etc. If SPI will be part of this subsystem,
> it will get all that updates. My changes work well for our customers
> with a range of SPI devices (EEPROMs, temperature sensors, RTC, I even
> wrote driver for MMC card in SPI mode).

At the first, implementation that i used, has same interface as I2C because
it is based on I2C but with some extensions needed for SPI. The idea
is not to make it as incompatible with I2C. There are here are some devices
that can be used exactly same API but also some others that are
needing extended API. The CS logic is mostly one that needs extensions,
not. The converting I2C address to just one HW defined CS signal that goes
low in beginning of transaction and raises up in end is clearly not
sufficent in many cases.

Other cases may be devices that need to have CS active continuously
during multiple short transactions ( like MMC card Statuc polling ),
some that needs diferent behavior like CS is just latch pulse issued
after transaction etc. Some devices transfer like 16 bits word where
first 4 bits are send and 12 recive so there is not byte bordered
send/receive transfer etc.

I think that the good solition should preserve existing I2C API but should
also have enough extensions to support all kind of SPI devices.



Kate
