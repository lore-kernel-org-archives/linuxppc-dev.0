Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E4726B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 07:51:23 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55DD8DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 07:51:22 +1000 (EST)
Subject: Re: 2.6.31-rc5-git2 crash on a idle system.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A7ADBB1.3050906@in.ibm.com>
References: <4A78292A.5000607@in.ibm.com>
	<1249421223.18245.36.camel@pasglop> <4A794E26.8080207@in.ibm.com>
	<1249465934.18245.54.camel@pasglop>  <4A7ADBB1.3050906@in.ibm.com>
Content-Type: text/plain
Date: Fri, 07 Aug 2009 07:51:09 +1000
Message-Id: <1249595469.24311.5.camel@pasglop>
Mime-Version: 1.0
Cc: neilb@suse.de, linuxppc-dev@ozlabs.org, linux-raid@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-06 at 19:03 +0530, Sachin Sant wrote:
> I added few printks in the initcall debug code patch. The o/p suggests
> that by the time first initicall debug message is printed the code is
> already corrupted. Further debug suggests, when start_kernel() is
> called the code at address(0xc000000000600000) is already corrupted.
> About 28 bytes of code starting from the above address is
> overwritten. 
> 
> I will try to add few more debug statements to find the place where
> this corruption might me happening.

Hrm... start_kernel is very very early... strange. Can you double check
that the actual kernel image contains the right stuff ? Also, what
distro are you using to test that and how are you booting that kernel ?

You can always add something to prom_init.c to test (though beware you
aren't relocated yet so you need to offset the addresses).

Cheers,
Ben.
