Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 219B3DDF4B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 00:42:38 +1000 (EST)
In-Reply-To: <E1IkKge-00060g-2l@jdl.com>
References: <E1Ik4aw-0007ud-Lu@jdl.com>
	<20071023025412.GI31839@localhost.localdomain>
	<E1IkKge-00060g-2l@jdl.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cace68e0fe3e4e257b7c63d18c805f18@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] DTC: Remove the need for the GLR Parser. 
Date: Tue, 23 Oct 2007 16:41:51 +0200
To: Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Flip a right-recursive stack-abusing rule into a left-recursive
>>> stack-friendly rule and clear up three messes in one shot: No more
>>> conflicts, no need for the GLR parser, and friendlier stackness.
>>
>> Ouch.  I'm feeling a bit stupid now,
>
> Absolutely no need for that.

If you haven't had "exp := aexp | exp aexp" beaten into you with
a big stick, maybe you should be happy about that ("'s got a nail
in it!") :-)

>> And even without glr-parser, I'm still uncomfortable with the
>> lexer<->parser execution ordering issues with the current
>> /dts-version/ proposal.  It may now be true that the order is
>> guaranteed to be correct, but it's still not exactly obvious.

If you require /dts-version/ (and similar global dtc-control stmts)
to be at the start of the file, can't you avoid this ordering problem
by starting to parse the file with a simple (hand-written) parser
(which would handle these statements) and only when you cannot parse
any more switch to the "normal" parser (which won't handle them)?
Or is this a stupid suggestion :-)


Segher
