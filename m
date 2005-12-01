Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id C109D68865
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 03:58:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 1 Dec 2005 10:45:54 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8594B5@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <zengshuai@sogou.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: RE: linuxppc-embedded help needed:kernel access of bad area
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: zengshuai@sogou.com
> Sent: Thursday, December 01, 2005 00:52
> #define BCSRADDR 0x04500000

This address is wrong.
It's the address the manual gives, but the bootloadre usually moves it
because it interferes with the SDRAM when running Linux.
Check the bootloader, or even better, if you know which ChipSelect the
BCSR is on, read the BRn register and use that address.

sort of like:
bcsr_addr =3D cpm2_immr->im_memctl.memc_br1 & 0xffff8000; // BCSR is on
CS1 on MPC8266ADS board
