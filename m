Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE9EAB6F8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 May 2011 08:57:24 +1000 (EST)
Subject: Re: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20110527165108.GA1752@crust.elkhashab.com>
References: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
	<1302306484.2458.64.camel@pasglop>
	<178c7df4696bacdd1510bacae143222a@mail.gmail.com>
	<20110429170240.GA21384@crust.elkhashab.com>
	<1304109476.2513.243.camel@pasglop> <1304487166.2513.351.camel@pasglop>
	<BANLkTi=BaYhw92wYHp9rPvz1yq2H1p0G9w@mail.gmail.com>
	<20110509160935.GA14965@crust.elkhashab.com>
	<6a09a426f126fb315b773fc207d68eb9@mail.gmail.com>
	<1306208412.7481.214.camel@pasglop>
	<20110527165108.GA1752@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 28 May 2011 08:57:12 +1000
Message-ID: <1306537032.7481.552.camel@pasglop>
Mime-Version: 1.0
Cc: Tirumala Marri <tmarri@apm.com>, linuxppc-dev@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-05-27 at 11:51 -0500, Ayman El-Khashab wrote:
> On Tue, May 24, 2011 at 01:40:12PM +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2011-05-12 at 11:16 -0700, Tirumala Marri wrote:
> > 
> >  The register above
> > > PECFGn_DLLSTA is actually in the PCIe configuration space so
> > > we would have to map that in to be able to read that
> > > register during the link check.  Is that correct or ok?
> > > [marri] yes, you need to program DCR register access these local PCIE_CFG
> > > registers.
> > 
> > We do I think, tho we might have to re-order some stuff. I'm facing a
> > similar issue with some internal design here, I'm thinking off adding a
> > new hook to the ppc4xx_pciex_hwops for link checking to replace the SDR
> > business.
> 
> That would probably solve the existing problem.  I might be
> remembering it wrong (or reading it wrong) or both.  But I
> thought that the config space was mapped in the setup_hose
> that happens after (and if) the link check finished
> successfully.  

Yes but we already map separately the host part and the generic part of
cfg, so it wouldn't be hard to move one of these around.

> > The interesting question of course is whether that 460SX stuff is the
> > same as what we're using internally :-)
> 
> Not sure how I would know --  But with my eiger kit, I got a
> cd from amcc that had a patched 2.6.30 or something kernel
> in it to support the 460SX.  The pci code was basically
> subverted by adding a "port->link=1" at the very end of the
> link check to always force it to succeed.  

Niiiiiiice .... not. And they didn't even bothered to submit
anything :-(

> However this code
> never appeared in the public git repositories, so I am not
> sure how the 460SX functioned (if it ever did) since the
> link check that is in there now can't work on that SOC.

Yeah odd. Looks like MyAMCC account is no longer working so I can't get
to the docs, at least until I create a new one and get it re-authorized
I suppose.

Anyways, I'll come up with something (or rather Tony Breeds will) some
time next week that does this refactoring and we'll see what's up from
there.

> > > Lastly, what was the reason for forcing the original code to
> > > be GEN-1 speeds?
> > > [marri] Gen-2 need some extra checks compared to Gen-1.
> > > There were not many Gen-2 devices at the time of submission
> > > To test them.
> > 
> > Can we fix that ?
> > 
> 
> I took care of that in my patch.  Basically it let the
> system go to gen-2 speeds and negotiate down.

Ah ok good.

Cheers,
Ben.
