Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10F26B7B68
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 16:42:24 +1100 (EST)
In-Reply-To: <1255569170.2347.62.camel@pasglop>
References: <20091015004127.GA15570@laura.chatsunix.int.mrv.com>	
	<1255568772.2347.60.camel@pasglop>
	<20091015010855.GA32710@compile2.chatsunix.int.mrv.com>
	<1255569170.2347.62.camel@pasglop>
Subject: Re: I think I have 8xx working...
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFA38A7495.FD13F032-ONC1257650.001E7457-C1257650.001F51B8@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 15 Oct 2009 07:42:05 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 15/10/2009 03:12:50:

>
> On Wed, 2009-10-14 at 18:08 -0700, Rex Feany wrote:
> > Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):
> >
> > > On Wed, 2009-10-14 at 17:41 -0700, Rex Feany wrote:
> > > > The biggest problem for me turned out to be the MMU context IDs being
> > > > clamped to 32 when the 8xx only has 16. With this, things are a bit more
> > > > stable :)
> > >
> > > This is with Joakim patches or without ?
> >
> > with just one: adding tlbil_va() to do_page_fault().
>
> Ah cool, at least that keeps my sanity, I didn't get how it could work
> at all without that bit :-)
>
> Scott, Joakim: It will be interesting to figure out exactly what is the
> condition where that is necessary. It definitely should make the one
> in set_pte_filter() or ptep_set_access_flags_filter() unnecessary.
>
> Joakim, you mentioned increased amount of TLB errors or misses when
> doing that too often, that sounds a bit weird and worth investigating

I didn't say that, did I? More like:
if I don't do tlbil_va at all I get a lot of extra/duplicate TLB errors
for the same address. Adding the patch makes these go away.
I guess one could do tlbil_va unconditionally but I didn't
see any improvements from doing that, but this was all on 2.4

>
> Finally we could implement preload from update_mmu_cache() but that's a
> different matter alltogether.
>
> Cheers,
> Ben.
>
>
>
>
