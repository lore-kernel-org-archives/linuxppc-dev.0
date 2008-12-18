Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90735DDE28
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 04:20:21 +1100 (EST)
Message-ID: <494A8643.1030105@freescale.com>
Date: Thu, 18 Dec 2008 11:20:03 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v1] Add support for getting device platform data to I2C
	device
References: <1229566451-29411-1-git-send-email-Mingkai.hu@freescale.com>
	<20081218165946.GA4029@oksana.dev.rtsoft.ru>
In-Reply-To: <20081218165946.GA4029@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=windows-1251; format=flowed
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Thu, Dec 18, 2008 at 10:14:11AM +0800, Mingkai Hu wrote:
>> There is no standard way of getting device platform data from
>> dts file to the I2C device when it's probed. This patch adds
>> a function pointer to the of_modalias_table to get such bindings
>> properties into device's platform data.
> 
> Unfortunately this approach leads to inability to make the bindings
> modular.

True, but I think it's fine for now while a better mechanism is worked 
out -- especially for things that are mainly used in embedded situations 
where modular builds aren't as necessary.

> And the solution that everybody seem to agree with (SPI driver example):
> http://lkml.org/lkml/2008/10/30/393

Hmm, that doesn't seem to allow for any binding mechanism other than 
internal and OF, and it seems like it could be done more 
straightforwardly by having the modalias point to the OF wrapper, which 
then instantiates the core driver.

But the above approach has the distinct advantage of having already been 
implemented. :-)

-Scott
