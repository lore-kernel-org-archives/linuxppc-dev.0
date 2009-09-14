Return-Path: <wg@grandegger.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DF7DCB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 05:16:34 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8137ADDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 05:16:34 +1000 (EST)
Message-ID: <4AAE9686.4060709@grandegger.com>
Date: Mon, 14 Sep 2009 21:16:22 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: hs@denx.de
Subject: Re: [PATCH] mpc5200: support for the MAN mpc5200 based board uc101
References: <4AADF94C.9040502@denx.de>	<fa686aa40909140638r422db79aj7568f492163c5d96@mail.gmail.com>
	<4AAE4F44.7080300@denx.de>
In-Reply-To: <4AAE4F44.7080300@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Heiko,

Heiko Schocher wrote:
> Hello Grant,
> 
> Grant Likely wrote:
>> Thanks for the patch.  Comments below.
>>
>> g.
>>
>> On Mon, Sep 14, 2009 at 2:05 AM, Heiko Schocher <hs@denx.de> wrote:
>>> - serial Console on PSC1
>>> - 64MB SDRAM
>>> - MTD CFI Flash
>>> - Ethernet FEC
>>> - I2C with PCF8563 and Temp. Sensor ADM9240
>>> - IDE support
>>>
>>> Signed-off-by: Heiko Schocher <hs@denx.de>
...snip....

>>> +               i2c@3d40 {
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <0>;
>>> +                       compatible = "fsl,mpc5200-i2c","fsl-i2c";
>>> +                       reg = <0x3d40 0x40>;
>>> +                       interrupts = <2 16 0>;
>>> +                       fsl5200-clocking;
>> I believe fsl5200-clocking is no longer required.  There is a patch
>> pending which removes this property from the other .dts files.

Right, it obsolete.

> Ok, fix this.

Like it is, the I2C controller will use a fixed low speed fdt/dfsr
setting. You have two other options:

  fsl,preserve-clocking;
  clock-frequency = <400000>;

See also
http://lxr.linux.no/#linux+v2.6.31/Documentation/powerpc/dts-bindings/fsl/i2c.txt.

>>> +
>>> +                       hwmon@2c {
>>> +                               compatible = "ad,adm9240";
>>> +                               reg = <0x2c>;
>>> +                       };
>>> +                       rtc@51 {
>>> +                               compatible = "rtc,pcf8563";

rtc is not a proper vendor name. Should be nxp, IIRC.

Wolfgang.
