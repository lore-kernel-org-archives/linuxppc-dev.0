Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H1bl1Z8mzF1Pn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 13:00:18 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id a14-v6so3328569pgw.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 20:00:18 -0700 (PDT)
Date: Fri, 29 Jun 2018 13:00:07 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Alex Williamson
 <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org, David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v2 0/2] KVM: PPC: Check if IOMMU page is
 contained in the pinned physical page
Message-ID: <20180629130007.1b78e168@aik.ozlabs.ibm.com>
In-Reply-To: <877emiwe3n.fsf@concordia.ellerman.id.au>
References: <20180626055926.27703-1-aik@ozlabs.ru>
 <877emiwe3n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 29 Jun 2018 11:55:40 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
> > This is to improve page boundaries checking and should probably
> > be cc:stable. I came accross this while debugging nvlink2 passthrough
> > but the lack of checking might be exploited by the existing userspace.  
> 
> Do you really mean "exploited" ? As in there's a security issue?
> 
> Your change log for patch 2 sort of suggests that but then says that
> without the fix you just hit an error in vfio code.


The bug is that I can easily make unmodified guest use 16MB IOMMU pages
while guest RAM is backed with system 64K pages so unless the guest RAM
is allocated contigously (which is unlikely), a 16MB TCE will provide
the hardware access to the host physical memory it is not supposed to
have access to, which is 16MB minus first 64K.

There is a fast path for H_PUT_TCE - via KVM - there is no contained
test.

There is a slow path for H_PUT_TCE - via VFIO ioctl() - there is a
contained test.

Because of a different feature of VFIO on sPAPR (it stores an array of
userspace addresses which we received from QEMU and translated to host
physical addresses and programmed those to the TCE table) we do not take
the fast path on the very first H_PUT_TCE (because I allocate the
array when the slow path is taken the very first time), fail there,
pass the failure to the guest the guest decides that is over.

But a modified guest could ignore that initial H_PUT_TCE failure and
simply repeat H_PUT_TCE again - this time it will take the fast path
and allow the bad mapping.


> So I'm not clear on what the exposure is.
> 
> cheers



--
Alexey
