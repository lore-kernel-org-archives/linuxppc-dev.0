Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 849B5DDFCC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 01:48:10 +1000 (EST)
Message-ID: <471E179F.6050605@scram.de>
Date: Tue, 23 Oct 2007 17:47:43 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH take2] [POWERPC] i2c: adds support for i2c bus on 8xx
References: <47134A94.60606@scram.de>	<20071015183107.GA4361@loki.buserror.net>	<47166085.1010608@scram.de>
	<20071017230027.334a5f48@hyperion.delvare>
In-Reply-To: <20071017230027.334a5f48@hyperion.delvare>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org,
	i2c@lm-sensors.org, Carsten Juttner <carjay@gmx.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jean,

> On Wed, 17 Oct 2007 21:20:37 +0200, Jochen Friedrich wrote:
>>>> +	/* Select an arbitrary address.  Just make sure it is unique.
>>>> +	 */
>>>> +	out_8(&i2c->i2c_i2add, 0xfe);
>>>>     
>>> It's a 7-bit address...  and are you sure that 0x7e is unique?  Does this
>>> driver even support slave operation?
>>>   
>> It's in fact 0x7F << 1. The same value is used in the 2.4 driver and
>> in u-boot, as well. Slave operation is not supported.
> 
> I'm not sure what exactly you are doing here, but 0x7f isn't a valid
> 7-bit I2C address.

That's most probably the reason why it is used everywhere in the CPM world
(old driver, u-boot) ;-)

According to the documentation, the CPM enters a loopback mode as soon
as a write access to the I2C address written to i2c_i2add takes place.
This even happens if the CPM is set to master mode. So the only way to make
sure there are no limitations to the I2C addresses which can be used is to
use this invalid address. 0x00 can't be used either or no I2C broadcasts
would be possible.

>From the MPC-823 documentation:

16.13.3.1.3 I2C Loopback Configuration. Loopback on the I2C controller is a
special part of master mode operation with a device that does not contain
internal addresses. Refer to Figure 16-127 for more information. To begin a
loopback transmission, you must prepare a TX buffer descriptor with a data
buffer N+1 bytes long, where N is the number of data bytes to be written back
to the I2C controller. You must also prepare one or more RX buffer descriptors
to receive the N bytes of data. The first byte of the TX buffer descriptor
must contain the address of the MPC823 I2C device’s own address, which is in
the I2CADD register, followed by the write bit asserted (R/W = 0). The
remaining N bytes of the TX buffer descriptor contain the data to be sent and
received by the I2C controller. Next, set the R bit in the TX buffer descriptor
and the E bit in the RX buffer descriptor. Then set the W and L bits in the TX
buffer descriptor. Setting the L bit causes a stop condition to be issued after
this buffer is transmitted to conclude the operation. Set the I bit in the TX
and RX buffer descriptors to enable the transmission and reception status to be
updated in the I2CE register and to enable I2C transmit and receive interrupts
to the core. You must then set the STR bit in the I2COM register to initiate
the loopback operation.

Thanks,
Jochen
