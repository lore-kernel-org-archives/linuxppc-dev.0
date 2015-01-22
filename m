Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0135.outbound.protection.outlook.com [65.55.169.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 503DA1A0DF0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 13:54:08 +1100 (AEDT)
Date: Wed, 21 Jan 2015 20:48:44 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/fsl_pci: Fix pci stack build bug with FRAME_WARN
Message-ID: <20150121204844.fda3d4ab23a8226b6cdfdaf6@freescale.com>
In-Reply-To: <1421800292.4961.215.camel@freescale.com>
References: <20150120140349.a7a9885065c241b555b91717@freescale.com>
 <1421800292.4961.215.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wang Dongsheng <dongsheng.wang@freescale.com>, linux-kernel@vger.kernel.org,
 Himangi Saraogi <himangi774@gmail.com>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, Aaron Sierra <asierra@xes-inc.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Jan 2015 18:31:32 -0600
Scott Wood <scottwood@freescale.com> wrote:

> On Tue, 2015-01-20 at 14:03 -0600, Kim Phillips wrote:
> > Fix this:
> > 
> >   CC      arch/powerpc/sysdev/fsl_pci.o
> > arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pcie_check_link':
> > arch/powerpc/sysdev/fsl_pci.c:91:1: error: the frame size of 1360 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> > 
> > when configuring FRAME_WARN, by converting the allocation from the
> > stack to the heap.  We use GFP_ATOMIC since this function can be
> > called with interrupts disabled.
> > 
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> > ---
> >  arch/powerpc/sysdev/fsl_pci.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> > index 6455c1e..635d743 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -69,11 +69,13 @@ static int fsl_pcie_check_link(struct pci_controller *hose)
> >  
> >  	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
> >  		if (hose->ops->read == fsl_indirect_read_config) {
> > -			struct pci_bus bus;
> > -			bus.number = hose->first_busno;
> > -			bus.sysdata = hose;
> > -			bus.ops = hose->ops;
> > -			indirect_read_config(&bus, 0, PCIE_LTSSM, 4, &val);
> > +			struct pci_bus *bus;
> > +			bus = kmalloc(sizeof(*bus), GFP_ATOMIC);
> > +			bus->number = hose->first_busno;
> 
> Missing check for allocation failure.

thanks.

> Do we not have a real struct pci_bus we can use here?  Or refactor
> indirect_read_config() to take hose and bus number instead?

indirect_read_config() can't be refactored because it is also used
in the generic struct pci_ops.  Unless you mean making an
__indirect_read_config that the original would call, but that
doesn't look that trivial given it calls pci_exclude_device with a
struct pci_controller hose.

> If putting a pci_bus struct on the stack is no longer OK, then
> fake_pci_bus() should be fixed as well.  I wonder if GCC is allocating
> separate pci_bus structs on the stack for this one and the one that
> early_read_config_dword() uses...

fake_pci_bus()' version is static, so it's not on the stack.

given that, maybe fsl_pcie_check_link()'s should be static too?

Kim
