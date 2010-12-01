Return-Path: <nacc@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70F32B70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Dec 2010 11:31:16 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB10Iv9o021957
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Nov 2010 17:18:57 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oB10V3d3164522
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Nov 2010 17:31:03 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB10V2pl006158
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Nov 2010 17:31:02 -0700
Date: Tue, 30 Nov 2010 16:30:59 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 3/7 v2] ppc: do not search for dma-window property
	on dlpar remove
Message-ID: <20101201003059.GA3548@us.ibm.com>
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

I haven't tested this particular case. I'm getting a machine to do so
now, though.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
