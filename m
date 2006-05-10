Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 52DC5679F9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 02:49:28 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by postfix.timesys.com (Postfix) with ESMTP id DC7A88069796
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 12:49:29 -0400 (EDT)
Received: from postfix.timesys.com ([127.0.0.1])
	by localhost (postfix.timesys.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04848-06 for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 12:49:27 -0400 (EDT)
Received: from exchange.timesys.com (exchange.timesys.com [192.168.2.250])
	by postfix.timesys.com (Postfix) with ESMTP id 5478B80697AA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 12:49:27 -0400 (EDT)
Subject: Re: IMAP_ADDR on PPC 8xx
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <1147274635.23931.17.camel@excalibur.timesys.com>
References: <4D8794260B62C940BBA7150CC5EB3BD43D23CA@bosmail.BOS.int.mrv.com>
	<1147204345.3139.11.camel@excalibur.timesys.com>
	<3A4FA660-AD13-4E2B-846B-B9ACD901444F@embeddedalley.com>
	<1147274635.23931.17.camel@excalibur.timesys.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 12:49:23 -0400
Message-Id: <1147279763.23931.32.camel@excalibur.timesys.com>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-10 at 11:23 -0400, Walter L. Wimer III wrote:
> Based on your comments and Wolfgang's comments, I conclude that:
> 
>      1. The U-Boots on my MPC885ADS and MPC8272ADS boards are
>         unequivocally broken and should be replaced with ones from the
>         official U-Boot source repositories that use IMMR values
>         matching the Linux kernel source.


FYI, here's a table from the "MPC885ADS PowerQUICC(tm) Application
Development System User's Guide", available on Freescale's website.
This table seems to confirm how they've configured their U-Boot -- the
IMMR is set to 0x02200000...

This may be fine for non-Linux purposes, but it looks like we need to
spread some gospel to Freescale regarding the correct IMMR address for
U-Boot / Linux....

(Or they need to convince folks on this list why their way is
right.... :-)

(In any case I'm convinced.  I'm switching over to the community U-Boot
that uses 0xFF000000.)


FYI-ly,

Walt



               Freescale Semiconductor, Inc.

             Table 3-2. Memory Map in MP885ADS

                                                            Port
ADDESS RANGE                       Memory Type              Size
------------------------    -----------------------------   ----
00000000 - 007FFFFF (8M)    SDRAM -- CS4                     32

02000000 - 020FFFFF (1M)    Communication ports -- CS5
     02000000 - 020000FF                         ATM25
     02000100 - 020001FF                        ATM155
     02000200 - 020002FF                  T1/E1 framer
     02000300 - 020003FF       BCSR5, control register
     02000400 - 020004FF                      Reserved

02100000 - 02107FFF (32K)   BCSR[0-4] (1) -- CS1             32 (2)
     02100000 - 02107FE3                         BCSR0
     02100004 - 02107FE7                         BCSR1
     02100008 - 02107FEB                         BCSR2
     0210000C - 02107FEF                         BCSR3
     02100010 - 02107FF3                         BCSR4

02108000 - 021FFFFF         Empty space

02200000 - 02203FFF         MPC885 internal MAP (3)          32

02204000 - 0221FFFF         Empty space

02220000 - 02227FFF         Security engine (SEC)            64

02228000 - 027FFFFF         Empty space

02800000 - 029FFFFF (2M)                                     32
02A00000 - 02BFFFFF (2M)    Flash SIMM -- CS0
02C00000 - 02FFFFFF (4M)

03000000 - FFFFFFFF         Empty space
-----------------------------------------------------------------
 (1) The device appears repeatedly in multiples of its size.
     That is, BCSR0 appears at memory locations 2100000, 2100020,
     2100040..., while BCSR1 appears at 2100004, 2100024,
     2100044, and so on.
 (2) Only the upper 16 bits (D0\u2013D15) are used.
 (3) Refer to the MPC885 PowerQUICC Family Reference Manual for
     a complete description of the MPC885 internal memory map.
