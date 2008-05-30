Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BF272DE564
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 04:55:34 +1000 (EST)
Message-ID: <48404D83.4070108@freescale.com>
Date: Fri, 30 May 2008 13:54:59 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>, Kumar Gala <galak@kernel.crashing.org>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, jdl@jdl.com
Subject: Re: [PATCH] Add support for binary includes.
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<20080226003955.GA24382@localhost.localdomain>
	<7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>
	<483C4C04.9020408@freescale.com>
	<20080528235859.GA10260@yookeroo.seuss>
	<20080529000227.GB10260@yookeroo.seuss>
In-Reply-To: <20080529000227.GB10260@yookeroo.seuss>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> What I don't like is the combination of the two.  Using the /word/
> form in (1) suggests that each /word/ is a lexically distinct symbol
> with functions in different contexts: consider /dts-v1/, /include/,
> /memreserve/ - they're all used only in their own distinct context.
> Use of /word/s in (2) would suggest that each /word/ is just an
> identifier for a different function, and should all be usable in a
> similar grammtical context - which won't be true of /memreserve/,
> /dts-v1/ and any other truly lexically distinct symbols we need to
> add.

I don't understand this conclusion -- I wouldn't expect to be able to 
use "for" or "while" at file scope of C code, just because I can use 
"struct", "int", or "sizeof" there.  The slashes are simply a way of 
creating reserved words, some of which happen to be function-like.

> So, I like the notion of functions like this, but with identifiers
> that aren't /word/s.  Re-invoking the "least surprise to C
> programmers" principle, in general I think the identifiers should be
> as C identifiers (i.e. [a-zA-Z_][a-zA-Z0-9_]*).

That would make it difficult to have function-like syntax outside of 
properties.

>  With one caveat, it's
> not essential but it might be worthwhile to make built-in function
> identifiers obviously distinct from user-defined ones (if we add those
> in future).

We have a way to make them obviously distinct -- slashes. :-)

-Scott
