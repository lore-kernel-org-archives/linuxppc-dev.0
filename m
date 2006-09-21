Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44E6E67BDC
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 10:07:23 +1000 (EST)
In-Reply-To: <20060920215738.GC24809@mag.az.mvista.com>
References: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
	<20060920012042.GA28489@mag.az.mvista.com>
	<1158721828.3043.13.camel@vader.jdub.homelinux.org>
	<A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
	<1158787957.6002.307.camel@localhost.localdomain>
	<20060920215738.GC24809@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Date: Thu, 21 Sep 2006 02:07:05 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> So please comment the nastiness with a big "HACK HACK HACK"  
>>> comment and
>>> make sure it only ever gets used on systems where nothing better is
>>> available, and all should be fine.
>>
>> An option is to call it something like fw,address to avoid  
>> confusion and
>> make it somewhat clearer that it's really a firmware address useable
>> within the context of the firmware...
>
> Okay.  We did talk about that but then we realized that "address"
> was for vaddrs.  We thought of other names like "bootwrapper-vaddr"
> etc. but "fw,address" or "fw,vaddr" are probably better--they show  
> that
> the vaddr was setup by the fw.

If you use a different name than "address", you're not bound to its
semantics either.  And as those semantics have some problems, please
do change-em.  How about:

The "reg-virtual-address" property contains the same regions as the
"reg" property, in the same order; each entry is #address-cells from
the root node 32-bit integers wide(*); the entry describes a
contiguous area of virtual memory of the same size as the
corresponding "reg" entry, mapping that area, or 0 if the area isn't
mapped.

Any holes in this definition?


Segher

(*)  This isn't strictly correct, but OF doesn't describe the size of
virtual addresses anywhere.  In practice, it's the same as the size
of physical addresses always.  Oh, and the name "virtual" isn't correct
in PowerPC-speak anyway, heh.
