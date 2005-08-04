Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D42067EBB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 00:45:49 +1000 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17138.10754.817300.519925@astp0002.localdomain>
Date: Thu, 4 Aug 2005 17:45:22 +0300
To: kate@katix.org
In-Reply-To: <52060.192.100.124.219.1123142844.squirrel@www.iti.fi>
References: <528646bc050723070419b8f914@mail.gmail.com>
	<17124.46441.807442.139506@astp0002.localdomain>
	<63137.192.100.124.219.1122287941.squirrel@www.iti.fi>
	<17124.61231.988084.399036@astp0002.localdomain>
	<528646bc0507281025661032ba@mail.gmail.com>
	<17136.47842.293993.900265@astp0002.localdomain>
	<52060.192.100.124.219.1123142844.squirrel@www.iti.fi>
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

>>>>> Kate Alhola writes:

    Yuli> The current I2C subsystem is not perfect but it's well
    Yuli> established and used by different user-space
    Yuli> applications. Changing the interfaces for SPI means that all
    Yuli> the applications for SPI-connected peripherals must be
    Yuli> developed more or less from scratch. Almost every serial
    Yuli> EEPROM or temperature sensor exists in both I2C and SPI
    Yuli> versions, and I don't think we'd like to have separate
    Yuli> applications for these two versions. The I2C subsystem will be
    Yuli> updated sooner or later to match current coding conventions,
    Yuli> etc. If SPI will be part of this subsystem, it will get all
    Yuli> that updates. My changes work well for our customers with a
    Yuli> range of SPI devices (EEPROMs, temperature sensors, RTC, I
    Yuli> even wrote driver for MMC card in SPI mode).

    Kate> At the first, implementation that i used, has same interface
    Kate> as I2C because it is based on I2C but with some extensions
    Kate> needed for SPI. The idea is not to make it as incompatible
    Kate> with I2C. There are here are some devices that can be used
    Kate> exactly same API but also some others that are needing
    Kate> extended API. The CS logic is mostly one that needs
    Kate> extensions, not.

Mostly yes. Another useful extension is clock frequency control and this
extension would be useful for I2C too because there are I2C controllers
which allow for variable clock settings, not only 100/400KHz
(PowerQUICCs, for example). All this IMHO does not justify developing of
a separate SPI subsystem.

    Kate> The converting I2C address to just one HW defined CS signal
    Kate> that goes low in beginning of transaction and raises up in end

I didn't say this. I said that the CS handling function is called in the
beginning and in the end. What it does is board-dependent in any case
because even CS implementation itself is board-specific (processor GPIO,
FPGA, external register, etc.).

    Kate> is clearly not sufficent in many cases.

It's not so clear to me and some examples of such cases would help.

    Kate> Other cases may be devices that need to have CS active
    Kate> continuously during multiple short transactions ( like MMC
    Kate> card Statuc polling ),

For the MMC case, this simply is not true. You don't have to assert CS
continuously but only during the status read. After the read, you can
de-assert CS, and assert it again on next poll. Between the polls, you
can assert other CSs to work with other chips connected to the same
bus. For me, the fact that my MMC driver works OK is a good proof that
CS handling is not a problem in case of MMC card. This does not mean, of
course, that there can't be peripherals which require keeping CS
asserted during several transactions. This case is not different from
I2C peripherals which require no START condition between
transactions. As you know, there is a flag in I2C (I2C_M_NOSTART) which
means "do not generate start condition". There are also flags for
handling other special conditions (I2C_M_NO_RD_ACK, I2C_M_IGNORE_ACK,
etc.). The same approach is good for SPI IMHO - flags in the message
header which alters CS behaviour.

    Kate> some that needs diferent behavior like CS is just latch pulse
    Kate> issued after transaction etc. Some devices transfer like 16
    Kate> bits word where first 4 bits are send and 12 recive so there
    Kate> is not byte bordered send/receive transfer etc.

How is this connected to the CS issue? There is only one clock for both
receive and transmit so the number of received and transmitted bits is
identical though some of these bits should be ignored.

    Kate> I think that the good solition should preserve existing I2C
    Kate> API but should also have enough extensions to support all kind
    Kate> of SPI devices.

Yes. Does this mean that we have to clone entire I2C subsystem and
slightly modify it or it's enough to extend the I2C to handle SPI too?

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
