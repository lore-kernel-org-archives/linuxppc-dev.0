Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E23CDE16A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 06:24:05 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5NKQMcu000507
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 16:26:22 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5NKNqkY142816
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 16:23:52 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5NKNpbx007346
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 16:23:51 -0400
Date: Mon, 23 Jun 2008 15:23:49 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 12/19] powerpc: vio bus support for CMO
Message-ID: <20080623202348.GA12866@linux.vnet.ibm.com>
References: <20080612215312.GF30916@linux.vnet.ibm.com>
	<20080612221958.GT30916@linux.vnet.ibm.com>
	<20080613151221.47f02e6d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080613151221.47f02e6d.sfr@canb.auug.org.au>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Stephen Rothwell (sfr@canb.auug.org.au) wrote:
> Hi Robert,
> 
> Firstly, can all this new stuff be ifdef'ed out if not needed as the
> vio infrastructure is also used on legacy iSeries and this adds quite a
> bit of stuff that won't ever be used there.

I've changed the patch to ifdef out CMO for legacy iSeries.  This should
keep things cleaner.

> On Thu, 12 Jun 2008 17:19:59 -0500 Robert Jennings <rcj@linux.vnet.ibm.com> wrote:
> >
> > +static int vio_cmo_num_OF_devs(void)
> > +{
> > +	struct device_node *node_vroot;
> > +	int count = 0;
> > +
> > +	/*
> > +	 * Count the number of vdevice entries with an
> > +	 * ibm,my-dma-window OF property
> > +	 */
> > +	node_vroot = of_find_node_by_name(NULL, "vdevice");
> > +	if (node_vroot) {
> > +		struct device_node *of_node;
> > +		struct property *prop;
> > +
> > +		for (of_node = node_vroot->child; of_node != NULL;
> > +		                of_node = of_node->sibling) {
> 
> Use:
> 		for_each_child_of_node(node_vroot, of_node) {

Fixed.
