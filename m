Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4F3C5B6F06
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 14:07:01 +1100 (EST)
Message-ID: <4CB522D1.5090802@windriver.com>
Date: Wed, 13 Oct 2010 11:09:05 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: WANG YiFei <yifei_wang@hotmail.com>
Subject: Re: ppc405 + MCP23S17
References: <BAY158-ds7DB18D88ED851794F4E19F5540@phx.gbl>
In-Reply-To: <BAY158-ds7DB18D88ED851794F4E19F5540@phx.gbl>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

WANG YiFei wrote:
> Hi,
> 
>  
> 
> I'm a newbie for linux device driver development.
> 
> We have a custom ppc405 board which has MCP23S17
> 
> (16-Bit I/O Expander with SPI Interface) on it.
> 
> I noticed that current kernel has MCP23S08 driver
> 
> support, I'd like to know:
> 
> 1. if passing platform data to MCP23S08 driver, can it make
> 
>    MCP23S17 work?
> 

These chips should be same vendor product so I think 16-bit mcp23s17 may be
compatible to 8-bit modes. But you have to check the data sheet to confirm this
and track how to configure that as 8-bit mode. After that it's possible to run
mcp23s17 with mcp23s08.c.

> 2. Generally, I'd like to know how to pass platform data to
> 
>    a particular device driver. In my mind, platform data should
> 
>    not be in driver code, right? However, I don't know where is

Firstly you should define this on your dts. Then parse that to register
corresponding of_platform_device or platform_device when you setup your target
on <your target>.c.

When spi_register_driver prober successfully, you can get the platform_data from
associated spi device.

> 
>    the suitable place to pass platform data to driver.
> 
> 3. How to describe this in dts file?
> 

You can get more from the file, Documentation/powerpc/dts-bindings/spi-bus.txt.
Or refer to those existed spi nodes on other platform dts.

Tiejun

>  
> 
> Thanks in advance,
> 
> YiFei
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
