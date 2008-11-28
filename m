Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 823C9DDDE3
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 08:01:30 +1100 (EST)
Date: Fri, 28 Nov 2008 12:59:02 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: i2c-mpc clocking scheme
In-Reply-To: <492EC031.9000802@matrix-vision.de>
Message-ID: <Pine.LNX.4.64.0811281255001.12483@t2.domain.actdsltmp>
References: <492EB606.9020703@matrix-vision.de>
	<ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
	<492EC031.9000802@matrix-vision.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 Nov 2008, Andre Schwarz wrote:
> Timur Tabi schrieb:
>> On Thu, Nov 27, 2008 at 9:00 AM, Andre Schwarz
>> <andre.schwarz@matrix-vision.de> wrote:
>>
>>> All,
>>>
>>> is anybody working on some improvements regarding configurable I2C
>>> frequency inside the i2c-mpc driver ?
>>>
>>> If not - would anybody be intersted in getting this done, i.e.
>>> configurable via device tree ?
>>>
>>
>> Maybe I'm missing something, but U-Boot configures the I2C bus speed.
>> It does this because the algorithm is specific to the SOC itself.  For
>> example, the 8544 is different from the 8548.  It would be a mess to
>> duplicate this code in the kernel.
>>
>>
> You're right regarding U-Boot, but the i2c-mpc driver overwrites the
> "frequency divider register" on all chips.
>
> I'm not happy with a fixed 0x3f @ MPC5200 which results in 65kHz ... :-(
>
> Have a look at line 163 in drivers/i2c/busses/i2c-mpc.c

Seems like it should keep the clock registers at what u-boot set them too.
