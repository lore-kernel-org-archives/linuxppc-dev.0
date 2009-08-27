Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EF858B7B6A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 19:30:54 +1000 (EST)
Subject: Re: Question : about difference with bdnz and bdnz+
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: HongWoo Lee <hongwoo7@gmail.com>
In-Reply-To: <4A9613E3.8020700@gmail.com>
References: <4A9613E3.8020700@gmail.com>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 19:30:47 +1000
Message-Id: <1251365447.20467.50.camel@pasglop>
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

On Thu, 2009-08-27 at 14:04 +0900, HongWoo Lee wrote:
> And I have a question about bdnz+ instruction.
> Through googling, I learned that bdnz does decrement count register
> and 
> branch if it is still nonzero.
> But I couldn't find what "bdnz+" is.
> Can anybody explain to me what it is ??

On PowerPC, branch instructions can have a "hint" (+ or - added to the
mnemonic) which indicates to the processor whether the branch is likely
to be taken or not, and overrides the dynamic branch prediction.

In most case, it's not necessary though I suppose in the case at hand,
we are pretty confident that we're going to loop a lot more times than
exit from the loop so it won't hurt to put the hint in there.

Note that there have been subtle changes in the way those hints work
between earlier and modern PowerPC processors and the way they are
encoded will be different depending on what CPU you are building for,
but that's an entirely different headache :-)

Cheers,
Ben.
