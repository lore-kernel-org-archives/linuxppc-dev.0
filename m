Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "aun.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6CB6968761
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Nov 2005 23:33:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17273.54692.917859.828838@alkaid.it.uu.se>
Date: Tue, 15 Nov 2005 13:33:40 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1132039305.5646.17.camel@gaston>
References: <1132039305.5646.17.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc: Fix boot with yaboot with ARCH=ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:
 > The merge of machine types broke boot with yaboot & ARCH=ppc due to the
 > old code still retreiving the old-syle machine type passed in by yaboot.
 > This patch fixes it by translating those old numbers. Since that whole
 > mecanism is deprecated, this is a temporary fix until ARCH=ppc uses the
 > new prom_init that the merged architecture now uses for both ppc32 and
 > ppc64 (after 2.6.15)
 > 
 > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This fixed my eMac, thanks.

Acked-by: Mikael Pettersson <mikpe@csd.uu.se>

 > 
 > Index: linux-work/arch/ppc/kernel/setup.c
 > ===================================================================
 > --- linux-work.orig/arch/ppc/kernel/setup.c	2005-11-15 18:15:23.000000000 +1100
 > +++ linux-work/arch/ppc/kernel/setup.c	2005-11-15 18:18:37.000000000 +1100
 > @@ -602,7 +602,19 @@
 >  #endif /* CONFIG_BLK_DEV_INITRD */
 >  #ifdef CONFIG_PPC_MULTIPLATFORM
 >  		case BI_MACHTYPE:
 > -			_machine = data[0];
 > +			/* Machine types changed with the merge. Since the
 > +			 * bootinfo are now deprecated, we can just hard code
 > +			 * the appropriate conversion here for when we are
 > +			 * called with yaboot which passes us a machine type
 > +			 * this way.
 > +			 */
 > +			switch(data[0]) {
 > +			case 1: _machine = _MACH_prep; break;
 > +			case 2: _machine = _MACH_Pmac; break;
 > +			case 4: _machine = _MACH_chrp; break;
 > +			default:
 > +				_machine = data[0];
 > +			}
 >  			break;
 >  #endif
 >  		case BI_MEMSIZE:
 > 
 > 
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
 > 
