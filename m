Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 78A9967BE0
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 21:28:56 +1000 (EST)
In-Reply-To: <1157590706.22705.272.camel@localhost.localdomain>
References: <20060904175742.5472a6fa@localhost.localdomain>
	<20060905122956.2cebd36d@localhost.localdomain>
	<0C880511-D99D-4160-9EB1-A66B22B2D82F@kernel.crashing.org>
	<20060906101034.404014f7@localhost.localdomain>
	<1157590706.22705.272.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <86FCADAC-25CF-42B1-8FFB-06889AF6C90E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [4/5] powerpc: PA Semi PWRficient platform support
Date: Thu, 7 Sep 2006 13:28:25 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> How about I keep it this way until Maple is fixed then? It's  
>> better to keep it
>> fairly common anyway. Functionally there's no difference.
>
> Well, the platform-open-pic thingy comes from the CHRP spec.

I can't find it there.  I'm looking at version 1.0; maybe it's
in a newer version that I don't have?  It's not in the PAPR
either (the "open" version, anyway).

> I'm no fan
> of it but it looks like we do need it on pseries and I haven't
> completely given up with having common mpic discovery routine...

Sure.  "Just look for the MPIC node and use it with one ISU" won't
work on an actual Maple anyway afaics, it won't find the right
base address for it in its device tree.

I'll make something nice that maybe even you will like ;-)

>>> Very nice, I'll convert maple to do the same (unless someone beats
>>> me to it, heh).
>>
>> Maple isn't that different there. It just has to deal with  
>> multiple ISUs,
>> while we currently only have one.
>
> Maple doesn't have multiple ISUs

Exactly.  All "real" OpenPICs don't; let's just recognise that fact.


Segher
