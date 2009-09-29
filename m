Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E925B7BCC
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Sep 2009 18:29:03 +1000 (EST)
In-Reply-To: <1254212198.5256.0.camel@pasglop>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>	
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>	
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>	
	<1253843480.7103.492.camel@pasglop>
	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>	
	<OF1870F4D5.BB673882-ONC1257640.00233638-C1257640.00236DC9@transmode.se>
	<1254208057.5771.7.camel@pasglop>	
	<OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
	<1254212198.5256.0.camel@pasglop>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF598BCD92.446BD67A-ONC1257640.002DFEA5-C1257640.002E331D@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 29 Sep 2009 10:24:37 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 29/09/2009 10:16:38:
>
>
> > hmm, yes. You do get this and mysterious SEGV if you hit the but so does
> > other bugs too so this is probably due to missing invalidation.
> >
> > I suspect that something like below will fix the problem and
> > is the "correct" fix(untested, not even compiled):
>
> Ok but do we also still have to worry about the "unpopulated" TLB
> entries and invalidate them somehow when populating ?

No, this patch is to not populate the MMU with invalid entries at
all. Hopefully you can remove those invalidate 8xx TLBs hacks
you currently have.

     Jocke
