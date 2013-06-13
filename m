Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6CD342C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 17:21:30 +1000 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [BUG] PCI related panic on powerpc based board with 3.10-rcX
Date: Thu, 13 Jun 2013 09:21:24 +0200
Message-ID: <7706620.VNI3PE9pqO@pcimr>
In-Reply-To: <1371073826.18413.52@snotra>
References: <1370971739.18413.27@snotra> <34279395.MbRViMjbAR@pcimr>
 <1371073826.18413.52@snotra>
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

On Wednesday 12 June 2013 16:50:26 Scott Wood wrote:
> On 06/12/2013 03:19:30 AM, Rojhalat Ibrahim wrote:
> > On Tuesday 11 June 2013 12:28:59 Scott Wood wrote:
> > > Yes, I figured it was non-PCIe because the code change that you said
> > > helped was on the non-PCIe branch of the if/else.  Generally it's
> > 
> > good
> > 
> > > to explicitly mention the chip you're using, though.
> > > 
> > > fsl_setup_indirect_pci should be renamed to fsl_setup_indirect_pcie.
> > > Your patch above should be applied, and fsl_setup_indirect_pcie
> > 
> > should
> > 
> > > be moved into the booke/86xx ifdef to avoid an unused function
> > 
> > warning.
> > 
> > > -Scott
> > 
> > How about this patch? It uses setup_indirect_pci for the PCI case in
> > mpc83xx_add_bridge. Additionally it adds a check in
> > fsl_setup_indirect_pci
> > to only use the modified read function in case of PCIe.
> 
> If we're adding the check to fsl_setup_indirect_pci, there's no need to
> change the 83xx call back to setup_indirect_pci.  I see that 85xx is
> also callirng fsl_setup_indirect_pci for both; it'd be good to be
> consistent.
> 
> In any case, can you send a proper patch with a signoff and commit
> message?
> 
> -Scott

Where is it called for 85xx? As far as I can tell fsl_setup_indirect_pci is 
called exactly once in fsl_add_bridge and nowhere else (after applying the
proposed patch).
For 83xx the decision between PCI and PCIe has already been made at
the point where the setup function is called. So IMO it doesn't make sense
to call fsl_setup_indirect_pci and do the check again. Moreover PCIe on 83xx
uses a completely different set of functions.

I'll send the proper patch in a separate mail.

   Rojhalat
