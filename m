Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E0B9B7BA8
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 19:47:42 +1000 (EST)
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF028339A2.3A7A8D6F-ONC125763C.002DE73B-C125763C.002ECF90@transmode.se>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
	<1253843480.7103.492.camel@pasglop> <1253847827.7103.504.camel@pasglop>
	<OF028339A2.3A7A8D6F-ONC125763C.002DE73B-C125763C.002ECF90@transmode.se>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 19:47:34 +1000
Message-Id: <1253872054.7103.519.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-09-25 at 10:31 +0200, Joakim Tjernlund wrote:
> 
> The main problem with 8xx it does not update the DAR register in
> the TLB Miss/Fault handlers for cache instructions :( It on old bug
> that was found only some years ago.
> 
> I think the old comment is correct though, as I recall it was Marcelo
> that found the problem and added the workaround.

But the TLB needs flushing on more than just the cache instructions,
no ?

IE. We take a TLB miss, there's no valid PTE, we put one of those
"unpopulated" entries in and get into the page fault, at which point we
do a set_pte, we -still- need to do an invalidation to get rid of the
unpopulated entry so it gets a new TLB miss no ? Without that, it's just
going to fault over and over again...

In any case, I think flushing unconditionally the target address isn't
going to hurt since we are just changing its PTE anyways.

As for the DAR problem, I'm not sure whether we really need a workaround
since I haven't seem much people complaining about it so far :-)

Can you educate me more on the problem ? Can it be fixed without
bloating those handlers to oblivion ?

Cheers,
Ben.
