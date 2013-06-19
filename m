Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DC81D2C013D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 14:59:47 +1000 (EST)
Message-ID: <1371617970.21896.232.camel@pasglop>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 19 Jun 2013 14:59:30 +1000
In-Reply-To: <87txkun568.fsf@rustcorp.com.au>
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-4-git-send-email-aik@ozlabs.ru>
 <1371422343.21896.143.camel@pasglop>
 <1371438800.22681.38.camel@ul30vt.home>
 <1371441361.21896.152.camel@pasglop>
 <1371522772.22681.140.camel@ul30vt.home> <87txkun568.fsf@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Rusty Russell <rusty@rustcorp.com.au>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-19 at 13:05 +0930, Rusty Russell wrote:
> symbol_get() won't try to load a module; it'll just fail.  This is what
> you want, since they must have vfio in the kernel to get a valid fd...

Ok, cool. I suppose what we want here Alexey is slightly higher level,
something like:

	vfio_validate_iommu_id(file, iommu_id)

Which verifies that the file that was passed in is allowed to use
that iommu_id.

That's a simple and flexible interface (ie, it will work even if we
support multiple iommu IDs in the future for a vfio, for example
for DDW windows etc...), the logic to know about the ID remains
in qemu, this is strictly a validation call.

That way we also don't have to expose the containing vfio struct etc...
just that simple function.

Alex, any objection ?

Do we need to make it a get/put interface instead ?

	vfio_validate_and_use_iommu(file, iommu_id);

	vfio_release_iommu(file, iommu_id);

To ensure that the resource remains owned by the process until KVM
is closed as well ?

Or do we want to register with VFIO with a callback so that VFIO can
call us if it needs us to give it up ?

Cheers,
Ben.
