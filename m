Message-ID: <D73A25AA6E54D511AD74009027B1110F2C853D@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Linux  PPC'" <linuxppc@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Serial port on IcePlanet
Date: Fri, 23 Aug 2002 11:13:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is code that I wrote to set up the second uart.  I used Metrowerks 6.0
to compile it.

//-----------------------------------------------------------
//UART1
void setUpOtherUart()
{

	unsigned char* uart = (unsigned char*)0xef600400;
	unsigned char* bcsr3    = (unsigned char*)0xF4000003;
	int k = 11059200 / (16 * 9600);

    uart[3]       |= 0x80;        // set lcr[DLAB] divisor latch access bit
    uart[0] =  k &  0xFF;   // set LSB of divisor
    uart[1] =  k >> 8;      // set MSB of divisor
    uart[3]       |=~0x80;        // clear lcr[DLAB] divisor latch access
bit

    uart[3]     = 0x03;           // 8 bit, 1 stop, no parity
    uart[4]     = 0x03;           // DTR and RTS active.
    uart[2] = 0x01;           // 16550 Fifo enabled.

    uart[0] |= 0x10;


}

-----Original Message-----
From: Linux PPC [mailto:linuxppc@rediffmail.com]
Sent: Friday, August 23, 2002 11:06 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Serial port on IcePlanet



Hi!

Has anybody got the second serial port working on the
Iceplanet (405pc processor)? The second serial port doesn't have
DCD and RI pins on it. Does this mean that the standard serial
driver will not work for it?

Thanx for reading,


- navin.

__________________________________________________________


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
