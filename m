Return-Path: <subrata@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 29426B7122
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 16:52:14 +1000 (EST)
Subject: Re: [PATCH][Resend 2][BUILD FAILURE 04/04] Next June 04:PPC64
	randconfig [drivers/net/ucc_geth.o]
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: Tony Breeds <tony@bakeyournoodle.com>, netdev@vger.kernel.org,
	michael@ellerman.id.au, Li Yang <leoli@freescale.com>,
	Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20090611033705.20842.75501.sendpatchset@subratamodak.linux.ibm.com>
References: <20090611033705.20842.75501.sendpatchset@subratamodak.linux.ibm.com>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 12:21:58 +0530
Message-Id: <1245048719.5239.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Li/Nathan,

On Thu, 2009-06-11 at 09:07 +0530, Subrata Modak wrote: 
> Hi Nathan,
> 
> >On Wed, 2009-06-10 at 21:28 -0500, Nathan Lynch wrote:
> >Subrata Modak <subrata@linux.vnet.ibm.com> writes:
> > 
> > > On Thu, 2009-06-11 at 11:05 +1000, Stephen Rothwell wrote:
> > >> Hi Subrata,
> > >> 
> > >> On Wed, 10 Jun 2009 23:13:23 +0530 Subrata Modak <subrata@linux.vnet.ibm.com> wrote:
> > >> >
> > >> >  	/* Find the TBI PHY.  If it's not there, we don't support SGMII */
> > >> > -	ph = of_get_property(np, "tbi-handle", NULL);
> > >> > +	ph = (phandle *)of_get_property(np, "tbi-handle", NULL);
> > >> 
> > >> You don't need this cast because of_get_property() returns "void *".
> > >
> > > Stephen,
> > >
> > > True. But without this gcc complains:
> > >
> > > CC [M]  drivers/net/ucc_geth.o
> > > drivers/net/ucc_geth.c: In function bucc_geth_probeb:
> > > drivers/net/ucc_geth.c:3824: warning: assignment discards qualifiers
> > > from pointer target type
> > 
> > ph should be declared const phandle *.  Look at other uses of
> > of_get_property.
> >
> 
> Ok fine. Here is a revised patch again.
> 
> Subject: [PATCH][Resend 2][BUILD FAILURE 04/04] Next June 04:PPC64 randconfig [drivers/net/ucc_geth.o]
> Reference(s):
> http://lkml.org/lkml/2009/6/4/241,
> http://lkml.org/lkml/2009/6/10/338,
> 
> Fix the following build error:
> 
> drivers/net/ucc_geth.c: In function bucc_geth_probeb:
> drivers/net/ucc_geth.c:3822: error: 'ph' undeclared (first use in this function)
> drivers/net/ucc_geth.c:3822: error: (Each undeclared identifier is reported only once
> drivers/net/ucc_geth.c:3822: error: for each function it appears in.)
> drivers/net/ucc_geth.c:3832: error: 'mdio' undeclared (first use in this function)
> make[2]: *** [drivers/net/ucc_geth.o] Error 1
> 
> Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
> ---

Is there anything else to be done in this patch. If this is OK, can this
be applied. I am not sure, but, i find Li Yang as the maintainer for
this in linux*/MAINTAINERS file. Kindly let me know if this patch needs
to be revisited for some other issue(s).

Regards--
Subrata

> 
> --- linux-2.6.30-rc8/drivers/net/ucc_geth.c.orig	2009-06-10 11:58:39.000000000 -0500
> +++ linux-2.6.30-rc8/drivers/net/ucc_geth.c	2009-06-10 22:28:13.000000000 -0500
> @@ -3595,6 +3595,8 @@ static const struct net_device_ops ucc_g
> 
>  static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *match)
>  {
> +	struct device_node *mdio;
> +	const phandle *ph;
>  	struct device *device = &ofdev->dev;
>  	struct device_node *np = ofdev->node;
>  	struct net_device *dev = NULL;
> 
> ---
> Regards--
> Subrata
> 
