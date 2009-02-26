Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 91426DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 10:14:07 +1100 (EST)
Subject: Re: [PATCH v2 2/2] powerpc: oprofile: enable support for ppc750
	processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@gmail.com>
In-Reply-To: <2acbd3e40902261430l77b465cqf1cb6f0f4b737e92@mail.gmail.com>
References: <1233724934.16867.290.camel@pasglop>
	<1235477399-20428-3-git-send-email-opurdila@ixiacom.com>
	<2acbd3e40902261430l77b465cqf1cb6f0f4b737e92@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 27 Feb 2009 10:13:57 +1100
Message-Id: <1235690037.7388.38.camel@pasglop>
Mime-Version: 1.0
Cc: Octavian Purdila <opurdila@ixiacom.com>,
	John J Miller <millerjo@us.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-26 at 16:30 -0600, Andy Fleming wrote:
> 
> I know this saves you some code, but it seems hacky.  It would be
> better to modify oprofile to detect the proper cpu type.  Also, this
> will screw things up if you try to use the different event set that
> the 750 has.

Agreed. Note that Jack Miller (CC) has some patches for the oprofile
side.

> Also, one more concern is the long-standing errata which makes this
> quite dangerous.  All of the versions of the 750 I'm aware of have a
> bug where if a Performance Monitor exception occurs within one cycle
> of the Decrementer exception, the cpu will lose the ability to return
> from the interrupt (SRR0/SRR1 become corrupted).  It's possible the
> 750s you have modified to support oprofile don't have this errata.
> Alternatively, we can decide we don't care, as you have to be root to
> use oprofile.  But this is why I didn't add support for anything
> before the 7450.

I think we need to advertise it as broken in some way... I -think- the
latest batch of IBM 750CL have that bug fixed but I'm not 100% certain.

Cheers,
Ben.
