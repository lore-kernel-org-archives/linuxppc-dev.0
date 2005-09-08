Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98C8468110
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 10:55:54 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <00a1f47bb2edbbc001c2267191aa36f0@embeddededge.com>
References: <20050907230324.GC7513@dmt.cnet> <1126139332.29803.0.camel@gaston>
	<00a1f47bb2edbbc001c2267191aa36f0@embeddededge.com>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 10:55:40 +1000
Message-Id: <1126140940.29803.2.camel@gaston>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] add big endian version of ld_/st_ IO access macros and
	convert main 8xx code to use it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-09-07 at 20:42 -0400, Dan Malek wrote:
> On Sep 7, 2005, at 8:28 PM, Benjamin Herrenschmidt wrote:
> 
> > I'm not fan of the approach. You should use in_/out_ macros for IOs. If
> > you don't need eieio on 8xx , then just #ifdef it out of the
> > implementation of these.
> 
> Yeah, #ifdef :-)  That patch wouldn't go anywhere (well,
> to /dev/null perhaps).

Heh, it can be done properly: use an eieio() macro/inline and have
_that_ be #ifdef'ed to nothing on 8xx...

> We can just use the in_/out_ macros that are there.  The eieio
> doesn't hurt anything on the 8xx.

Ok, in that case, I don't see any problem.

Ben.
