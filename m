Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
In-Reply-To: <17193.22140.962651.122114@cargo.ozlabs.ibm.com>
References: <1126644202.11056.59.camel@cashmere.sps.mot.com>
	<200509140435.21916.arnd@arndb.de>
	<1126705588.14036.10.camel@cashmere.sps.mot.com>
	<17193.22140.962651.122114@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1126804069.17442.32.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 15 Sep 2005 12:07:51 -0500
Subject: Re: PATCH powerpc: Merge asm-ppc*/sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-09-15 at 06:09, Paul Mackerras wrote:
> Jon Loeliger writes:
> 
> > In the Grand Scheme of Things, removing things and making them
> > simpler seems a lofty goal. :-)   Anyone know of any pitfalls that
> > await me if I try to remove these sections, a la pmac and friends?
> 
> You'll probably get most objection from the PReP users, for whom
> getting back a few hundred kB is a big deal.  (Maybe we should just
> buy both of them a G5 or something. 8-)

OK.  I dug up some data.

Compiled ppc32 *_defconfig across the page.
Section down the left.  All numbers are 4K pages.
OF is the so-called "__openfirmware" section.


	pmac	ibmchrp	stx_gp3	mpc8555_cds
     	--------------------------------------
pmac	10	7	0	0
prep	2	2	0	0
chrp	1	1	0	0
OF	2	1	0	0
init	47	46	23	32

Over in arch/ppc/mm/init.c this gets done:

        printk ("Freeing unused kernel memory:");
        FREESEC(init);
        if (_machine != _MACH_Pmac)
                FREESEC(pmac);
        if (_machine != _MACH_chrp)
                FREESEC(chrp);
        if (_machine != _MACH_prep)
                FREESEC(prep);
        if (!have_of)
                FREESEC(openfirmware);

Toss sections that don't match your _machine.
Everyone tosses init section.
Embedded boards will take no hit.
Ppc64 currently does not have these special sections
    and hence will see no impact here.

That is the cost of removing these section identifiers.

So, is everyone prepared to live with these few pages
of occasional increased image size and remove the
special sections?

Thanks,
jdl
