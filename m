Message-ID: <3F842EC5.3070802@imc-berlin.de>
Date: Wed, 08 Oct 2003 17:35:33 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Lokesh Kumar <kumar.lokesh@wrx-us.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx memory mapped 16550 extrenal uart driver
References: <3439AB3A99ECD5409F3A52ACF814744D158D91@norcom2.norcom.net>
In-Reply-To: <3439AB3A99ECD5409F3A52ACF814744D158D91@norcom2.norcom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Lokesh,

> Does anybody know of a driver for an external 16550 memory mapped uart
> driver for an mpc855 based board? Any help is appreciated?

Have a look at linuxppc_2_4_devel at DENX CVS between LABEL_2003_03_11_2055 and
LABEL_2003_03_11_2110.

This extension (for our board called DAB4K) makes it possible to use the
standard linux serial driver with an external, memory mapped 16C752B dual uart.
This one is recocnized by linux as two ST16654:

...
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xc3071000 (irq = 6) is a ST16654
ttyS01 at 0xc3071080 (irq = 8) is a ST16654
...

We then use

~ # ls -l /dev/ttyS*e
crw-r--r--    1 root     root     204,  64 Mar 12  2003 /dev/ttyS0e
crw-rw----    1 root     root     204,  65 Sep 29 13:19 /dev/ttyS1e

to access them. Works fine. Thanks to DENX.

Hope this helps!

--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland
fon: +49 30 467090-0                    Tel: 030 / 467090-0
fax: +49 30 4631576                     fax: 030 / 4631576


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
