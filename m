Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDC86686B7
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 02:28:13 +1100 (EST)
Date: Mon, 7 Nov 2005 08:27:19 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddedalley.com>
Message-ID: <20051107102719.GB15522@logos.cnet>
References: <200510302203.25390.pantelis.antoniou@gmail.com>
	<20051107084431.GA15180@logos.cnet>
	<6564e160d322329703e5ab866d98618b@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6564e160d322329703e5ab866d98618b@embeddedalley.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 07, 2005 at 09:35:59AM -0500, Dan Malek wrote:
> 
> On Nov 7, 2005, at 3:44 AM, Marcelo Tosatti wrote:
> 
> >Dan, I wonder why we just don't go back to v2.4 behaviour. It is not 
> >very
> >clear to me that "two exception" speedup offsets the additional code 
> >required
> >for "one exception" version. Have you actually done any measurements?
> 
> No, and I didn't actually make these changes, either :-)

Ahh, ok. sorry. I remember you arguing that it was faster this way (less
code).

> I'm working on some 8xx debugging right now, so let's experiment
> with some changes.  I don't understand why other processors, especially
> G2 cores like 82xx, aren't finding the same problems we are having
> with 8xx.  Logically, we are all doing the same thing, unless there are
> some tlb invalidates on these other processors that I'm forgetting 
> about.

I really dont know how the 82xx TLB works, so...

> We just seem to be running into stale entries, and we have to fix it.

Right - the issue Joakim noted would be one reason for the "two exception"
approach.
