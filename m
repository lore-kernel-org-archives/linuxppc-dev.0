Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B29D5DE142
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:53:41 +1000 (EST)
In-Reply-To: <1180448346.3360.49.camel@zod.rchland.ibm.com>
References: <20070529060541.GG30266@localhost.localdomain>
	<c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
	<1180448346.3360.49.camel@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a5c459df2eefeb9261e65c551870f7f5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Date: Tue, 29 May 2007 16:49:31 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	David Gibson <dwg@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +			compatible = "tsi-mdio";
>>
>> Hrm, did I miss this before?  A more exact "compatible"
>> property would be better ("tsi109-mdio" "tsi108-mdio" or
>> something like that).
>
> If we must, then tsi108-mdio is what I would recommend.  They are the
> same between 108, 109, and 110 as far as I know, so it's the lowest
> common denominator.

[Assuming what is really on the board is a tsi109...]

I recommend putting both 109 and 108 in the property, in
that order; that way, if you need to do something special
on the tsi109 implementation (something you might not yet
know about perhaps, maybe a bug; or some extra feature on
the tsi109 device that the driver doesn't handle yet), the
driver has a chance to do that.  If the driver doesn't care
and only uses tsi108 features, it obviously can probe for
tsi108 only and all will be fine as well.


Segher
