Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E52BCDDF1B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 10:50:29 +1000 (EST)
In-Reply-To: <1177459397.14873.160.camel@localhost.localdomain>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug
	.org.au> <f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
	<1177459397.14873.160.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <baa646899e4d0f3f1111f62709a2c66b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
Date: Wed, 25 Apr 2007 02:50:13 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	"David S. Miller" <davem@davemloft.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> While I realise your patch is just moving stuff around,
>> can this be fixed please?  A missing "#address-cells"
>> property means "two cells", not "inherit from parent".
>> The few platforms with a broken tree should just be
>> fixed (patch the tree in the bootwrapper, or perhaps
>> _do_ use this workaround, but only on the affected
>> platforms).
>
> If you can get me access to all of the old PowerMac or CHRP crap with
> broken device-tree's ...

No I can't, which is exactly why I cannot fix it myself.

> Note that I don't think there's much cases of such breakage on the
> field,

For PowerPC it is mostly the G3 PowerMacs I believe.

The SPARC tree carries the same broken code -- is
this just a case of code copying, or are there
actual SPARC machines with such broken trees?

> but I'd be annoyed to change a behaviour we had from day 1.

Yes exactly -- we shouldn't just completely break
the kernel working on those machines.  Of course,
if no tester can be found, perhaps support for
those boxes should just be abandoned.


Segher
