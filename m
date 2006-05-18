Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id D5DDF679F3
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 19:45:39 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k4I9teYZ013063
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 02:55:40 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k4I9jU5P007057
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 04:45:32 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673062C0A33@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 7/10]  Powerpc: workaround for tsi108 pci c
	onfi g read exception
Date: Thu, 18 May 2006 17:45:28 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> On Wed, 2006-05-17 at 18:14 +0800, Zang Roy-r61911 wrote:
> > Workaround for Tundra Semiconductor tsi108 host bridge pci 
> config read
> > exception
> 
> Use ppc_md.machine_check_exception instead of modifying the generic
> traps.c. Also make sure you can't configure your chip not to issue
> machine checks on target/master aborts on config space accesses....
> 
> Ben.

I will try ppc_md.machine_check_exception.  I am sure this machine check is 
needed. I can not pass the pci probe, if I comment off this code.
Roy.


> 
> > Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
> > Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>
> > 
> > ---
> > 
> >  arch/powerpc/kernel/traps.c |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> > 
> > 0575fbe21e4f1045528bb91ec4b34bb7955c4a92
> > diff --git a/arch/powerpc/kernel/traps.c 
> b/arch/powerpc/kernel/traps.c
> > index 064a525..7468d76 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -262,6 +262,19 @@ #if defined(CONFIG_PPC_PMAC) && defined(
> >  		}
> >  	}
> >  #endif /* CONFIG_PPC_PMAC && CONFIG_PPC32 */
> > +
> > +#ifdef CONFIG_TSI108_BRIDGE
> > +	extern void tsi108_clear_pci_cfg_error(void);
> > +	const struct exception_table_entry *entry;
> > +
> > +	/* Are we prepared to handle this fault?  */
> > +	if ((entry = search_exception_tables(regs->nip)) != NULL) {
> > +		tsi108_clear_pci_cfg_error();
> > +		regs->msr |= MSR_RI;
> > +		regs->nip = entry->fixup;
> > +		return 1;
> > +	}
> > +#endif /* CONFIG_TSI108_BRIDGE */
> >  	return 0;
> >  }
> >  
> 
