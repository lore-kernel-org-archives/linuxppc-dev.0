Return-Path: <segher@kernel.crashing.org>
Received: from mail.arcor.de (mail-in-06.arcor-online.net [151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8CF5A67BB1
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 23:01:55 +1000 (EST)
In-Reply-To: <1155122580.4040.96.camel@localhost.localdomain>
References: <20060804055323.1A9BE679FB@ozlabs.org>
	<20060805124544.GB23494@lst.de>
	<1155122580.4040.96.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7279AAE6-71A6-4641-B7E9-B240E168FDF9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] SLB shadow buffer
Date: Wed, 9 Aug 2006 15:01:42 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>,
	linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> What is a SLB shadow buffer and why do we need it?  (I don't want to
>> question the patch but rather learn a little more about lowlevel  
>> ppc64
>> mmu details)
>
> Yeah, same question :) I don't have my PAPR at hand and I'm still
> travellling but I'm curious about that one...
>
> I would suspect it allows the HV to save/restore SLBs when sharing a
> processor between partitions but then... the kernel requires that  
> anyway
> so either the current code is bogus and that's pretty bad (which I  
> don't
> think so) or maybe the fact that we didn't register the shadow  
> caused HV
> to always save/restore the entire SLB, while by using the shadow,  
> we let
> it save/restore only the bolted entries we put in there (and just
> re-fault the other ones). If it's not that, then what ? :)

Yep, that's it (and I do have a PAPR at hand ;-) )

Note that we could also store "volatile" entries in the shadow buffer;
that's supposed to improve performance.


Segher
