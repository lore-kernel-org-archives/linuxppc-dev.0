Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <BE1C564723B3D21191FD0000F840E39801D814F1@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Is it normal for serial ports to drop characters at the end?
Date: Wed, 3 May 2000 11:30:06 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I see characters dropped at the end of a write to a serial port.  Surely
that isn't normal.
I'm using the current MontaVista 2.2.13 kernel patched for my custom
860-based board.  The serial ports are running at 9600.

When I do this:
init-2.00# help while >/dev/ttyS1

I see this (on ttyS1):
while: while COMMANDS; do COMMANDS; done
    Expand and execute COMMANDS as long as the final command in the
    `while' COMMANDS has an exit status of .

It's slightly different each time, garbling or dropping characters from
"zero."
This happens on ttyS1 (SMC2), ttyS2 (SCC2), and ttyS3 (SCC3).
If I send a longer message (help set >/dev/ttyS1) I see the same thing: all
prints okay except the last several characters.

Same board as has SCC serial problems when ethernet is used, but I'm
thinking its not related to that since this problem happens for SMC2 as
well.  Could it be that when a serial port is closed, the uart is disabled
immediately instead of waiting for output to finish?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
