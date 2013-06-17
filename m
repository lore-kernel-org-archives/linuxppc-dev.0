Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3C0D72C01D4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 23:15:46 +1000 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc/pci: Fix setup of Freescale PCI / PCIe
 controllers
Date: Mon, 17 Jun 2013 15:15:33 +0200
Message-ID: <2435509.QyTW5GJC53@pcimr>
In-Reply-To: <1371241083.2996.7@snotra>
References: <1371241083.2996.7@snotra>
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

On Friday 14 June 2013 15:18:03 Scott Wood wrote:
> On 06/14/2013 04:05:34 AM, Rojhalat Ibrahim wrote:
> > Commit 50d8f87d2b3 (powerpc/fsl-pci Make PCIe hotplug work with
> > Freescale
> > PCIe controllers) does not handle non-PCIe controllers properly,
> > which causes
> > a panic during boot for certain configurations.
> > This patch fixes the issue by calling setup_indirect_pci for all
> > device types.
> > fsl_indirect_read_config is now only used for booke/86xx PCIe
> > controllers.
> > 
> > Reported-by: Michael Guntsche <mike@it-loops.com>
> > Cc: Scott Wood <scottwood@freescale.com>
> > Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>
> > ---
> > v2: Make it more consistent.
> > 
> >  arch/powerpc/sysdev/fsl_pci.c |   20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c
> > b/arch/powerpc/sysdev/fsl_pci.c
> > index 028ac1f..5682c8a 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -97,20 +97,12 @@ static int fsl_indirect_read_config(struct
> > pci_bus *bus,
> > unsigned int devfn,
> > 
> >  	return indirect_read_config(bus, devfn, offset, len, val);
> >  
> >  }
> > 
> > -static struct pci_ops fsl_indirect_pci_ops =
> > +static struct pci_ops fsl_indirect_pcie_ops =
> > 
> >  {
> >  
> >  	.read = fsl_indirect_read_config,
> >  	.write = indirect_write_config,
> >  
> >  };
> 
> On 83xx:
> cc1: warnings being treated as errors
> /home/scott/fsl/git/linux/upstream/arch/powerpc/sysdev/fsl_pci.c:100:23:
> error: 'fsl_indirect_pcie_ops' defined but not used
> make[2]: *** [arch/powerpc/sysdev/fsl_pci.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> 
> I can fix this when applying, but this makes me wonder how you tested
> it, given that the whole point is to fix 83xx...  Did you fix this and
> then accidentally sent a stale version?
> 
> Also, please be careful that the patch doesn't get line wrapped -- I
> had to manually unwrap a couple places.  Use git send-email if you
> can't get KMail to cooperate.
> 
> -Scott

Sorry about the mess. I'll send a v3.
Please note: I don't have an 83xx system. So I can only test if it compiles, 
which I obviously did not do with the right config.

   Rojhalat
