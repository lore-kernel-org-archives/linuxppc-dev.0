Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id C053AB6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 23:31:05 +1000 (EST)
Date: Mon, 18 Jul 2011 08:31:01 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [v2 PATCH 1/1] powerpc/4xx: enable and fix pcie gen1/gen2 on
	the 460sx
Message-ID: <20110718133101.GB26701@crust.elkhashab.com>
References: <1310603611-8960-2-git-send-email-ayman@elkhashab.com>
	<1310748027-31956-1-git-send-email-aymane@elkhashab.com>
	<20110718040115.GK20597@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110718040115.GK20597@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 18, 2011 at 02:01:15PM +1000, Tony Breeds wrote:
> On Fri, Jul 15, 2011 at 11:40:27AM -0500, Ayman Elkhashab wrote:
> 
> > @@ -1582,8 +1628,8 @@ static int __init ppc4xx_setup_one_pciex_POM(struct ppc4xx_pciex_port	*port,
> >  		dcr_write(port->dcrs, DCRO_PEGPL_OMR2BAH, lah);
> >  		dcr_write(port->dcrs, DCRO_PEGPL_OMR2BAL, lal);
> >  		dcr_write(port->dcrs, DCRO_PEGPL_OMR2MSKH, 0x7fffffff);
> > -		/* Note that 3 here means enabled | single region */
> > -		dcr_write(port->dcrs, DCRO_PEGPL_OMR2MSKL, sa | 3);
> > +		dcr_write(port->dcrs, DCRO_PEGPL_OMR2MSKL,
> > +				sa | DCRO_PEGPL_OMRxMSKL_VAL);
> 
> Didn't you just change "sa | 3" to "sa | 1" ?
> 

Yes, but I think that is correct for it to be "1".  The data
sheets for these parts that I checked had bit 1 marked as
reserved.  Only OMR1MSKL and OMR3MSKL had extra definitions
such as the _IO and _UOT.  The parts I checked which were
the sheets for the EX and SX (which cover another 6 or 7
parts) all had it with just a single bit defined on that
register.

Ayman
