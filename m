Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7153FB7B84
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 10:15:56 +1100 (EST)
In-Reply-To: <1254954084.2409.16.camel@pasglop>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-5-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254950301.2409.11.camel@pasglop>
	<OF36596A29.5EDD5659-ONC1257648.0079FC5B-C1257648.007A1D0B@transmode.se>
	<1254954084.2409.16.camel@pasglop>
Subject: Re: [PATCH 4/6] 8xx: Tag DAR with 0x00f0 to catch buggy instructions.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF763A4466.C236C6F4-ONC1257648.007F68D9-C1257648.007F85A5@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 8 Oct 2009 01:12:52 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 08/10/2009 00:21:24:
>
> On Thu, 2009-10-08 at 00:13 +0200, Joakim Tjernlund wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 07/10/2009 23:18:21:
> > >
> > > On Wed, 2009-10-07 at 22:46 +0200, Joakim Tjernlund wrote:
> > > > dcbz, dcbf, dcbi, dcbst and icbi do not set DAR when they
> > > > cause a DTLB Error. Dectect this by tagging DAR with 0x00f0
> > > > at every exception exit that modifies DAR.
> > > > Test for DAR=0x00f0 in DataTLBError and bail
> > > > to handle_page_fault().
> > >
> > > Why not -1 ? :-)
> >
> > Because 0x00f0 is already in use in the TLB fast path, saves one insn.
>
> But will cause weird things if the user really uses 0xf0 (though granted
> that's unlikely :-)

Yeah, you will most likely end up with a segv anyway.
