Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CABE6B7B65
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 17:46:42 +1100 (EST)
In-Reply-To: <1254961699.2417.1.camel@pasglop>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254950092.2409.7.camel@pasglop>
	<OF8D2D6F89.B0DB8BCB-ONC1257648.00787F6E-C1257648.00799B83@transmode.se>
	<1254954017.2409.14.camel@pasglop>	
	<OFCA7943E6.AFEF924A-ONC1257648.007E27B0-C1257648.007F62E9@transmode.se>
	<1254960296.2733.3.camel@pasglop>	
	<OFE2E96EF3.F21AB563-ONC1257649.0000A4AC-C1257649.0001C04D@transmode.se>
	<1254961699.2417.1.camel@pasglop>
Subject: Re: [PATCH 2/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFB3DEEF6E.1F3F6AC5-ONC1257649.00246C73-C1257649.002523BD@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 8 Oct 2009 08:45:39 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 08/10/2009 02:28:19:
>
> On Thu, 2009-10-08 at 02:19 +0200, Joakim Tjernlund wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 08/10/2009 02:04:56:
> > >
> > >
> > > > Yes it does. If one adds HWEXEC it will fail, right?
> > >
> > > Why ? We can just filter out DSISR, we don't really care why it failed
> > > as long as we know whether it was a store or not.
> > >
> > > > Also this count as a read and you could easily end up
> > > > in the protection case(in 2.4 you do)
> > >
> > > I'm not sure what you mean by "the protection case" Again, the C code
> > > shouldn't care.
> >
> > it does, and it should. How else should you know if you try
> > to read a NA space?
>
> Generic code should sort it out in handle_mm_fault() (or earlier if it
> can't find a VMA at all).

How can it? You need to know more that just read and write.

>
> The DSISR munging is really not necessary I believe.

Well, it is today and I don't see how you can remove it.

>
> > 2.4 and 2.6 have the same handling in asm.
>
> Yeah but the C code, especially the generic part, is different.

yes, but it seem to work the same.

>
> > hmm, maybe I should just call C, but 8xx isn't a speed monster so every
> > cycle counts :)
>
> But that's a slow path anyways.

How so? You take a TLB Error for the first write to
every page.

 Jocke
