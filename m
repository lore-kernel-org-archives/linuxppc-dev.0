Message-Id: <4.3.2.20010405082957.00c10aa0@falcon.si.com>
Date: Thu, 05 Apr 2001 08:51:24 -0400
To: <linuxppc-embedded@lists.linuxppc.org>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Timeout when pinging with larger packages...
In-Reply-To: <00b201c0bd79$c4fa3bc0$8021690a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The FIFO in the CPM for the FCCs is 192 bytes.  If you can send short
packets but not longer packets, it implies that the CPM is OK as long
as the whole packet will fit into the FIFO.  As soon as it has to start
flushing to memory, things fall apart.  My experience is that it starts
falling apart around 200-250 bytes -- the FIFO can flush a few bytes
out, but then falls behind and things stop.

You probably have a memory or clocking issue.  How fast are you
clocking your CPM and how fast is your ethernet?  If you are running
100bT, you need to clock your CPM at 100MHz or better.  Also, don't
clock it with a 2.5x multiplier: that invokes a REALLY BAD silicon bug
in the A.1 processor (others?).  There are even more issues with
silicon prior to A.1 and you should upgrade if you are running old silicon.

Device errata (file name XPC8260A.IDE.pdf)
------------------------------------------------------------------------
XPC8260 DEVICE ERRATA

December 18, 2000

This document is a compilation of device errata for Revision A.1.
Herein, the errata are
classified and numbered, and most erratum is provided with a
description and
workarounds. This is a pre-production device errata. New
addition/change to the errata
since the last revision is indicated with ITALIC font.

[snip]

CPM62. THE CPM PLL DOES NOT LOCK RELIABLY FOR CERTAIN MULTIPLICATION
FACTORS.

If the CPM multiplication factor is 2.5, 3.5, 5 or 6 the internal PLL
will not lock reliably which will result in erratic behavior. Sometimes
(mainly at bus frequencies lower than 50 Mhz) it might lock, however it
might loose the lock after worth. If one of the other multiplication
factors (2,3 or 4) is selected, the CPM PLL will lock reliably, even at
66 Mhz bus speed.

Workaround: Do not use the non-reliable multiplication factors. For 166
Mhz CPM use 55 Mhz bus frequency and a CPM multiplication factor of 3.

Fix plan: TBD
------------------------------------------------------------------------

Mask info:

Rev     Mask    Process         Qual    IMMR[16:31]
0.2     2J24M   0.29 um HIP3    -       0x0000
A.0     K22A    0.29 um HIP3    -       0x0010
A.1     1K22A   0.29 um HIP3    XC      0x0010

Note: My A.1 processors IMMR read 0x0011, I presume the table entry is
a typo.

gvb


At 10:40 AM 4/5/01 +0800, machael wrote:

>Hello,
>
>         Now I can run linuxppc-2.4.3-pre4 (from ftp.denx.de) on my
>8260-based custom board sucessfully .
>        I met a strange problem when ping this target board. When
> pinging the
>board from my host using "ping -f  MyBoardIP " ,   it works normally.
>But if
>I ping using "ping -s 200 MyBoardIP", then I can receive no
>respondence but
>"TIMEOUT". Why?
>        Do you have such similar problems? What may be the problem?
>
>        Thank you very much!
>
>        machael
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
