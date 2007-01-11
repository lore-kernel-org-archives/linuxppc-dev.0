Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 2C05ADDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:55:00 +1100 (EST)
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH/RFC 2.6.21 2/5] ehca: ehca_uverbs.c: "proper" use of mmap
References: <200701112008.15841.hnguyen@linux.vnet.ibm.com>
	<20070111194000.GE24623@infradead.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 11 Jan 2007 11:54:58 -0800
In-Reply-To: <20070111194000.GE24623@infradead.org> (Christoph Hellwig's
	message of "Thu, 11 Jan 2007 19:40:00 +0000")
Message-ID: <adaslehibjh.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > >  int ehca_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 > >  {
 > 
 > Can you split this monster routine into individual functions for
 > each type of mmap please?  With two helpers to get and verify the cq/qp
 > shared by the individual sub-variants, that would also help to get rid
 > of all those magic offsets.
 > 
 > Actually, this routine directly comes from ib_device.mmap - Roland,
 > can you shed some light on what's going on here?

Each userspace-accessible IB device gets a single device node like
/dev/infiniband/uverbsX.  Opening that gives userspace a "context".
One of the things userspace can do with that fd is mmap() on it --
that was originally envisioned as a way to map a page of hardware
registers directly in to the userspace process.

It seems ehca needs to allocate lots of different things in the kernel
via mmap().  What you're saying I guess is that ideally each of these
would be mmap() on a different fd rather than using different
offsets.  It's a little awkward to open multiple device nodes to get
multiple fds, since there's not a good way to attach them all to the
same context.  I guess we could create some hack to return more file
handles, but I think that cure is worse than the disease of using
magic offsets...

Maybe longer term we need to look at a scheme like cell's spufs but
I'm still not confident we have the RDMA interface quite ready to
freeze at the system call level.

 - R.
