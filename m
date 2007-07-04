Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA372DDED0
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 22:09:33 +1000 (EST)
In-Reply-To: <18059.5083.741194.497123@cargo.ozlabs.ibm.com>
References: <468ABF4A.60001@freescale.com>
	<18059.5083.741194.497123@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3BA501D5-D731-4967-AA60-6E9A3DBCC122@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Should of_device_is_compatible() use strcmp() rather than
	strncasecmp()?
Date: Wed, 4 Jul 2007 14:09:14 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Does anything actually rely on this behavior?
>
> Things did in the past rely on the case-insensitive comparison but
> probably don't any more.  I recall an issue with "ata" vs. "ATA" on
> the powerbook 3400.

Yes, and there are some AAPL, vs. aapl, things too; and an
i2c thing as well.  Probably more.  Nothing unfixable of course,
but...

> As for the "n" part, I don't recall exactly why that was done.  I
> think we should change it to use strcmp and fix any drivers that
> break.

...we first need to find the problem spots.  If we switch early
in the .23 series, will that be enough time to find all (important)
issues?


Segher
