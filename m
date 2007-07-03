Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5203CDDF1F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 07:54:31 +1000 (EST)
In-Reply-To: <468ABF4A.60001@freescale.com>
References: <468ABF4A.60001@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <513A555F-5C7F-4FEF-B215-E0E683FEF9E1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Should of_device_is_compatible() use strcmp() rather than
	strncasecmp()?
Date: Tue, 3 Jul 2007 23:54:20 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Is there any particular reason that of_device_is_compatible uses
> strncasecmp()?

It always has, so some things might break with certain
device trees when we make the matching more strict/correct.

> Besides the OF spec saying that names (and thus
> compatibles) are case sensitive, the "n" part screws up matching  
> when a
> subset of a string is not a more generic version thereof.  For  
> example,
> ucc_geth v. ucc_geth_phy, or fsl,cpm v. fsl,cpm-enet.

Huh?  Are you saying things are matching on substrings?
That's even more wrong!

> Does anything actually rely on this behavior?

Yeah I'm pretty sure some things do.  Those are bugs that
need fixing.  My plan was to print a big fat warning whenever
a case-insensitive match wouldn't match when following the
rules; I never got around to actually implementing that though.
Maybe some day ;-)


Segher
