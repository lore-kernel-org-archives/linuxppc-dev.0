Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0E3667B89
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 19:52:47 +1000 (EST)
In-Reply-To: <1155090210.7087.4.camel@localhost.localdomain>
References: <1154024154.29826.229.camel@goblue>
	<1154062599.21801.40.camel@localhost.localdomain>
	<802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
	<1155090210.7087.4.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F5E5EF18-6452-4E9D-8A43-6D1CE9C3E43E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH][0/2] RTAS MSI
Date: Wed, 9 Aug 2006 11:52:24 +0200
To: michael@ellerman.id.au
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I was just re-reading this thread and this got me thinking. I think  
> the
> current code does violate this rule if firmware has allocated more  
> than
> one MSI to the device.
>
> In rtas_enable_msi() we ask firmware how many MSIs the device has been
> given (by firmware), we then return one to the driver, but leave any
> extras configured.
>
> So this might lead to the state where the card has been configured to
> use x MSIs, but we only tell the driver about 1 of them. I don't know
> enough PCI to grok if that's going to be a problem.

A device could in principle happily start using all MSIs it has been
assigned as soon as its global interrupt enable bit is set.  So lying
to the driver about what MSIs are enabled can in principle cause nasty
problems.

In reality however, on any (recent) device, every interrupt cause also
has its own enable bits that the driver needs to set.  So we're sort-of
safe here.

Eventually, we should change the API for pci_enable_msi() so that it
can enable multiple MSIs as well; an arch implementation can always
choose to do just one.  This lets us roll the APIs for MSI and MSI-X
into one as well btw -- always a good thing!


Segher
