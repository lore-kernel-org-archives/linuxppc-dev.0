Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 202B0DDF1A
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 06:01:48 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l62K1glf007941
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2007 13:01:43 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l62K1giE029441
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2007 15:01:42 -0500 (CDT)
Message-ID: <468959A6.80406@freescale.com>
Date: Mon, 02 Jul 2007 15:01:42 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: current-speed property in serial devices causes kernel panic
References: <4685DB63.7040705@freescale.com>
In-Reply-To: <4685DB63.7040705@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> The kernel panic occurs only if I call of_platform_bus_probe().

FYI, thanks to Kumar, I found the problem: I had CONFIG_SERIAL_OF_PLATFORM enabled.  This 
causes of_serial.c to be compiled and loaded.  On my platform, that wasn't doing anything 
because initially I wasn't calling of_platform_bus_probe().  When I added that call to my 
platform code, of_serial.c sprang to life and tried to probe the serial nodes in my device 
tree.  Apparently, of_serial.c is not compatible with fsl_soc.c.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
