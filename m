Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2BBF1DE089
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 23:25:51 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0CCPfdi100882
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 12:25:41 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id l0CCPeQ72748558
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 13:25:40 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0CCPdu6030573
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 13:25:40 +0100
In-Reply-To: <adaslehibjh.fsf@cisco.com>
Subject: Re: [PATCH/RFC 2.6.21 2/5] ehca: ehca_uverbs.c: "proper" use of mmap
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OFF6353D7D.25679E15-ONC1257261.00429991-C1257261.0044415A@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 12 Jan 2007 13:25:31 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Roland Dreier wrote on 11.01.2007 20:54:58:

>  > >  int ehca_mmap(struct ib_ucontext *context, struct vm_area_struct
*vma)
>  > >  {
>  >
>  > Can you split this monster routine into individual functions for
>  > each type of mmap please?  With two helpers to get and verify the
cq/qp
>  > shared by the individual sub-variants, that would also help to get rid
>  > of all those magic offsets.
>  >
>  > Actually, this routine directly comes from ib_device.mmap - Roland,
>  > can you shed some light on what's going on here?
>
> Each userspace-accessible IB device gets a single device node like
> /dev/infiniband/uverbsX.  Opening that gives userspace a "context".
> One of the things userspace can do with that fd is mmap() on it --
> that was originally envisioned as a way to map a page of hardware
> registers directly in to the userspace process.
>
> It seems ehca needs to allocate lots of different things in the kernel
> via mmap().  What you're saying I guess is that ideally each of these
> would be mmap() on a different fd rather than using different
> offsets.  It's a little awkward to open multiple device nodes to get
> multiple fds, since there's not a good way to attach them all to the
> same context.  I guess we could create some hack to return more file
> handles, but I think that cure is worse than the disease of using
> magic offsets...
>
> Maybe longer term we need to look at a scheme like cell's spufs but
> I'm still not confident we have the RDMA interface quite ready to
> freeze at the system call level.
>
>  - R.

...as Roland mentions, we're not completely free to change the filehandle
usage,
it's shared by ~5 drivers now.

I'd say lets investigate the direction of an own filesystem unless
there's no other clean solution.
We can polish the current version a bit, but that won't change the "magic
offsets".

Roland, could you take this patchset into your tree?
We hope it adresses the major security concern and vm_insert_page.

We're preparing the next patch for the yield deadlock topic with this
patchset as prereq.

Gruss / Regards . . . Christoph Raisch
