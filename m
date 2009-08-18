Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 11E6DB7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 15:19:12 +1000 (EST)
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 91F12DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 15:19:11 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	C6B9211B4A7
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 07:18:40 +0200 (CEST)
Received: from [192.168.1.6] ([87.97.91.33])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KOK00JFH4344453@invitel.hu> for
	linuxppc-dev@ozlabs.org; Tue, 18 Aug 2009 07:18:40 +0200 (CEST)
Date: Tue, 18 Aug 2009 07:25:11 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: simple gpio driver
In-reply-to: <20090817233833.GA3685@oksana.dev.rtsoft.ru>
To: avorontsov@ru.mvista.com
Message-id: <4A8A3B37.5010303@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <4A83A976.60608@denx.de>
	<fa686aa40908171418k57ce5ff6iac44a72171bcf14a@mail.gmail.com>
	<20090817233833.GA3685@oksana.dev.rtsoft.ru>
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

Hello Anton,

Anton Vorontsov wrote:
> Oops, I missed that patch, sorry.
> 
> On Mon, Aug 17, 2009 at 03:18:37PM -0600, Grant Likely wrote:
>> On Wed, Aug 12, 2009 at 11:49 PM, Heiko Schocher<hs@denx.de> wrote:
>>> Hello Anton,
>>>
>>> i am trying to use the arch/powerpc/sysdev/simple_gpio.c driver,
>>> for accessing some gpios, and found, that u8_gpio_get()
>>> returns not only a 1 or a 0, instead it returns the real bit
>>> position from the gpio:
>>>
>>> gpio    return
>>> base    value
>>> 0       0/0x01
>>> 1       0/0x02
>>> 2       0/0x04
>>> 3       0/0x08
>>> 4       0/0x10
>>> 5       0/0x20
>>> 6       0/0x40
>>> 7       0/0x80
>>>
>>> I also use the arch/powerpc/platforms/52xx/mpc52xx_gpio.c and
>>> mpc52xx_gpt.c drivers, they all return for a gpio just a 1 or 0,
> 
> There is also arch/powerpc/sysdev/qe_lib/gpio.c and
> arch/powerpc/sysdev/mpc8xxx_gpio.c that don't do that.

Ah, okay.

>>> which seems correct to me, because a gpio can have only 1 or 0
>>> as state ... what do you think?
>> I think returning '1' is perhaps slightly 'better' (however you define
>> that), but I don't think the caller should make any assumptions beyond
>> zero/non-zero.
> 
> Yep. So I don't think that the patch is needed.

Yes, if the gpio lib only differs in zero versus non zero.

Thanks for the info

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
