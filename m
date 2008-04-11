Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 162E5DE560
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 05:06:14 +1000 (EST)
Message-Id: <1D6963B0-4EC5-41F7-8BFA-97C2C0647A13@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080411153125.GA2588@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2.6.26] gianfar: Determine TBIPA value dynamically
Date: Fri, 11 Apr 2008 14:06:07 -0500
References: <1207870471-3601-1-git-send-email-afleming@freescale.com>
	<20080411153125.GA2588@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	paul.gortmaker@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 11, 2008, at 10:31, Scott Wood wrote:

> On Thu, Apr 10, 2008 at 06:34:31PM -0500, Andy Fleming wrote:
>>
>> +	/*
>> +	 * This is mildly evil, but so is our hardware for doing this.
>> +	 * Also, we have to cast back to struct gfar_mii because of
>> +	 * definition weirdness done in gianfar.h.
>> +	 */
>> +	enet_regs = (struct gfar __iomem *)
>> +		((char *)regs - offsetof(struct gfar, gfar_mii_regs));
>
> Can we use to_container() here?


I tried.  Technically, we can.  But the issue is that struct gfar  
*enet_regs->gfar_mii_regs is declared:

u8 gfar_mii_regs[24];

I could not find any sequence of castings that made the warning go  
away about casting that to a struct gfar_mii __iomem *.  And that  
includes mucking around with the declaration of gfar_mii_regs.  I  
vaguely recall determining that you couldn't make it a struct, because  
you can't guarantee gcc won't much with the size of the struct.  Or  
something.  Suffice it to say, this worked, and wasn't much wordier.   
But I really did spend a couple hours banging my head against sparse  
trying to get the pointers to agree.

Andy
