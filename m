Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D650F67AA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 19:39:45 +1000 (EST)
In-Reply-To: <20060530182250.6ec4fb3b@vitb.ru.mvista.com>
References: <200605301048.01209.laurent.pinchart@tbox.biz>
	<200605301128.48580.laurent.pinchart@tbox.biz>
	<20060530182250.6ec4fb3b@vitb.ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C3212297-C765-46A0-B29C-C95EEFC1E17F@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [SOLVED] LXT973 support (dual PHY with single MDIO)
Date: Tue, 30 May 2006 11:23:42 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 30, 2006, at 09:22, Vitaly Bordug wrote:

> On Tue, 30 May 2006 11:28:48 +0200
> Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:
>
>> Hi,
>>
>> once again, posting to a mailing list helped me solving my  
>> problem. It should
>> have been obvious that the MDIO bus is really a bus, and can as  
>> such support
>> several devices. The issue was that the drivers/net/fs_enet driver  
>> set
>> bus->phy_mask to ~0x9, and the LXT973 uses addresses 0 and 1.  
>> Address 1 thus
>> never got probed. What's the reason for probing addresses 0 and 3  
>> only ?
>
> The reason is obvious: bitbang read of PHY id with not-existent  
> PHY, does not return expected (0, iirc), that confuse mdio bus  
> device-driver bound (it assumes error and returns -1), and prevents  
> from probing other phys. So, as that seems to be a "feature" on  
> CPM2 only, we are working that around specifying phy_mask to  
> prevent probing inexistent phys w/over bitbang thing.


Hopefully, this isn't being set in the driver, but is set in the  
board code, instead.  This is a board-specific setting.

Andy
