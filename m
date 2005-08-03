Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D829867E48
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 22:39:26 +1000 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17136.47842.293993.900265@astp0002.localdomain>
Date: Wed, 3 Aug 2005 15:38:58 +0300
To: Grant Likely <glikely@gmail.com>
In-Reply-To: <528646bc0507281025661032ba@mail.gmail.com>
References: <528646bc050723070419b8f914@mail.gmail.com>
	<17124.46441.807442.139506@astp0002.localdomain>
	<63137.192.100.124.219.1122287941.squirrel@www.iti.fi>
	<17124.61231.988084.399036@astp0002.localdomain>
	<528646bc0507281025661032ba@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 0/3] Support for SPI busses and devices
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> Grant Likely writes:

    Yuli> SPI is very similar to I2C IMHO. I'm not sure separate
    Yuli> infrastructure is needed. We support SPI on MPC8xx/82xx/85xx
    Yuli> using the standard I2C infrastructure. I only had to add a
    Yuli> couple of IOCTLs to control clock frequency and polarity. Due
    Yuli> to such an implementation, lm-sensors work OK with SPI
    Yuli> temperature sensors, for example.

    Kate> SPI IS wery similar than I2C and for this reason it looks a
    Kate> like that all SPI subsystems implementations are based on I2C
    Kate> code.

    Grant> Thanks for the comments everyone.  I had seen the first cut
    Grant> at an SPI subsystem on the lkml, but I hadn't seen the
    Grant> revised patch.  My understanding from GregKH's comments on
    Grant> the first patch is that i2c is a bit of a mess:

    Grant> From http://lkml.org/lkml/2005/5/31/251
    Grant> "The i2c dev interface is a mess, please don't duplicate it,
    Grant> there is no need to do so."

    Grant> What is current opinion on the i2c subsystem?  Did I
    Grant> misunderstand Greg's I2C comments?  I put together the SPI
    Grant> patch as an alternative implementation that matches the
    Grant> current coding conventions (as I understand them).

The current I2C subsystem is not perfect but it's well established and
used by different user-space applications. Changing the interfaces for
SPI means that all the applications for SPI-connected peripherals must
be developed more or less from scratch. Almost every serial EEPROM or
temperature sensor exists in both I2C and SPI versions, and I don't
think we'd like to have separate applications for these two
versions. The I2C subsystem will be updated sooner or later to match
current coding conventions, etc. If SPI will be part of this subsystem,
it will get all that updates. My changes work well for our customers
with a range of SPI devices (EEPROMs, temperature sensors, RTC, I even
wrote driver for MMC card in SPI mode).

    Grant> Yuli, are there any plans to submit your i2c changes to
    Grant> support SPI back to mainline?

I have no problem to submit the changes though I'm not sure to what list
to send them. All the changes in fact are just a couple of
defines. Unfortunately, I've got no enough time to follow all the
relevant lists.

    Grant> I've now got to go back and review the revised SPI patch on
    Grant> the LKML.

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
