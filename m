Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4124L94YydzF33s
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 11:18:41 +1000 (AEST)
Date: Thu, 7 Jun 2018 19:18:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, Ram
 Pai <linuxram@us.ibm.com>, kvm@vger.kernel.org, Alistair Popple
 <alistair@popple.id.au>
Subject: Re: [RFC PATCH kernel 0/5] powerpc/P9/vfio: Pass through NVIDIA
 Tesla V100
Message-ID: <20180607191838.2d456467@w520.home>
In-Reply-To: <f6fbd7996a2edfc0bdb8363cb6384caeae7d47b9.camel@kernel.crashing.org>
References: <20180607084420.29513-1-aik@ozlabs.ru>
 <20180607110409.5057ebac@w520.home>
 <e35a7bbea8b82c17f93eb6eb438df38a94097f2d.camel@kernel.crashing.org>
 <20180607161541.21df6434@w520.home>
 <33590885d138195c8ede78b588ddb03b132267fd.camel@kernel.crashing.org>
 <20180607183417.3ff2acf1@w520.home>
 <f6fbd7996a2edfc0bdb8363cb6384caeae7d47b9.camel@kernel.crashing.org>
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

On Fri, 08 Jun 2018 10:58:54 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2018-06-07 at 18:34 -0600, Alex Williamson wrote:
> > > We *can* allow individual GPUs to be passed through, either if somebody
> > > designs a system without cross links, or if the user is ok with the
> > > security risk as the guest driver will not enable them if it doesn't
> > > "find" both sides of them.  
> > 
> > If GPUs are not isolated and we cannot prevent them from probing each
> > other via these links, then I think we have an obligation to configure
> > grouping in a way that doesn't rely on a benevolent userspace.  Thanks,  
> 
> Well, it's a user decision, no ? Like how we used to let the user
> decide whether to pass-through things that have LSIs shared out of
> their domain.

No, users don't get to pinky swear they'll be good.  The kernel creates
IOMMU groups assuming the worst case isolation and malicious users.
Its the kernel's job to protect itself from users and to protect users
from each other.  Anything else is unsupportable.  The only way to
bypass the default grouping is to modify the kernel.  Thanks,

Alex
