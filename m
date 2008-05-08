Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 101A7DDEED
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 17:22:04 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Reintroduce O_SYNC flag to make DRAM	non-cached.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Spence <nick.spence@freescale.com>
In-Reply-To: <4822A8F0.1010602@freescale.com>
References: <1210224392246-git-send-email-nick.spence@freescale.com>
	<18466.38047.531381.157886@cargo.ozlabs.ibm.com>
	<9E50B2A5FE44294CBF877745D9A4125F01D37125@az33exm24.fsl.freescale.net>
	<1210229743.1421.36.camel@pasglop>  <4822A8F0.1010602@freescale.com>
Content-Type: text/plain
Date: Thu, 08 May 2008 17:21:54 +1000
Message-Id: <1210231314.1421.43.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-05-08 at 00:17 -0700, Nick Spence wrote:
> The page protection seemed to be allocated on a per pte basis, where 
> each PTE is a small fixed size. I will need to check the TLB setup
> further.

The problem is that it will then be part of the linear mapping, which
means you'll end up with a double cacheable & non-cacheable mapping for
that memory, this is not nice ... it might work as long as we stick to
having G bit set for the whole linear mapping but it's going to come
back and bite.

I still think you should look closely whether it could be carved out
of the end of memory... even if that involves changing application
code.

Now, if you aren't afraid of cache paradox caused by the linear
mapping, then carve it out of the LMB wherever it is rather than
lmb_reserve() it. That would probably work.

Ben.
