Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTsly3QfVzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 23:42:22 +1100 (AEDT)
Message-ID: <1458650516.3107.145.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel 08/10] powerpc/powernv/npu: Add NPU devices to
 IOMMU group
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson
 <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 22 Mar 2016 23:41:56 +1100
In-Reply-To: <56F0A46B.3040400@ozlabs.ru>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-9-git-send-email-aik@ozlabs.ru>
 <20160321044810.GG23586@voom.redhat.com> <56EFAFF3.5090404@ozlabs.ru>
 <20160322002550.GR23586@voom.redhat.com> <56F0A46B.3040400@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-22 at 12:48 +1100, Alexey Kardashevskiy wrote:
> 
> I suppose GPU from guest1 could trigger DMA from NPU to guest2 memory. 
> Which puts a constrain to management tools not to pass NPU without their 
> GPU counterparts.

Management tools will not be taught such constraints. The plan always
was to make sure they are in the same group. So they should be.

> The host can be affected as bypass is not disabled on NPU when GPU is taken 
> by VFIO, I'll fix this.
>
> >> If I put them to the same group as GPUs, I would have to have
> >> IODA2-linked-to-NPU bridge type with different iommu_table_group_ops  or
> >> have multiple hacks everywhere in IODA2 to enable/disable bypass,
> >> etc.
> >
> > Well.. I suspect it would mean no longer having a 1:1 correspondance
> > between user-visible IOMMU groups and the internal iommu_table.
> 
> Right.

They can share the table too ...

> Right now each GPU is sitting on a separate PHB and has its own PE. And all 
> NPUs sit on a separate PHB and each couple of NPUs (2 links of the same 
> GPU) gets a PE.
> 
> So we have separate PEs (struct pnv_ioda_pe) already, each has its own 
> iommu_table_group_ops with all these VFIO IOMMU callbacks. So to make this 
> all appear as one IOMMU group in sysfs, I will need to stop embedding 
> iommu_table_group into pnv_ioda_pe but make it a pointer with reference 
> counting, etc. Quite a massive change...

Or you just put a quirk flag of some sort and a pointer to the "linked"
PE... sometimes that's a lot easier than lifting up the whole
infrastructure.
> 
> 
> 
> >>>> ---
> >>>>   arch/powerpc/platf
