Message-ID: <023EF71CB65AA949A2C510353690C86B027FB3@rokonet-e.rokonet.co.il>
From: Eli Brin <eli.brin@rokonet.co.il>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Watchdog timer reset
Date: Wed, 11 Aug 2004 13:05:19 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

We use an mpc8xx custom board, u-boot 1.1.1 and ELDK 3.0 (kernel 2.4.24 with
HZ = 500).

My problems are using the wdt_mpc8xx watchdog.  We have a lot off resets,
especially during application loading.

I have tried to increase the reset rate of the module to HZ/10 instead of
HZ/2 but it didn't help.  Sometime creating a new image (we use SELF) solves
the problem. To overcome the resets we insert/remove sleep or
increase/decrease our logging (printf to console).

The applications are written in C++ with pthreads multi-threading optimized
with -O2.

We use poll-select on the serial channel (SMC2), and all blocking functions
are implemented within threads.

Tried to fork() instead off using system() and other tests, but every time
we think we solved it...after some time the resets come back.

I could not find a rational for the problem.  Any ideas?

Thank you,
Eli Brin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
