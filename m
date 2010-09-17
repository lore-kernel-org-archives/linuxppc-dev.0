Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9F12B70AB
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 17:40:10 +1000 (EST)
Subject: Re: linux support for freescale e5500 core?
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4C930C55.5030008@genband.com>
Date: Fri, 17 Sep 2010 02:39:44 -0500
Message-Id: <4737649C-42E5-47EC-8839-314820EAE45E@kernel.crashing.org>
References: <4C9278CD.10607@genband.com>	
	<20100916163911.6255d359@schlenkerla.am.freescale.net>	
	<4C928FC5.9050700@genband.com> <1284674628.30449.98.camel@pasglop>	
	<4C92998C.7000903@nortel.com> <1284681832.30449.101.camel@pasglop>	
	<7EDBB1DD-BB9D-417D-8F4E-B9D5D9E030EF@kernel.crashing.org>
	<1284701585.30449.102.camel@pasglop> <4C930C55.5030008@genband.com>
To: Chris Friesen <chris.friesen@genband.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Scott Wood <scottwood@freescale.com>, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 17, 2010, at 1:36 AM, Chris Friesen wrote:

> On 09/16/2010 11:33 PM, Benjamin Herrenschmidt wrote:
>> On Fri, 2010-09-17 at 00:17 -0500, Kumar Gala wrote:
>>> Not sure how the 970 bit worked, but this seems a bit problematic =
for
>>> switching between kernel and application for how we do this on
>>> e500mc/e5500.  We'd have to touch the control bit on every exception
>>> path which seems ugly to me.
>>=20
>> Unless the kernel uses dcbzl (feature fixup replacement ?)
>>=20
>> In that case it's on context switch only.
>=20
> This is basically what we did.  Kernel and system libraries (glibc and
> friends) always use dcbzl, process flag indicates compatibility, touch
> the control bit on task context switch if the prev and next processes
> have different compatibility modes.
>=20
> On the 970 you have to invalidate the entire icache whenever you =
change
> the control bit.  This is a pain involving a loop that calls icbi on =
512
> cachelines.

I'm pretty sure on e500mc / e5500 you only need proper sync/isync/msync =
after the change in the control register.

- k=
