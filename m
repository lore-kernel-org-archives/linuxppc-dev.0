Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6A470B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 21:31:40 +1000 (EST)
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C87D9DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 21:31:39 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6GBPwhX010534
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 07:25:58 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6GBVYIA254100
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 07:31:34 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6GBVY6X018835
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 07:31:34 -0400
Date: Thu, 16 Jul 2009 07:31:00 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] kmemleak: Allow kmemleak to be built on powerpc
Message-ID: <20090716113100.GB7102@zod.rchland.ibm.com>
References: <f18967360113efe4354a9ad0d71ead9a0f7579ea.1247707485.git.michael@ellerman.id.au>
	<1247730230.18228.5.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1247730230.18228.5.camel@concordia>
Cc: catalin.marinas@arm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 16, 2009 at 05:43:50PM +1000, Michael Ellerman wrote:
>On Thu, 2009-07-16 at 11:25 +1000, Michael Ellerman wrote:
>> Very lightly tested, doesn't crash the kernel.
>> 
>> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>> ---
>> 
>> It doesn't look like we actually need to add any support in the
>> arch code - or is there something I'm missing?
>
>Hmm, I think we want to add annotations in lib/lmb.c don't we? That's
>our low-level pre-bootmem allocator.
>
>And we have the same problem with _edata as x86.

I'll point out that the Fedora developers enabled this in the rawhide kernels
for 3 days, and then turned it back off because most of the things found were
false positives.

Might still be worth poking at, but until it gets a bit less buggy itself it
could be a timesink.

josh
