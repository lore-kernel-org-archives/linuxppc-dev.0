From: "Robert Berger" <rber@intracom.gr>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "Miku Jha" <jha_miku@yahoo.com>, "Wolfgang Denk" <wd@denx.de>,
	"Eugene Surovegin" <ebs@ebshome.net>,
	"Robert Berger" <rber@intracom.gr>
Subject: RE: ppc440 and i2c 
Date: Tue, 18 Nov 2003 10:55:35 +0200
Message-ID: <NHEBIHHKCLHCMOJJOHNGOEGBGMAA.rber@intracom.gr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20031118082248.38F8DC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I'm neither a Linux nor a PPC expert, but I've done some work with I2C
devices.

If I understand you well, you have the following problem:
Problem:
The slave device will only release the I2C bus when the clock is restored or
when the device is temporarily powered down (most devices do not have a
reset signal that can be connected to the system reset).
To provide a clock signal on the I2C bus, there has to be a master on the
I2C bus.
The problem is that no device can be switched to master mode when the I2C
bus is busy (conform the I2C bus specification).
So a typical hardware deadlock occurs: The slave waits for the master to
generate a clock signal and the master waits for the slave to release the
bus.
Solution 1:
You can issue a number of clocks while SDA is high, so that the devices are
all out of the above-mentioned sequence.
This problem was worst with the IIC RTC, because it stayed power on when the
uP was powered down. That's why later on a reset line was added.

Solution 2:

In the read mode the slave goes high during the ACK bit, in the write mode
during the data bits.
After reset before enabling I2C you must test if both SDA and SCL= high.
If not you must clock SCL up to 9 times until SDA is released. ( This is my
favourite solution if I have direct control over the SCL and SDA pins and I
call it free clocking ).
Then you can generate a stop condition.
In multimaster applications you must watch that SCL also can be delayed by
the other master. Then you must wait until SCL = high before generating the
next clock pulse (SCL = 0, wait 5µs, test SDA == 1, SCL = 1, wait 5µs, SCL =
0 ...).

Solution 3 With "intelligent" bus master:

What if your master sends some commands to the bus at reset?
Just send some bogus commands -- the master can ignore a busy bus at reset
if it is supposed to be in charge.
Wouldn't a hosed slave reset then?
Unfortunately, sometimes you can only access the I2C bus via "intelligent"
bus master hardware.
This means that you do not have direct control over the SDA and SCL lines.
I have chosen the following solution: - Connect (wired OR) spare I/O pins
with the I2C bus lines. - When the bus is locked, Generate clock pulses on
the SCL line (via an I/O pin) until the SDA line has been released. - Send a
stop condition - Continue normal operation

I hope this helps.

Regards,

Robert


----------------------------------------------------------------------------
----
Robert Berger
Embedded Systems Software Group Leader

INTRACOM S.A.
Hellenic Telecommunications & Electronics Industry
Research and Development Division
New Technologies Dept.
Advanced Internet and Digital TV Section
P.O. Box 68, 19.5 km Markopoulo Ave. (Building A)
190 02 Peania, Athens, GREECE
Tel.: (+30 210) 667 4353, 667 9000
Fax.:(+30 210) 667 7101
email: rber@intracom.gr
URL: www.intracom.gr


"Software development is like making a baby... You can't make a baby in one
month by impregnating nine women."

"Giving up on assembly language was the apple in our Garden of Eden:
Languages whose use squanders machine cycles are sinful."
(Epigrams in Programming,  ACM SIGPLAN Sept. 1982)

My public pgp key is available at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xD432D756

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Wolfgang
Denk
Sent: Tuesday, November 18, 2003 10:23 AM
To: Eugene Surovegin
Cc: Miku Jha; linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc440 and i2c


In message <20031118080843.GA28129@gate.ebshome.net> you wrote:
>
> Your problem sounds strange.

No. It's just that this version (out of 3 different in a total  of  5
messages  to  several  mailing lists I've seen so far!) does not even
explain the problem correctly.

It's just a known issue on the I2C bus.

> Are you saying that after 440GP _reset_ IIC line state affects 440 ?

No.

> If bootstrap IIC is accidentaly activated you may get problems if you
> have non-compliant/not-properly-reset device on IIC0 bus.

The problem is an I2C Edge Condition which means that I2C devices may
be left in a write state if a read  was  occuring  and  the  CPU  was
reset. This may for example result in EEPROM data corruption.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
(null cookie; hope that's ok)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
