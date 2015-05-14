Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6E161A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 19:36:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 14 May 2015 19:36:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 582652CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 19:36:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4E9aDI231064314
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 19:36:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4E9ZnO4027343
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 19:35:49 +1000
Date: Thu, 14 May 2015 17:35:31 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 9/9] powerpc/eeh: handle VF PE properly
Message-ID: <20150514093531.GA12847@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-10-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150513011630.GA8973@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150513011630.GA8973@gwshan>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 13, 2015 at 11:16:30AM +1000, Gavin Shan wrote:
>On Mon, May 04, 2015 at 03:07:38PM +0800, Wei Yang wrote:
>
>	if (!edev->physfn) {
>		pr_warn("%s: EEH dev %04x:%02x:%02x:%01x not for VF\n",
>			edev->phb->global_number, pdn->busno,
>			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
>		return NULL;
>	}
>
>>+
>>+	driver = eeh_pcid_get(dev);
>>+	if (driver) {
>>+		eeh_pcid_put(dev);
>>+		if (driver->err_handler)
>>+			return NULL;
>>+	}
>
>dev and driver are NULL for those VFs that have been unplugged. For those
>VFs weren't unplugged, driver and err_handler should be valid. The code
>looks correct. However, for consistence, please use EEH_DEV_DISCONNECTED
>that has been marked to those EEH devices which were unplugged. Do you
>think it would be better?
>
>	if (!(dev->flags & EEH_DEV_DISCONNECTED))
>		return NULL;
>

Hi, Gavin,

I think this is a nice idea, while this may not work.

We mark the DISCONNECTED flag when remove a PCI device, while before we do the
hot plug we will detach it from the tree and remove this flag in
eeh_pe_detach_dev().

This will leads to the VF not be hot plugged.


-- 
Richard Yang
Help you, Help me
