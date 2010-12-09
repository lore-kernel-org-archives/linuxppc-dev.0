Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14714B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 15:17:18 +1100 (EST)
Subject: Re: [RFC PATCH 7/7 v2] ppc: add dynamic dma window support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <1288150518-4026-8-git-send-email-nacc@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
	<1288150518-4026-8-git-send-email-nacc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Dec 2010 15:17:06 +1100
Message-ID: <1291868226.16694.220.camel@pasglop>
Mime-Version: 1.0
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

On Tue, 2010-10-26 at 20:35 -0700, Nishanth Aravamudan wrote:

No much comments... I'm amazed how complex he firmware folks managed to
make this ... 

>  static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *node)
>  {
>  	int err = NOTIFY_OK;
>  	struct device_node *np = node;
>  	struct pci_dn *pci = PCI_DN(np);
> +	struct direct_window *window;
>  
>  	switch (action) {
>  	case PSERIES_RECONFIG_REMOVE:
>  		if (pci && pci->iommu_table)
>  			iommu_free_table(pci->iommu_table, np->full_name);
> +
> +		spin_lock(&direct_window_list_lock);
> +		list_for_each_entry(window, &direct_window_list, list) {
> +			if (window->device == np) {
> +				list_del(&window->list);
> +				break;
> +			}
> +		}
> +		spin_unlock(&direct_window_list_lock);

Should you also kfree the window ?


Cheers,
Ben.
