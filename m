Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4141F2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 17:56:05 +1000 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [BUG] PCI related panic on powerpc based board with 3.10-rcX
Date: Fri, 14 Jun 2013 09:55:50 +0200
Message-ID: <6071007.YKP3JmbiTP@pcimr>
In-Reply-To: <1371142157.2028.9@snotra>
References: <1370971739.18413.27@snotra> <7706620.VNI3PE9pqO@pcimr>
 <1371142157.2028.9@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Guntsche <michael.guntsche@it-loops.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 13 June 2013 11:49:17 Scott Wood wrote:
> On 06/13/2013 02:21:24 AM, Rojhalat Ibrahim wrote:
> > On Wednesday 12 June 2013 16:50:26 Scott Wood wrote:
> > > On 06/12/2013 03:19:30 AM, Rojhalat Ibrahim wrote:
> > > > On Tuesday 11 June 2013 12:28:59 Scott Wood wrote:
> > > > > Yes, I figured it was non-PCIe because the code change that you
> > 
> > said
> > 
> > > > > helped was on the non-PCIe branch of the if/else.  Generally
> > 
> > it's
> > 
> > > > good
> > > > 
> > > > > to explicitly mention the chip you're using, though.
> > > > > 
> > > > > fsl_setup_indirect_pci should be renamed to
> > 
> > fsl_setup_indirect_pcie.
> > 
> > > > > Your patch above should be applied, and fsl_setup_indirect_pcie
> > > > 
> > > > should
> > > > 
> > > > > be moved into the booke/86xx ifdef to avoid an unused function
> > > > 
> > > > warning.
> > > > 
> > > > > -Scott
> > > > 
> > > > How about this patch? It uses setup_indirect_pci for the PCI case
> > 
> > in
> > 
> > > > mpc83xx_add_bridge. Additionally it adds a check in
> > > > fsl_setup_indirect_pci
> > > > to only use the modified read function in case of PCIe.
> > > 
> > > If we're adding the check to fsl_setup_indirect_pci, there's no
> > 
> > need to
> > 
> > > change the 83xx call back to setup_indirect_pci.  I see that 85xx is
> > > also callirng fsl_setup_indirect_pci for both; it'd be good to be
> > > consistent.
> > > 
> > > In any case, can you send a proper patch with a signoff and commit
> > > message?
> > > 
> > > -Scott
> > 
> > Where is it called for 85xx? As far as I can tell
> > fsl_setup_indirect_pci is
> > called exactly once in fsl_add_bridge and nowhere else (after
> > applying the
> > proposed patch).
> 
> fsl_add_bridge() is where it's called for 85xx.
> 
> > For 83xx the decision between PCI and PCIe has already been made at
> > the point where the setup function is called. So IMO it doesn't make
> > sense
> > to call fsl_setup_indirect_pci and do the check again. Moreover PCIe
> > on 83xx
> > uses a completely different set of functions.
> 
> My concern is consistency.  E.g. if 85xx is using
> fsl_setup_indirect_pci for both, but 83xx isn't, then a developer using
> 83xx could end up breaking 85xx by introducing another PCIe dependency
> in fsl_setup_indirect_pci.  Or an 85xx developer could put something
> non-PCIe-related in fsl_setup_indirect_pci that 83xx would benefit from.
> 
> Alternatively, you could call it fsl_setup_indirect_pcie, and move the
> PCIe check into fsl_add_bridge().
> 
> -Scott

Ok. I'll post a v2 of the patch.

   Rojhalat
