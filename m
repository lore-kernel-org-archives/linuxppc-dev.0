Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5A94BB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 14:50:45 +1000 (EST)
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 6394FDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 14:50:43 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	5048E11A176
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 06:50:41 +0200 (CEST)
Received: from [192.168.1.6] ([91.82.141.93])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KPZ006U7XGGW110@invitel.hu> for
	linuxppc-dev@ozlabs.org; Tue, 15 Sep 2009 06:50:41 +0200 (CEST)
Date: Tue, 15 Sep 2009 07:06:05 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] mpc5200: support for the MAN mpc5200 based board uc101
In-reply-to: <4AAE9686.4060709@grandegger.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Message-id: <4AAF20BD.5030607@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4AADF94C.9040502@denx.de>
	<fa686aa40909140638r422db79aj7568f492163c5d96@mail.gmail.com>
	<4AAE4F44.7080300@denx.de> <4AAE9686.4060709@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfgang,

Wolfgang Grandegger wrote:
> Heiko Schocher wrote:
>> Hello Grant,
>>
>> Grant Likely wrote:
>>> Thanks for the patch.  Comments below.
>>>
>>> g.
>>>
>>> On Mon, Sep 14, 2009 at 2:05 AM, Heiko Schocher <hs@denx.de> wrote:
>>>> - serial Console on PSC1
>>>> - 64MB SDRAM
>>>> - MTD CFI Flash
>>>> - Ethernet FEC
>>>> - I2C with PCF8563 and Temp. Sensor ADM9240
>>>> - IDE support
>>>>
>>>> Signed-off-by: Heiko Schocher <hs@denx.de>
> ...snip....
> 
>>>> +               i2c@3d40 {
>>>> +                       #address-cells = <1>;
>>>> +                       #size-cells = <0>;
>>>> +                       compatible = "fsl,mpc5200-i2c","fsl-i2c";
>>>> +                       reg = <0x3d40 0x40>;
>>>> +                       interrupts = <2 16 0>;
>>>> +                       fsl5200-clocking;
>>> I believe fsl5200-clocking is no longer required.  There is a patch
>>> pending which removes this property from the other .dts files.
> 
> Right, it obsolete.

OK, I remove it.

>> Ok, fix this.
> 
> Like it is, the I2C controller will use a fixed low speed fdt/dfsr
> setting. You have two other options:
> 
>   fsl,preserve-clocking;
>   clock-frequency = <400000>;
> 
> See also
> http://lxr.linux.no/#linux+v2.6.31/Documentation/powerpc/dts-bindings/fsl/i2c.txt.

Ah, ok, thanks for this info. I try this ...

>>>> +
>>>> +                       hwmon@2c {
>>>> +                               compatible = "ad,adm9240";
>>>> +                               reg = <0x2c>;
>>>> +                       };
>>>> +                       rtc@51 {
>>>> +                               compatible = "rtc,pcf8563";
> 
> rtc is not a proper vendor name. Should be nxp, IIRC.

OK, fix it.

Thanks for reviewing

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
