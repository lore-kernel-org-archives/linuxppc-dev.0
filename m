Return-Path: <nacc@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 904CAB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 06:00:25 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB9Ibsul027229
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Dec 2010 13:38:08 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 77B2672805B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 14:00:21 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oB9J0Lp1338758
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Dec 2010 14:00:21 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oB9J0K2a026059
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Dec 2010 14:00:21 -0500
Date: Thu, 9 Dec 2010 11:00:17 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 7/7 v2] ppc: add dynamic dma window support
Message-ID: <20101209190017.GA25003@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
	<1288150518-4026-8-git-send-email-nacc@us.ibm.com>
	<1291868226.16694.220.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291868226.16694.220.camel@pasglop>
Cc: sonnyrao@us.ibm.com, miltonm@bga.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09.12.2010 [15:17:06 +1100], Benjamin Herrenschmidt wrote:
> On Tue, 2010-10-26 at 20:35 -0700, Nishanth Aravamudan wrote:
> 
> No much comments... I'm amazed how complex he firmware folks managed to
> make this ... 
> 
> >  static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *node)
> >  {
> >  	int err = NOTIFY_OK;
> >  	struct device_node *np = node;
> >  	struct pci_dn *pci = PCI_DN(np);
> > +	struct direct_window *window;
> >  
> >  	switch (action) {
> >  	case PSERIES_RECONFIG_REMOVE:
> >  		if (pci && pci->iommu_table)
> >  			iommu_free_table(pci->iommu_table, np->full_name);
> > +
> > +		spin_lock(&direct_window_list_lock);
> > +		list_for_each_entry(window, &direct_window_list, list) {
> > +			if (window->device == np) {
> > +				list_del(&window->list);
> > +				break;
> > +			}
> > +		}
> > +		spin_unlock(&direct_window_list_lock);
> 
> Should you also kfree the window ?

Yeah, looks like I should. I have a few other questions due to testing,
but I'll reply to my original e-mail with those.

Thanks for the review!
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
