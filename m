Subject: RE: jumbled characters on serial port
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 27 Jun 2003 12:31:24 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED703039C@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> We begin getting messages on the tty, without any problem.
> We do insmod ...etc for the driver. Now during the testing some packts
> re passed (say 500.) suddenly the characters gets jumbled
> after printing

Maybe this has nothing to do with the binary data that is output.
Do you call "printk" from interrupt context?
If so, there is currently a known bug (but no fix yet) about characters
getting jumbled when using printk in interrupt context.

Look at that thread of discussion:
  http://lists.linuxppc.org/linuxppc-embedded/200303/threads3.html#00109
The subject is:
  Problem of concurrency in arch/ppc/8260_io/uart.c

As a work around, I would suggest to defer your traces to a kernel task (with schedule_task)... or to fix the bug! ;-) ...whichever is more appropriate.

Regards,
--------------------------------------------
 Jean-Denis Boyer, Software Designer
 M5T Centre d'Excellence en Télécom Inc.
 4283 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
