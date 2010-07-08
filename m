Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 383E5B7090
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 20:49:22 +1000 (EST)
Subject: Re: [PATCH] Add cmd64x IDE driver to default pmac32 config
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: lawrence rust <lawrence@softsystem.co.uk>
In-Reply-To: <1278579667.2850.5.camel@gagarin>
References: <1278181316.3232.45.camel@gagarin>
	<1278565221.28659.74.camel@pasglop> <1278569907.1411.19.camel@gagarin>
	<1278570620.28659.79.camel@pasglop> <1278579667.2850.5.camel@gagarin>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 20:49:14 +1000
Message-ID: <1278586154.28659.93.camel@pasglop>
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

On Thu, 2010-07-08 at 11:01 +0200, lawrence rust wrote:
> On Thu, 2010-07-08 at 16:30 +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2010-07-08 at 08:18 +0200, lawrence rust wrote:
> > > 
> > > Sure. it would be preferable but unfortunately the PowerMac on-board IDE
> > > controller (CONFIG_BLK_DEV_IDE_PMAC), used for the DVD drive on B/W
> > > G3's, doesn't have a PATA equivalent.  So it's pragmatic (until the IDE
> > > code is removed) to use the IDE cmd64x driver to minimise kernel code
> > > size.
> > 
> > Sure it does nowadays: drivers/ata/pata_macio.c :-)
> > 
> > I merged that upstream in december last year, so it didn't make 2.6.32
> > which your distro probably uses, but it is in .33 and later.
> 
> OK I see that - good news.  However, for the moment I believe that it's
> safer to stay with IDE.  It's the smallest of changes but the wholesale
> move to libata could well break numerous system install scripts - e.g.
> for yaboot.

Well, distros have moved over mostly... I don't think keeping the
defaults to the old stuff upstream is going to help getting things like
yaboot fixed. I'll talk to Tony see what the situation there is
tomorrow, but I'd rather fix yaboot and switch the default over.

Ben.
