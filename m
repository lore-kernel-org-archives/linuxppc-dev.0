Return-Path: <aidan@nicta.com.au>
Received: from mail11.syd.optusnet.com.au (mail11.syd.optusnet.com.au
	[211.29.132.192])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D36767A5D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 21:15:54 +1000 (EST)
Message-ID: <4450A7E9.5030308@nicta.com.au>
Date: Thu, 27 Apr 2006 21:15:53 +1000
From: Aidan Williams <aidan@nicta.com.au>
MIME-Version: 1.0
To: Vincent Winstead <vwinstead@yahoo.com>
Subject: Re: Xilinx Virtex-2 PRO FPGA ppc 405 on ML310 board
References: <20060425222107.97443.qmail@web52006.mail.yahoo.com>
In-Reply-To: <20060425222107.97443.qmail@web52006.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Vincent Winstead wrote:
>   But I still have nothing working with the ML310 board.  I did a "dow 
> image.elf" at the XMD command prompt, then "con" and it showed up with a 
> "RUNNING>" prompt, but nothing showed up on the hyperterminal window.  I 
> compiled using 115200 baud and I changed my hyperterminal to match this, 
> but nothing shows up ...at all.  Where do you think I would need to 
> start looking to resolve this issue?

Ensure that your hardware is working by running one of
the xilinx-supplied demo programs on your design
that outputs stuff from the serial port (e.g. the memory
tester).  If nothing comes out, check your hardware
design carefully, check your serial port settings
(e.g. flow control), etc.

I would also read up on serial port block you are using
and its linux driver.  For example, if you're using the
uartlite, it could be that your hardware and software
don't agree on the baudrate.

e.g. See drivers/char/xilinx_uartlite/xuartlite.h :-

* @file xuartlite.h
*
* This component contains the implementation of the XUartLite component which is
* the driver for the Xilinx UART Lite device. This UART is a minimal hardware
* implementation with minimal features.  Most of the features, including baud
* rate, parity, and number of data bits are only configurable when the hardware
* device is built, rather than at run time by software.


- aidan
