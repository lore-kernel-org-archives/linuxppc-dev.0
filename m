Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CFBE6DDE3D
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:45:02 +1100 (EST)
In-Reply-To: <1171326015.20192.44.camel@localhost.localdomain>
References: <11713184081457-git-send-email-tnt@246tNt.com>
	<11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<1171321965.20192.37.camel@localhost.localdomain>
	<45D0F778.1080606@246tNt.com>
	<1171326015.20192.44.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4c862ff39a26802e96af9b5932a447c3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 02/10] powerpc: Add device tree fixups for the EFIKA
Date: Fri, 16 Feb 2007 17:44:54 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The const might cause a warning because prop_set_prop takes a void
>> *value and not
>> a const void *value. I don't know if does need to modify the value or
>> not though.
>
> Ok, there's room for another patch to constify prom_set_prop and all
> callers then :-)

No callers should need changing.  If they do then that's
some bonus bugs fixed ;-)

>> I would have hoped that being local to a __init function the memory 
>> for
>> the initial values would be freed but I might me over optimistic.
>
> Yeah, worth checking the ELF output but I think you are over
> optimistic :-)

There is nothing that makes data in a function in
the .init.text section automagically end up in the
.init.data section -- those names are just names,
for all the tools involved, with no attached meaning.


Segher
