Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95813DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 09:28:32 +1100 (EST)
Message-ID: <49346497.8050701@freescale.com>
Date: Mon, 01 Dec 2008 16:26:31 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: i2c-mpc clocking scheme
References: <492EB606.9020703@matrix-vision.de>	<ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>	<492EC031.9000802@matrix-vision.de>	<Pine.LNX.4.64.0811281255001.12483@t2.domain.actdsltmp>	<4933FBC6.50100@freescale.com>
	<49343DC2.3070601@matrix-vision.de>
	<Pine.LNX.4.64.0812011347450.10176@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0812011347450.10176@t2.domain.actdsltmp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: =?UTF-8?B?QW5kcsOpIFNjaHdhcno=?= <Andre.Schwarz@matrix-vision.de>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho wrote:
> U-boot could pass in "bus-frequency" to let software know the speed of the
> I2C bus from Linux.  Seems like a standard property for bus nodes.

clock-frequency is standard, though it should probably be the input 
frequency rather than the bus frequency, in case the OS really does want 
to change it (maybe making the bus run faster when accessing faster 
devices).

> There could be a "current-speed" property that tells linux to keep the
> registers the same,

That would be a bit different from the way it's used in serial nodes, 
where current-speed is simply a description of the baud rate that 
corresponds to the current divider setting.  I'm not sure that it makes 
as much sense for i2c, as you don't have the shared state on the other 
end that depends on maintaining the exact same speed.

When does the guest really care what the specific i2c bus frequency is, 
if it's not going to change it?

-Scott
