Return-Path: <nacc@us.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13C211007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 11:30:38 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB40D8Jd023353
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 19:13:08 -0500
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1BCC7728045
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 19:30:32 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oB40UWGW402826
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 19:30:32 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oB40UVsU002415
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 22:30:32 -0200
Date: Fri, 3 Dec 2010 16:30:28 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 3/7 v2] ppc: do not search for dma-window property
	on dlpar remove
Message-ID: <20101204003028.GB3069@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
	<1288150518-4026-4-git-send-email-nacc@us.ibm.com>
	<1290994721.32570.219.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290994721.32570.219.camel@pasglop>
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

On 29.11.2010 [12:38:41 +1100], Benjamin Herrenschmidt wrote:
> On Tue, 2010-10-26 at 20:35 -0700, Nishanth Aravamudan wrote:
> > The iommu_table pointer in the pci auxiliary struct of device_node has
> > not been used by the iommu ops since the dma refactor of
> > 12d04eef927bf61328af2c7cbe756c96f98ac3bf, however this code still uses
> > it to find tables for dlpar. By only setting the PCI_DN iommu_table
> > pointer on nodes with dma window properties, we will be able to quickly
> > find the node for later checks, and can remove the table without looking
> > for the the dma window property on dlpar remove.
> 
> The answer might well be yes but are we sure this works with busses &
> devices that don't have a dma,window ? ie. we always properly look for
> parents when assigning pci devices arch_data iommu table ? Did you test
> it ? :-) (Best way is to find a card with a P2P bridge on it).

So I spent quite a while looking for some device or bus that didn't have
"ibm,dma-window" and the boxes I have access to didn't contain any :/

I did test dlpar remove now on p6 and it worked fine.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
