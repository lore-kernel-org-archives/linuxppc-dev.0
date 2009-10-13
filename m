Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13D75B7BAC
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 04:22:46 +1100 (EST)
Subject: Re: [PATCH 0/8] gianfar: Add support for hibernation
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Andy Fleming <afleming@freescale.com>
In-Reply-To: <20091012.235747.195783342.davem@davemloft.net>
Date: Tue, 13 Oct 2009 12:22:38 -0500
Message-Id: <64B2BB18-32DC-4B98-95D6-F203F74040D5@freescale.com>
References: <20091012160000.GA32406@oksana.dev.rtsoft.ru>
	<20091012.235747.195783342.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 13, 2009, at 1:57 AM, David Miller wrote:

> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Date: Mon, 12 Oct 2009 20:00:00 +0400
>
>> Here are few patches that add support for hibernation for gianfar
>> driver.
>>
>> Technically, we could just do gfar_close() and then gfar_enet_open()
>> sequence to restore gianfar functionality after hibernation, but
>> close/open does so many unneeded things (e.g. BDs buffers freeing and
>> allocation, IRQ freeing and requesting), that I felt it would be much
>> better to cleanup and refactor some code to make the hibernation [and
>> not only hibernation] code a little bit prettier.
>
> I applied all of this, it's a really nice patch set.  If there are any
> problems we can deal with it using follow-on fixups.
>
> I noticed something, in patch #3 where you remove the spurious wrap
> bit setting in startup_gfar().  It looks like that was not only
> spurious but it was doing it wrong too.
>
> It's writing garbage into the status word, because it's not using the
> BD_LFLAG() macro to shift the value up 16 bits.
>

No, it was fine (though made unnecessary by other patches).  The BD  
has a union:

                 struct {
                         u16     status; /* Status Fields */
                         u16     length; /* Buffer length */
                 };
                 u32 lstatus;

so when you write "lstatus", you need to use the BD_LFLAG() macro, but  
when you write "status", you are just setting the status bits.

Andy
