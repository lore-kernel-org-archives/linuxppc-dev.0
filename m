Return-Path: <michael@ellerman.id.au>
Date: Mon, 22 Apr 2013 12:56:37 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] powerpc/powernv: Patch MSI EOI handler on P8
Message-ID: <20130422025636.GB24739@concordia>
References: <1366363965-23281-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366363965-23281-3-git-send-email-shangw@linux.vnet.ibm.com>
 <20130421233436.GB22246@concordia>
 <20130422014533.GA7902@shangw.(null)>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130422014533.GA7902@shangw.(null)>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 22, 2013 at 09:45:33AM +0800, Gavin Shan wrote:
> On Mon, Apr 22, 2013 at 09:34:36AM +1000, Michael Ellerman wrote:
> >On Fri, Apr 19, 2013 at 05:32:45PM +0800, Gavin Shan wrote:
> >> The EOI handler of MSI/MSI-X interrupts for P8 (PHB3) need additional
> >> steps to handle the P/Q bits in IVE before EOIing the corresponding
> >> interrupt. The patch changes the EOI handler to cover that.
> 
> Thanks for your time to review it, Michael. By the way, I think I need
> rebase the patch since the patch fb1b55d654a7038ca6337fbf55839a308c9bc1a7
> ("Using bitmap to manage MSI") has been merged to linux-next.
> 
> >> diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
> >> index 48861d3..289355e 100644
> >> --- a/arch/powerpc/sysdev/xics/icp-native.c
> >> +++ b/arch/powerpc/sysdev/xics/icp-native.c
> >> @@ -27,6 +27,10 @@
> >>  #include <asm/xics.h>
> >>  #include <asm/kvm_ppc.h>
> >>  
> >> +#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)
> >> +extern int pnv_pci_msi_eoi(unsigned int hw_irq);
> >> +#endif
> >
> >You don't need to #ifdef the extern. But it should be in a header, not
> >here.
> >
> 
> Ok. I'll put it into asm/xics.h, but I want to confirm we needn't
> #ifdef when moving it to asm/xics.h?

No you don't need it #ifdef'd. It's just extra noise in the file, and
doesn't really add anything IMHO.

cheers
