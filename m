Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 598BDB6F98
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 20:39:56 +1000 (EST)
Subject: Re: [PATCH] perf: powerpc: Disable pagefaults during callchain
	stack read
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1312192792.2617.381.camel@laptop>
References: <1312059200-11563-1-git-send-email-dsahern@gmail.com>
	<1312192792.2617.381.camel@laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Aug 2011 20:39:07 +1000
Message-ID: <1312195147.8793.794.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
	acme@ghostprotocols.net, David Ahern <dsahern@gmail.com>,
	mingo@elte.hu, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-08-01 at 11:59 +0200, Peter Zijlstra wrote:
> > Signed-off-by: David Ahern <dsahern@gmail.com>
> > CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > CC: Anton Blanchard <anton@samba.org> 
> 
> Hmm, Paul, didn't you fix something like this early on? Anyway, I've
> no
> objections since I'm really not familiar enough with the PPC side of
> things. 

I'm travelling so I haven't had a chance to review properly or even test
but it looks like an ad-hoc fix for the immediate problem.

Ultimately, I want to rework that stuff to do a __gup_fast like x86 does
(maybe as a fallback from an attempt at access first) so we work around
access permissions blocked by lack of dirty/accessed bits but in the
meantime, this should fix the immediate issue.

Cheers,
Ben.
