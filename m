Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EFD667D29
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 23:55:18 +1000 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17124.61231.988084.399036@astp0002.localdomain>
Date: Mon, 25 Jul 2005 16:54:55 +0300
To: kate@katix.org
In-Reply-To: <63137.192.100.124.219.1122287941.squirrel@www.iti.fi>
References: <528646bc050723070419b8f914@mail.gmail.com>
	<17124.46441.807442.139506@astp0002.localdomain>
	<63137.192.100.124.219.1122287941.squirrel@www.iti.fi>
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

    Yuli> SPI is very similar to I2C IMHO. I'm not sure separate
    Yuli> infrastructure is needed. We support SPI on MPC8xx/82xx/85xx
    Yuli> using the standard I2C infrastructure. I only had to add a
    Yuli> couple of IOCTLs to control clock frequency and polarity. Due
    Yuli> to such an implementation, lm-sensors work OK with SPI
    Yuli> temperature sensors, for example.

    Kate> SPI IS wery similar than I2C and for this reason it looks a
    Kate> like that all SPI subsystems implementations are based on I2C
    Kate> code.

    Kate> The Clock frequency and polarity is not enough, as mentioned
    Kate> also then addressing target chip is completelly diferent. It
    Kate> is done with separate PIO lines instead address send in serial
    Kate> line.  The CS handling is also in HW level completelly
    Kate> independent to the srerial line driver but of cource need to
    Kate> me synchronized with it.  This means that there should be
    Kate> logic to handle this CS stuff as addition of serial code.

    Kate> I2C subsystem does not have any kind of support of CS
    Kate> handlinng and for this reason i chosen to make modified
    Kate> version of I2C subsystem with additions needed for SPI.

As you understand, CS is handled in our code: otherwise nothing would
work. Since CS handling is board-specific, only board-specific files
(platforms/xxx for PPC) can provide appropriate functions. I wanted to
preserve interfaces (otherwise I would have to rewrite all relevant
user-space applications, like lm-sensors), so SPI controllers drivers
(master_xfer method) simply call function

  int spi_cs(struct i2c_adapter *adap, u16 slave, int assert_cs)

before and after each transaction. The function is implemented for each
SPI-enabled board in that board's specific file. Slave address,
meaningless for SPI, is used to identify the peripheral. The function
asserts or negates the selected slave's chip select. Slave address is
just a unique ID, assigned by the programmer with the sole purpose of
telling the spi_cs function which peripheral is to be
selected/deselected. The function, since it's board-specific, "knows"
how to do this i.e. how to access parallel ports, FPGAs, or whatever is
necessary on that specific board to activate chip select.

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
