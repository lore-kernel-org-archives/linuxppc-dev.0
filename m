Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 489B22BDA6
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2004 06:08:12 +1000 (EST)
To: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 23 Sep 2004 18:06:39 -0000."
	<OF4E11986A.DD692D61-ON00256F18.005010DC-00256F18.00637C77@marel.is>
Date: Thu, 23 Sep 2004 22:07:57 +0200
Sender: wd@denx.de
Message-Id: <20040923200802.56313C108D@atlas.denx.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: MPC5200 with PCF8563 RTC 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Jón,

in message <OF4E11986A.DD692D61-ON00256F18.005010DC-00256F18.00637C77@marel.is> you wrote:
> 
> I am working on porting linux to a custom board based on MPC5200, which 
> has a PCF8563 real time clock connected via i2c2_io and i2c2_clk pins.
> It looks like this same combination is used on the PM520 board.

Indeed.

> I am however having a more difficult time getting the linux kernel 
> (linuxppc_2_4_devel from Denx) to work with PCF8563.  I get errors from 
> rtc_rd( ), but I
> can't understand why.  I have compared the i2c clock signals between 

It works fine on the PM520...

...
> Calibrating delay loop (skipped)... 0.05 BogoMIPS

Seems to be misconfigured?

> i2c-core.o: i2c core module version 2.6.1 (20010830)
> i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)
> i2c-proc.o version 2.6.1 (20010830)
^^^^^^^^^^^^^

Compare your configuration against the  PM520;  we  don't  have  this
enabled.

...
> i2c-core.o: client [PCF8563] registered to adapter [PM520 I2C module #2 interface](pos. 0).

I don't see this either.

> RTC switching kernel pointers

Before the i2c-algo-5xxx.o was initialized??

> i2c-algo-5xxx.o: scanning bus PM520 I2C module #2 interface...
> (0x00)(0x01)(0x02)(0x03)(0x04)(0x05)(0x06)(0x07)(0x08)(0x09)(0x0a)(0x0b)(0x0c)(0
> x0d)(0x0e)(0x0f)(0x10)(0x11)(0x12)(0x13)(0x14)(0x15)(0x16)(0x17)(0x18)(0x19)(0x1
> a)(0x1b)(0x1c)(0x1d)(0x1e)(0x1f)(0x20)(0x21)(0x22)(0x23)(0x24)(0x25)(0x26)(0x27)
> (0x28)(0x29)(0x2a)(0x2b)(0x2c)(0x2d)(0x2e)(0x2f)(0x30)(0x31)(0x32)(0x33)(0x34)(0
> x35)(0x36)(0x37)(0x38)(0x39)(0x3a)(0x3b)(0x3c)(0x3d)(0x3e)(0x3f)(0x40)(0x41)(0x4
> 2)(0x43)(0x44)(0x45)(0x46)(0x47)(0x48)(0x49)(0x4a)(0x4b)(0x4c)(0x4d)(0x4e)(0x4f)
> (0x50)(0x51)(0x52)(0x53)(0x54)(0x55)(0x56)(0x57)(0x58)(0x59)(0x5a)(0x5b)(0x5c)(0
> x5d)(0x5e)(0x5f)(0x60)(0x61)(0x62)(0x63)(0x64)(0x65)(0x66)(0x67)(0x68)(0x69)(0x6
> a)(0x6b)(0x6c)(0x6d)(0x6e)(0x6f)(0x70)(0x71)(0x72)(0x73)(0x74)(0x75)(0x76)(0x77)
> (0x78)(0x79)(0x7a)(0x7b)(0x7c)(0x7d)(0x7e)(0x7f)
> i2c-pm520.o: I2C module #2 installed

Ummm... you should see only existing devices here, something like this:

i2c-algo-5xxx.o: scanning bus PM520 I2C module #2 interface...
........................................................................................(0x58)(0x59)(0x5a)(0x5b)(0x5c)(0x5d)(0x5e)(0x5f)...............................(0x7f)
i2c-pm520.o: I2C module #2 installed


> eth0: status: link up, 100 Mbps Half Duplex.
                                  ^^^^^^^^^^^^
Is this correct?

> Content-Type: text/html; charsetÿSO-8859-1"
> Content-Transfer-Encoding: quoted-printable

Please don't post HMTL to mailing lists.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A Chairman was as necessary to a Board planet  as  the  zero  was  in
mathematics, but being a zero had big disadvantages...
                         - Terry Pratchett, _The Dark Side of the Sun_
