Message-ID: <8D7C5F56B409554D9D46AC22195807F3061B46@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'bart@ardistech.com'" <bart@ardistech.com>,
	Christian Schroeder <christian.schroeder@imms.de>
Cc: linuxppc-embedded@lists.linuxppc.org, reklies@mazet.de,
	linz@mazet.de
Subject: RE: Microcode patching
Date: Sat, 9 Nov 2002 05:12:07 +1300 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is simply not true.  Fix the bugs in the 8xx I2C driver and you will be
amazed how much better the hardware assisted I2C driver works.  I must say I
have never used the algo-8xx I2C driver but hardware I2C works very well.
Even if you suspend the task and let other tasks run while waiting for the
I2C transaction to complete.  Allowing a EEPROM read or write to complete
without having to bit bash the I2C is so much easier.

Regards,
Rod

 -----Original Message-----
From: 	bart@ardistech.com [mailto:bart@ardistech.com]
Sent:	Friday, November 08, 2002 7:17 AM
To:	Christian Schroeder
Cc:	linuxppc-embedded@lists.linuxppc.org; reklies@mazet.de;
linz@mazet.de
Subject:	Re: Microcode patching


Hi Christian,

Far the easiest way is to bit-bash the IIC with software and not use
the CPM for this. As pointed out earlier in the list there is not much
gained by using the CPM for IIC if your transfer sizes are small. Not
to speak of the many bugs in the algo-8xx driver.

Regards,
	Bart

> I've got a question regarding the mpc8xx microcode patches in
> arch/ppc/8xx_io/micropatch.c. We do need usb host mode, i2c and
> ethernet operation at the same time. As I understood, i can't load
> the microcode patches for usb sof generation and iic/spi together,
> because they "live" at the same address. Now my question: What occurs
> if I don't load the ii2/spi patch. I do need the usb sof timing, but
> does the i2c-Interface work without the iic/spi patch ? As I read on
> the motorola webserver, the iic/spi is needed for concurrent operation
> of scc ethernet and i2c. Does i2c work correctly without the patch if
> I don't use ethernet ?
>
> Greetings
> Christian Schroeder
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
