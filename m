Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFFA00C@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Gabriel Paubert'" <paubert@iram.es>
Cc: "'Troy Benjegerdes'" <hozer@drgw.net>,
	"'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'Paul Mackerras'" <paulus@samba.org>
Subject: RE: Bogomips and loops_per_jiffy
Date: Fri, 10 May 2002 10:54:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gabriel, (sorry to all for the previous incomplete mail!)

> I don't yet understand this explanation. Jiffy stamp is
> initialized in time_init, in the line:
>
> last_jiffy_stamp(0) = tb_last_stamp = stamp;
>
> and then jiffy_stamp is simply a temporary copy of
> last_jiffy_stamp in the interrupt handler.

Mmmm! You are right! I was annoyed of always getting the message,
 "Warning: real time clock seems stuck!"
and it also caused a 1-2 seconds delay before getting something printed to
the serial port on boot up. So I set the value of ppc_md.get_rtc_time to
NULL, since I have no RTC. That is why I never enter this code in time_init.
It correctly removed the annoying message, but brought this insidious bug.

Regards,

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
