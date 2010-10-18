Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2C0EAB70A5
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 19:18:10 +1100 (EST)
Message-ID: <4CBC029E.4030508@windriver.com>
Date: Mon, 18 Oct 2010 16:17:34 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: WANG YiFei <yifei_wang@hotmail.com>
Subject: Re: Help about chip select on SPI slave devices
References: <BAY158-ds7DB18D88ED851794F4E19F5540@phx.gbl>	<4CB522D1.5090802@windriver.com>	<BAY158-ds2BEE228C7E27E7CE0C28BF5550@phx.gbl>
	<BAY158-ds45852D1FE75BC452A052FF5580@phx.gbl>
In-Reply-To: <BAY158-ds45852D1FE75BC452A052FF5580@phx.gbl>
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
> We have a board which has 1 SPI master controller and 4 SPI slave devices, and we'd like to use 2 GPIOs to demux to chip select these slave devices.
> Can anyone tell me if current powerpc dts support demuxer for chip select for spi slave devices? So far as I know, in dts, SPI master can only use 1 to 1 GPIO to CS(then needs 4 GPIOs).

It may be unnecessary to add other device property on the dts for your purpose.

You can still get those original 2 gpios defined on the dts by default, but pass
'4' to num_chipselect of your SPI master when probe SPI master. This will 'tell'
kernel there are 4 kind chipselect signals for SPI sub-system. When the new SPI
device is added, the kernel would acquire the number which chip should be
activated by parsing chip_select of that corresponding spi_device. Then the
kernel call your chipselect defined with struct spi_bitbang to set gpio. (Often
we use gpio API gpio_set_value). On there you can determine how gpio_set_value()
are called according to your SPI device chip_select.

For example,
------
NO.0 Chip ==> gpio_set_value(PIN0, 0); gpio_set_value(PIN1, 0)
NO.1 Chip ==> gpio_set_value(PIN0, 0); gpio_set_value(PIN1, 1)
NO.2 Chip ==> gpio_set_value(PIN0, 1); gpio_set_value(PIN1, 0)
NO.3 Chip ==> gpio_set_value(PIN0, 1); gpio_set_value(PIN1, 1)

Tiejun

> 
> 
> Thanks in advance,
> YiFei
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
