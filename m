Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF35067C59
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 18:37:09 +1100 (EST)
In-Reply-To: <1163028836.7630.16.camel@localhost.localdomain>
References: <1162884080.585336.70559261997.qpush@cradle>
	<1162885276.28571.444.camel@localhost.localdomain>
	<20061107080257.GA5874@kroah.com>
	<1162963101.20271.18.camel@localhost.localdomain>
	<m1fycu5j4o.fsf@ebiederm.dsl.xmission.com>
	<1163028836.7630.16.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FF34858D-1D40-4B5E-9B49-D6B9476D66DB@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 0/7] Powerpc MSI Implementation
Date: Thu, 9 Nov 2006 08:36:30 +0100
To: michael@ellerman.id.au
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Looking closer most of them are 5 bits, the high 5 bits, and happen to
> sit next to reserved fields (which must be zero), so reading the byte
> should work in practice. But for a few of them you'll get cruft in the
> low bits.
>
> I don't know what they were thinking when they decided to have 3 and 5
> bit capability fields, and then specify some of them as being a byte
> wide as well. Perhaps the spec committee had a big night out ;)
>
> I was going to write a generic version of pci_find_ht_capability() (as
> suggested by Segher), so along with that I'll clean up the #defines to
> just be the 3 or 5 bit capability codes, and then have a shift for
> getting the capability out of the byte.
>
> Users will still need to know if they're looking for a 3 or 5 bit
> capability, but we can encapsulate that in pci_find_ht_capability()  
> and
> hopefully most people won't have to see the difference.

Keep the defines the full 8 bits and put all the knowledge
about which bits are relevant into pci_find_ht_capability()?
If you do shifting you can get clashes (say, 0b00110 vs. 0b110),
and this would make for simpler code, too.


Segher
