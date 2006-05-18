Return-Path: <liml@rtr.ca>
Received: from mail.rtr.ca (rtr.ca [64.26.128.89])
	by ozlabs.org (Postfix) with ESMTP id 6B8F2679F3
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 07:12:03 +1000 (EST)
Message-ID: <446CDE26.8090504@rtr.ca>
Date: Thu, 18 May 2006 16:50:46 -0400
From: Mark Lord <liml@rtr.ca>
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
	c pl atform
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
	<1147935734.17679.93.camel@localhost.localdomain>
	<446C9219.4080300@pobox.com>
In-Reply-To: <446C9219.4080300@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
>> On Thu, 2006-05-18 at 12:03 +0800, Zang Roy-r61911 wrote:
..
>>> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>>>  static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem
>> *mmio)
>>>  {
>>>       u32 tmp;
>>> -
>>> +#ifndef CONFIG_PPC
>>>       writel(0, mmio + MV_GPIO_PORT_CTL);
>>> +#endif
>>
>> You'll have to do better here too... I don't wee why when compiled on
>> PPC, this driver should "magically" not clear those bits... At the very
>> least, you should test the machine type if you want to do something
>> specific to your platform, but first, you'll have to convince Jeff why
>> this change has to be done in the first place and if there is a better
>> way to handle it.
> 
> Correct...  it does seem some bugs were found, but #ifdef powerpc is 
> certainly out of the question.  We want the driver to work without 
> ifdefs on all platforms.

Yup.  I have a powerpc platform here with PCI-X, and a PCI-X Marvell card
to try in it.  So I'll pick up these changes and try to integrate them a
little more nicely in my internal updated driver, and then pass it on to Jeff.

Cheers
