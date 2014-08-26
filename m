Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 531141A0716
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 07:48:48 +1000 (EST)
Message-ID: <1409089692.6510.86.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] fsl_ifc: Support all 8 IFC chip selects
From: Scott Wood <scottwood@freescale.com>
To: Aaron Sierra <asierra@xes-inc.com>
Date: Tue, 26 Aug 2014 16:48:12 -0500
In-Reply-To: <1923004045.447083.1409088847731.JavaMail.zimbra@xes-inc.com>
References: <1720585700.271372.1409074298919.JavaMail.zimbra@xes-inc.com>
 <1409086131.6510.80.camel@snotra.buserror.net>
 <1923004045.447083.1409088847731.JavaMail.zimbra@xes-inc.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-26 at 16:34 -0500, Aaron Sierra wrote:
> > > +static inline u32 fsl_ifc_version(struct fsl_ifc_regs *regs) {
> > > +	return ioread32be(&regs->ifc_rev) & FSL_IFC_VERSION_MASK;
> > > +}
> > > +
> > > +static inline int fsl_ifc_bank_count(struct fsl_ifc_regs *regs) {
> > > +	return (fsl_ifc_version(regs) == FSL_IFC_VERSION_1_0_0) ? 4 : 8;
> > > +}
> > 
> > Whitespace
> 
> Oops.
> 
> > Do we really need the bank count here, as opposed to just checking it in
> > probe()?  I also don't really care for reading the registers over and
> > over, even though it's not performance critical.
> 
> The bank count is used in fsl_ifc_nand.c and fsl_ifc.c, so I thought it
> was a good idea to have the version to bank count mapping defined in one
> place rather than two.

OK.

> > The reserved bits of the version register are defined as zero for
> > current versions -- I think just comparing ifc_rev to the version
> > constant, as is currently done, is fine.
> 
> I wasn't sure because the manuals I have only say that reserved values
> are zero at reset.

Well, we already have a version check that assumes they're zero, but if
you want to be especially safe I guess that's OK. :-)

-Scott
