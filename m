Message-ID: <40E47CFB.7090106@246tNt.com>
Date: Thu, 01 Jul 2004 23:07:07 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: mcclintock@freescale.com
Cc: Adrian Cox <adrian@humboldt.co.uk>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	"Kumar K. Gala" <kumar.gala@motorola.com>,
	Matthew McClintock <mcclintock@motorola.com>
Subject: Re: [PATCH][RFC]Updated MPC I2C driver
References: <1088705955.28598.168.camel@localhost>	 <40E463E5.1060401@246tNt.com> <1088696887.7555.70.camel@matthew-laptop>
In-Reply-To: <1088696887.7555.70.camel@matthew-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew McClintock wrote:

 > The blocks look very similar, you might want to look at the follow
 > up patch I just sent that abstracts the read/writes. It might be as
 > simple as abstracting another read/write function for your
 > particular platform.
 >

Yes
I'd say they are identical in fact. I kind of forgot that readl/writel
does a endianness correction. So in fact this driver should work for
the MPC5200.

My only concern is about interrupts.
MPC5200 has two I2C port:
 * One is MBAR + 0x3D00
 * Second is MBAR + 0x3D40

At MBAR + 0x3D20 there is an interrupt control register for the I2C
ports ( shared, 4bits for the first port, 4bits for the second).
 It controls for what reason an I2C interrupt should be fired. I don't
know if there is a similar register on the other, I'll look up the
datasheets.


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
