Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 556C31007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 17:25:03 +1000 (EST)
Subject: Re: Mac Mini suspend issues - misidentified model
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Crichton <crichton@gmail.com>
In-Reply-To: <4C10EDA2.2080303@gmail.com>
References: <4C10EDA2.2080303@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Jun 2010 17:24:56 +1000
Message-ID: <1276241096.1962.135.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-06-10 at 09:50 -0400, Mark Crichton wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I've dug up and revived my old Mac Mini (PPC) and been trying to get it
> to work again. I was looking at getting the system to suspend to ram,
> but it didn't seem to be working. So, I tried to trace down the problem.

Well, for one, we never got the code to resume the on board video card
on it right... I have ways to sort it out and an old Mac mini here so I
suppose I could give it a go but I really don't have the time to do so
at the moment.

Basically, we need to run the MacOS ATI driver for it within the shell
of my "ndrver" utility to generate a trace of all the accesses it
performs to the chip to suspend and resume it, and use that to improve
the support in radeonfb for it.

> I took a look at the kernel code, and I think I may have found the
> issue. According to /proc/cpuinfo, my model is a "PowerMac10,2". Looking
> at platforms/powermac/feature.c, I only see an entry for "PowerMac10,1".
> - From my understanding of the code, this means my machine doesn't get
> PMAC_MB_MAY_SLEEP set, hence no suspend to ram.

Indeed, it looks like I never encountered a 10,2 before. Can you send me
a tarball of /proc/device-tree so I can compare it to see if there's any
other interesting difference ?

> I can easily get a patch together to just copy the PowerMac10,1 entry in
> pmac_mb_defs, for the PowerMac10,2, but I also was wondering if there's
> some issues I may run into. However, from what I see in the code, this
> seems to be a pretty risk-free operation.
> 
> Am I on the right track for this one?

You are on the right track but at the very beginning of it :-)

Cheers,
Ben.

> Thanks,
> Mark Crichton
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAkwQ7aIACgkQOfj2Ja/u/oBxYACeOX5jUQOJ5XloojtoZJXneZL/
> 734An1mP41QPuLg/RtVllmgQjgdBxdBJ
> =LLH3
> -----END PGP SIGNATURE-----
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
