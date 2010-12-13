Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9CD8CB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Dec 2010 09:28:50 +1100 (EST)
In-Reply-To: <20101213134950.258609b4@udp111988uds.am.freescale.net>
References: <OF51D61C57.96435CC9-ONC12577F6.00326299-C12577F6.0032BA93@transmode.se>	<AE90C24D6B3A694183C094C60CF0A2F6D8ABFB@saturn3.aculab.com>
	<OF4BAAB822.8E759F4C-ONC12577F8.00393E37-C12577F8.0039DC9E@transmode.se>	<20101213113356.1596c6a6@udp111988uds.am.freescale.net>
	<OF45E5CF67.CA505B87-ONC12577F8.00610A85-C12577F8.00612FDB@transmode.se>	<20101213115131.57050e1d@udp111988uds.am.freescale.net>
	<OFB1D66F80.0CE3DBB3-ONC12577F8.006ADF11-C12577F8.006B2893@transmode.se>
	<20101213134950.258609b4@udp111988uds.am.freescale.net>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF116AA639.7FAF688C-ONC12577F8.007B5633-C12577F8.007B7B02@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 13 Dec 2010 23:28:44 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Mark Mason <mason@postdiluvian.org>, David Laight <David.Laight@ACULAB.COM>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 2010/12/13 20:49:50:
>
> On Mon, 13 Dec 2010 20:30:27 +0100
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>
> > Scott Wood <scottwood@freescale.com> wrote on 2010/12/13 18:51:31:
> > >
> > > On Mon, 13 Dec 2010 18:41:32 +0100
> > > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > >
> > > > Scott Wood <scottwood@freescale.com> wrote on 2010/12/13 18:33:56:
> > > > >
> > > > > On Mon, 13 Dec 2010 11:32:00 +0100
> > > > > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > > >
> > > > > > What if one has several NAND chips to build a big FS? Is the NAND
> > > > > > controller equipped to handle that?
> > > > >
> > > > > FCM can drive one NAND chip per eLBC chipselect, though possibly you
> > > > > could go beyond that with a board-logic chipselect mechanism.
> > > >
> > > > hmm, then I guess one would have to use one GPIO/IRQ per NAND chip?
> > >
> > > Couldn't you just tie together all the open-drain busy lines before you
> > > invert it?  You'll only be driving one NAND chip at a time anyway; the
> > > others should not be asserting busy.
> >
> > hmm, I guess that would work(didn't know they were open-drain), thanks.
> > Is that how the FCM do it?
>
> Yes, that's what started this discussion. :-)

True, I must be getting old :)

>
> The problem there is that they share the line with all chipselects,
> NAND or otherwise.

Right, thanks for reminding me.
