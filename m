Message-ID: 
    <DF2B720CF774D21189EE00805FA7FA220517834D@nmrusdunsx3.nielsenmedia.com>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Problem with data cache on MPC823E
Date: Tue, 21 Jan 2003 15:40:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jan,

The following question assumes that your DRAM is physically organized as
32-bits wide and connected to CS1.

Do you have the PS field of BR1 set to 00 (32-bit mode) or is it set to 01
(8-bit mode)? If it's set to 8-bit mode, a burst access becomes 16 bus
cycles, which looks a lot like 4 bursts.

Regards,
Charlie

-----Original Message-----
From: Jan Damborsky [mailto:Jan.Damborsky@devcom.cz]
Sent: Tuesday, January 21, 2003 11:28 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem with data cache on MPC823E



Hello people,

we have developed our board with MPC823E, FLASH memory
DRAM memory for embedded Linux porting, but we have problem
with data cache. From time to time when CPU wants load data from DRAM
to data cache, it makes four burst-reads instead of one for loading one
cache line.
After this, all four words in cache line are loaded with the same first
"critical word".
We don't know, why CPU repeats this burst-read four times. May be it is
because we have floating BI (burst inhibit) CPU singnal.
We have set BIH bit in UPMA to zero.
When setting this BIH bit to one (burst inhibit), all works well.
Does anybody have any help ?
                                                     Jan Damborsky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
