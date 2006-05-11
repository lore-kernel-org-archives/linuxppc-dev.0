Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 3EF02679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 00:14:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help Needed: input overrun(s)
Date: Thu, 11 May 2006 09:14:04 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DDA7@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <s.maiti@tcs.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> From: s.maiti@tcs.com [mailto:s.maiti@tcs.com]=20
> Thanks very much for your reply. It's seems you have already=20
> developed the MCC driver. Are you using channels 32 to 96?=20
> Have you made any changes in the dp ram allocation for uart=20
> or ethernet driver?=20
> Please help me...=20

We are using every other channel from 32 to 96 on both MCC's as SS7
receivers.
We did not have to do any relocations for UART or ethernet.=20
Ethernet uses upper DPRAM (above 0x8000) and uarts use the first 128
bytes.

We statically allocate DPRAM with cpm_alloc_fixed. MCC1 use 0x0800 to
0x17ff
MCC2 use 0x2800 to 0x37ff. Extra param RAM is allocated with cpm_alloc
and is allocated as 256*8 bytes, and shared between MCC1 and 2.

All BD and interrupt tables are in main memory.
