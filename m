Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 29D6F67B62
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 15:14:00 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k5F5DuNM002015
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 22:13:56 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5F5Drl0002496
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 00:13:55 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306A5FB51@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: RE: [PATCH/2.6.17-rc4 8/10]  Add  tsi108 8250 serial support
Date: Thu, 15 Jun 2006 13:13:52 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexandre.Bounine@tundra.com, linux-kernel@vger.kernel.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> > On May 17, 2006, at 5:14 AM, Zang Roy-r61911 wrote:
> > 
> > > This patch contains changes to the serial device driver 
> specific for 
> > > integrated serial port in Tsi108 Host Bridge.
> 
> There's no explaination about why this is required.  What is 
> the problem?
> Which changes relate directly to this problem and which 
> changes are related to fixing some other issue not related to 
> the errata?
> 

More detailed explanation:

This patch addresses two differences in the Tsi108/109 UART behavior from the standard one.

1. Check for UART_IER_UUE bit in the autoconfig routine. This section of autoconfig is excluded for 
Tsi108/109 because bits 7 and 6 are reserved for internal use. They are R/W bits. In addition to incorrect
 identification, changing these bits (from 00) will make Tsi108/109 UART non-functional.  

2. ERRATA. Reading the UART's Interrupt Identification Register (IIR) clears the Transmit 
Holding Register Empty (THRE) and Transmit buffer Empty (TEMP) interrupts even 
if they are not enabled in the Interrupt Enable Register (IER). This leads to loss of the interrupts. 
Interrupts are not cleared when reading UART registers as 32-bit word.
