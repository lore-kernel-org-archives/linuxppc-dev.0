Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BDB0567B3D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 07:46:57 +1000 (EST)
Date: Fri, 3 Jun 2005 14:46:54 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Randy Vinson <rvinson@mvista.com>
Message-ID: <20050603214653.GA15314@gate.ebshome.net>
References: <42A0CD46.60300@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42A0CD46.60300@mvista.com>
Cc: Greg KH <greg@kroah.com>, sensors@stimpy.netroedge.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/2] Add support for Maxim/Dallas DS1374 Real-Time Clock
	Chip
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jun 03, 2005 at 02:36:06PM -0700, Randy Vinson wrote:
> Greetings,
>  I've put together a small I2C client for the Maxim/Dallas DS1374 RTC
> chip and tested it on a Freescale MPC8349ADS board that uses the chip.
> The attached patch adds support for the chip itself and a follow-up patch
> will add support to the Freescale board.

[snip]

> +	down(&ds1374_mutex);
> +
> +	/*
> +	 * Since the reads are being performed one byte at a time using
> +	 * the SMBus vs a 4-byte i2c transfer, there is a chance that a
> +	 * carry will occur during the read. To detect this, 2 reads are
> +	 * performed and compared.
> +	 */
> +	do {
> +		t1 = ds1374_read_rtc();
> +		t2 = ds1374_read_rtc();
> +	} while (t1 != t2 && limit--);

I wonder, why you chose to use those 1-byte SMBus transfers instead of 
i2c transfer.

I wrote similar DS1374 driver some time ago which used those transfers 
and they worked just fine.

-- 
Eugene
