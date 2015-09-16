Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C6061A04B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 17:27:48 +1000 (AEST)
Message-ID: <1442388468.7205.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Recompute hash value after a failed update
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 Sep 2015 17:27:48 +1000
In-Reply-To: <87r3lyewil.fsf@linux.vnet.ibm.com>
References: <1442300408-26490-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87vbbbdp3g.fsf@linux.vnet.ibm.com>
 <1442378949.21531.1.camel@ellerman.id.au>
 <87r3lyewil.fsf@linux.vnet.ibm.com>
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

On Wed, 2015-09-16 at 11:27 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > On Wed, 2015-09-16 at 08:53 +0530, Aneesh Kumar K.V wrote:
> >> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> >> 
> >> > If we had secondary hash flag set, we ended up modifying hash value in
> >> > the updatepp code path. Hence with a failed updatepp we will be using
> >> > a wrong hash value for the following hash insert. Fix this by
> >> > recomputing hash before insert.
> >> 
> >> Without this patch we can end up with using wrong slot number in linux
> >> pte. That can result in us missing an hash pte update or invalidate
> >> which can cause memory corruption or even machine check ?
> >
> > Thanks. When did this break? Always? If so this should go to stable?
> >
> 
> IIUC we have this issue with initial support for THP (6d492ecc6489113968ec269be1cf88942d4a5d29)
> " powerpc/THP: Add code to handle HPTE faults for hugepages". So yes
> this should got to stable.

Thanks. And that went into 3.11.

You haven't actually seen any crashes that are definitely linked to this though
am I right? You just found it by code inspection?

cheers
