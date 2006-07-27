Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE13E679E7
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 06:35:55 +1000 (EST)
In-Reply-To: <1154028871.29826.261.camel@goblue>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
	<67FD272C-C378-4549-8B35-70912AFAB7EF@kernel.crashing.org>
	<1154028871.29826.261.camel@goblue>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <56C6BA2D-C235-4DD3-BEEA-5E253DF77A8D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH][2/2] RTAS MSI
Date: Thu, 27 Jul 2006 22:35:43 +0200
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> These two lines don't need the msi.o and msi-altix.o AFAICS.
>
> Yup, you are right...updated patch included below.

Looks fine now, thanks.

>>> +msiobj-$(CONFIG_PPC_PSERIES) += msi-rtas.o
>>
>> I think this file should live in arch/powerpc, and so should this
>> Makefile fragment.
>
> I'm following the current MSI methodologies where arch specific MSI  
> code
> lives in drivers/pci.  This is just like msi-altix.c.

True, but our core support lives in arch/.  The same is true for PHB
code etc.; if Altix messed this up, that doesn't mean we need to :-)

>> Other than that, can we please have the part that doesn't build the
>> "generic" MSI stuff included ASAP?

This would naturally fall out as a separate patch then, as well.

>>> Index: 2.6-msi/drivers/pci/msi-rtas.c
>>
>> Maybe msi-papr.c is a better name btw?  Not that I care :-)
>
> IMHO I don't like PAPR names because they like changing them on a  
> whim.
> RTAS is a bit more persistent.

Maybe msi-pseries then?  Oh wait, they changed that name too ;-)

> I don't really care...If anyone feels real strongly about it, I'll
> change it.

If you move this code to arch/powerpc/platforms/pseries/, you could
just call it "msi.c".  I don't like the msi-rtas name -- but, I don't
feel that strongly about it, just a suggestion.


Segher
