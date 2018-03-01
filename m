Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsXyG59W3zF1gb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 00:16:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH v2] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
In-Reply-To: <7309481.ksyhQnkyZL@new-mexico>
References: <20180228003814.32124-1-alistair@popple.id.au>
 <877eqx4e07.fsf@concordia.ellerman.id.au> <7309481.ksyhQnkyZL@new-mexico>
Date: Fri, 02 Mar 2018 00:16:37 +1100
Message-ID: <877eqw7x6y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alistair Popple <alistair@popple.id.au> writes:

>> > diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
>> > index 0a253b64ac5f..2fed4b116e19 100644
>> > --- a/arch/powerpc/platforms/powernv/npu-dma.c
>> > +++ b/arch/powerpc/platforms/powernv/npu-dma.c
>> > @@ -726,7 +749,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>> >  	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
>> >  							&nvlink_index)))
>> >  		return ERR_PTR(-ENODEV);
>> > -	npu_context->npdev[npu->index][nvlink_index] = npdev;
>> > +	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], npdev);
>>   
>> When you're publishing a struct via a pointer you would typically have a
>> barrier between the stores that set the fields of the struct, and the
>> store that publishes the struct. Otherwise the reader can see a
>> partially setup struct.
>
> npdev is just a pointer to a pci_dev setup by the PCI code. We assign it to
> npdev[][] to indicate to the mmu notifiers that an invalidation should also
> be sent to this nvlink. However I don't think there is any ordering
> required wrt to the rest of the npu_context setup - so long as when the
> notifiers deference npu_context->npdev[i][j] it either sees a valid
> non-NULL pointer or NULL assigned to npdev[][] everything should be ok.

Yeah OK. You do then dereference npdev->bus, so you depend on that being
setup prior to the store that makes the npdev visible. But I guess we're
saying that happened eons ago somewhere in the PCI code and will have
happened by now.

>> I think here the npdev was setup somewhere else, and maybe there has
>> been an intervening barrier, but it's not clear. A comment at least
>> would be good.
>
> Yes it has been. I will submit a v3 with some more comments incorporating
> the above. Unless you think my argument is wrong?

If you can comment it then I think I'm happy with it.

>> In general I feel like a spinlock or two could significantly simply the
>> locking/ordering in this code, and given we're doing MMIOs anyway would
>> not affect performance.
>
> Indeed, I am working on a patch to add a spinlock around the allocation of
> the npu_context as pnv_npu2_destroy_context() needs to be serialised with
> respect to pnv_npu2_init_context() on the same mm_struct. I'd incorrectly
> assumed the driver would do this serialisation but apparently it can't so
> we need to ensure kref_get(npu_context) can't race with it's destruction
> (concurrent init_context() is protected by mmap_sem). I could fold that
> (unposted) patch into this one if you think that would be better?

No this is big enough already, I almost asked you to split it to make
the diff more readable :)

So just send the spinlock patch when it's ready as a separate patch.

cheers
