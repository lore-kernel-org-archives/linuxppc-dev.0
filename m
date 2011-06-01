Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 11DA6B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 00:59:14 +1000 (EST)
Date: Wed, 1 Jun 2011 18:59:11 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/2] ppc/85xx: create a platform node for PCI EDAC device
Message-ID: <20110601145911.GA30312@oksana.dev.rtsoft.ru>
References: <1306931292-2313-1-git-send-email-dbaryshkov@gmail.com>
	<20110601132519.GA16125@oksana.dev.rtsoft.ru>
	<BANLkTi=xFcZRd4x1FQSKJzmt3A7_tZs+sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <BANLkTi=xFcZRd4x1FQSKJzmt3A7_tZs+sQ@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 01, 2011 at 06:55:35PM +0400, Dmitry Eremin-Solenikov wrote:
> On 6/1/11, Anton Vorontsov <avorontsov@mvista.com> wrote:
> > On Wed, Jun 01, 2011 at 04:28:11PM +0400, Dmitry Eremin-Solenikov wrote:
> > [...]
> >> --- a/arch/powerpc/sysdev/fsl_pci.h
> >> +++ b/arch/powerpc/sysdev/fsl_pci.h
> >> @@ -92,6 +92,7 @@ extern int fsl_add_bridge(struct device_node *dev, int
> >> is_primary);
> >>  extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
> >>  extern int mpc83xx_add_bridge(struct device_node *dev);
> >>  u64 fsl_pci_immrbar_base(struct pci_controller *hose);
> >> +int fsl_add_pci_err(void);
> >
> > With
> >
> > #ifdef CONFIG_PCI
> > int fsl_add_pci_err(void);
> > #else
> > static inline int fsl_add_pci_err(void) { return -ENODEV; }
> > #endif
> >
> > You won't need endless ifdefs in the board files:
> 
> OK, will redo this patch.

Btw, if you don't check return value of fsl_add_pci_err(), then
it would probably make sense to return void. And if you do
check it somewhere, be sure to include linux/errno.h for
-ENODEV. :-)

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
