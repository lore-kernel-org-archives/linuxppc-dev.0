Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F5D3DE3E1
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 04:16:13 +1100 (EST)
Message-ID: <472766D1.4070803@freescale.com>
Date: Tue, 30 Oct 2007 12:16:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Subject: Re: [PATCH] using mii-bitbang on different processor ports
References: <1193760559.6244.25.camel@p60635-ste.ids.de>	<20071030163200.GA4470@loki.buserror.net>
	<1193763517.6244.33.camel@p60635-ste.ids.de>
In-Reply-To: <1193763517.6244.33.camel@p60635-ste.ids.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergej Stepanov wrote:
> Hello Scott.
> Thank you for reply.
> Am Dienstag, den 30.10.2007, 11:32 -0500 schrieb Scott Wood:
>> On Tue, Oct 30, 2007 at 05:09:19PM +0100, Sergej Stepanov wrote:
> 
>> You could just use of_iomap() for the second one, since we don't need
>> the physical address for bus->id.
> Nice tip.
> Than it would be needless-------
> 				|
> 				\/
>>> +			iounmap(bitbang->mdc.dir);
>>> +			return -ENOMEM;
>> Please use the goto-style error handling that's used elsewhere in the
>> function.

Hmm... in this case, it'd be impossible to tell using of_iomap() whether 
a failure was due to reg only having one resource (and thus meaning the 
same one should be used for both), or due to ioremap() failure.  Maybe 
we should keep it separate.

-Scott
