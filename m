Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 91621DDF21
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 23:13:36 +1000 (EST)
In-Reply-To: <1177477630.14873.185.camel@localhost.localdomain>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
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
	<20070424223245.78f4fdfb.sfr@canb.auug.org.au>
	<20070424223930.1dab0e28.sfr@canb.auug
	.org.au> <06c51eb59847d80d9225cd6454f1957e@kernel.crashing.org>
	<17966.45645.902486.793443@cargo.ozlabs.ibm.com>
	<1177477630.14873.185.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c249005137aa3e50c25221f6849a70ea@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/6] Consolidate of_find_property
Date: Wed, 25 Apr 2007 15:13:31 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
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

>> The question is, what ppc drivers would break if we used strcmp
>> instead of strcasecmp?  I have a dim memory that some Apple machines
>> had "ata" and others had "ATA" for the hard disk, for instance.
>
> ata/ATA and ide/IDE is the main one that comes to mind, but I wouldn't
> exclude something like Powermac vs. PowerMac or that sort of thing... I
> remember a case related bug about 2 years ago but can't find what it
> was ...
>
> I think it's safe to settle on strcasecmp for most things for now

Yes, it's hard to imagine any case where strcasecmp(),
although technically incorrect, would break anything.
Please document in the code that is _is_ wrong and _why_
it is done though.


Segher
