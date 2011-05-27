Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 3F7D1B6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 May 2011 02:52:42 +1000 (EST)
Date: Fri, 27 May 2011 11:51:08 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
Message-ID: <20110527165108.GA1752@crust.elkhashab.com>
References: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
	<1302306484.2458.64.camel@pasglop>
	<178c7df4696bacdd1510bacae143222a@mail.gmail.com>
	<20110429170240.GA21384@crust.elkhashab.com>
	<1304109476.2513.243.camel@pasglop>
	<1304487166.2513.351.camel@pasglop>
	<BANLkTi=BaYhw92wYHp9rPvz1yq2H1p0G9w@mail.gmail.com>
	<20110509160935.GA14965@crust.elkhashab.com>
	<6a09a426f126fb315b773fc207d68eb9@mail.gmail.com>
	<1306208412.7481.214.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306208412.7481.214.camel@pasglop>
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

On Tue, May 24, 2011 at 01:40:12PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2011-05-12 at 11:16 -0700, Tirumala Marri wrote:
> 
>  The register above
> > PECFGn_DLLSTA is actually in the PCIe configuration space so
> > we would have to map that in to be able to read that
> > register during the link check.  Is that correct or ok?
> > [marri] yes, you need to program DCR register access these local PCIE_CFG
> > registers.
> 
> We do I think, tho we might have to re-order some stuff. I'm facing a
> similar issue with some internal design here, I'm thinking off adding a
> new hook to the ppc4xx_pciex_hwops for link checking to replace the SDR
> business.

That would probably solve the existing problem.  I might be
remembering it wrong (or reading it wrong) or both.  But I
thought that the config space was mapped in the setup_hose
that happens after (and if) the link check finished
successfully.  

> The interesting question of course is whether that 460SX stuff is the
> same as what we're using internally :-)

Not sure how I would know --  But with my eiger kit, I got a
cd from amcc that had a patched 2.6.30 or something kernel
in it to support the 460SX.  The pci code was basically
subverted by adding a "port->link=1" at the very end of the
link check to always force it to succeed.  However this code
never appeared in the public git repositories, so I am not
sure how the 460SX functioned (if it ever did) since the
link check that is in there now can't work on that SOC.

> > Lastly, what was the reason for forcing the original code to
> > be GEN-1 speeds?
> > [marri] Gen-2 need some extra checks compared to Gen-1.
> > There were not many Gen-2 devices at the time of submission
> > To test them.
> 
> Can we fix that ?
> 

I took care of that in my patch.  Basically it let the
system go to gen-2 speeds and negotiate down.

Ayman
