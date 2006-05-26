Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C939667A76
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 18:56:16 +1000 (EST)
Message-ID: <4476C2A0.3030308@pobox.com>
Date: Fri, 26 May 2006 04:56:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
	c pl atform
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
	<1147935734.17679.93.camel@localhost.localdomain>
	<446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca>
	<20060526083931.GA23938@powerlinux.fr>
In-Reply-To: <20060526083931.GA23938@powerlinux.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Alexandre.Bounine@tundra.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Mark Lord <liml@rtr.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sven Luther wrote:
> On Thu, May 18, 2006 at 04:50:46PM -0400, Mark Lord wrote:
>> Jeff Garzik wrote:
>>> Benjamin Herrenschmidt wrote:
>>>> On Thu, 2006-05-18 at 12:03 +0800, Zang Roy-r61911 wrote:
>> ..
>>>>> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>>>>>  static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem
>>>> *mmio)
>>>>>  {
>>>>>       u32 tmp;
>>>>> -
>>>>> +#ifndef CONFIG_PPC
>>>>>       writel(0, mmio + MV_GPIO_PORT_CTL);
>>>>> +#endif
>>>> You'll have to do better here too... I don't wee why when compiled on
>>>> PPC, this driver should "magically" not clear those bits... At the very
>>>> least, you should test the machine type if you want to do something
>>>> specific to your platform, but first, you'll have to convince Jeff why
>>>> this change has to be done in the first place and if there is a better
>>>> way to handle it.
>>> Correct...  it does seem some bugs were found, but #ifdef powerpc is 
>>> certainly out of the question.  We want the driver to work without 
>>> ifdefs on all platforms.
>> Yup.  I have a powerpc platform here with PCI-X, and a PCI-X Marvell card
>> to try in it.  So I'll pick up these changes and try to integrate them a
>> little more nicely in my internal updated driver, and then pass it on to Jeff.
> 
> Hi, ...
> 
> I am trying to use a Marvell 88SX5081 based card here in my pegasos machine,
> and i never got it working with the libata driver, even with the patches Zang
> provided (and 2.6.16 though, maybe i should update to a newer version). The
> marvell provided driver worked though at some time.
> 
> Would it be possible to have access to your work, in order to not duplicate
> effort or something ? 

Do you have any debug output (see top of libata.h)?

	Jeff
