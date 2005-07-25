Return-Path: <kate@katix.org>
Received: from ns.iti.fi (unknown [195.218.81.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE78067CA2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 20:39:07 +1000 (EST)
Received: from ns.iti.fi (localhost.localdomain [127.0.0.1])
	by ns.iti.fi (8.12.8/8.12.8) with ESMTP id j6PAd2ED015414
	for <linuxppc-embedded@ozlabs.org>; Mon, 25 Jul 2005 13:39:02 +0300
Message-ID: <63137.192.100.124.219.1122287941.squirrel@www.iti.fi>
Date: Mon, 25 Jul 2005 13:39:01 +0300 (EEST)
From: "Kate Alhola" <kate@katix.org>
To: <linuxppc-embedded@ozlabs.org>
In-Reply-To: <17124.46441.807442.139506@astp0002.localdomain>
References: <528646bc050723070419b8f914@mail.gmail.com>
	<17124.46441.807442.139506@astp0002.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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


>
> SPI is very similar to I2C IMHO. I'm not sure separate infrastructure is
> needed. We support SPI on MPC8xx/82xx/85xx using the standard I2C
> infrastructure. I only had to add a couple of IOCTLs to control clock
> frequency and polarity. Due to such an implementation, lm-sensors work
> OK with SPI temperature sensors, for example.

SPI IS wery similar than I2C and for this reason it looks a like
that all SPI subsystems implementations are based on I2C code.

The Clock frequency and polarity is not enough, as mentioned also
then addressing target chip is completelly diferent. It is done
with separate PIO lines instead address send in serial line.
The CS handling is also in HW level completelly independent
to the srerial line driver but of cource need to me synchronized with it.
This means that there should be logic to handle this CS stuff as
addition of serial code.

I2C subsystem does not have any kind of support of CS handlinng and
for this reason i chosen to make modified version of I2C subsystem
with additions needed for SPI.


Kate
