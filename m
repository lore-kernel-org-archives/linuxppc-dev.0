Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C5625140E3B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 01:16:28 +1000 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: Don't try to allocate from kernel
 page allocator for hash page table.
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <87r4489ttk.fsf@linux.vnet.ibm.com>
Date: Mon, 5 May 2014 17:16:05 +0200
Message-Id: <20FFDF8F-1A3D-4719-B492-1E4B70F9D1B4@suse.de>
References: <1399224322-22028-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <53677558.50900@suse.de> <87r4489ttk.fsf@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 05.05.2014 um 16:35 schrieb "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet=
.ibm.com>:
>=20
> Alexander Graf <agraf@suse.de> writes:
>=20
>>> On 05/04/2014 07:25 PM, Aneesh Kumar K.V wrote:
>>> We reserve 5% of total ram for CMA allocation and not using that can
>>> result in us running out of numa node memory with specific
>>> configuration. One caveat is we may not have node local hpt with pinned
>>> vcpu configuration. But currently libvirt also pins the vcpu to cpuset
>>> after creating hash page table.
>>=20
>> I don't understand the problem. Can you please elaborate?
>=20
> Lets take a system with 100GB RAM. We reserve around 5GB for htab
> allocation. Now if we use rest of available memory for hugetlbfs
> (because we want all the guest to be backed by huge pages), we would
> end up in a situation where we have a few GB of free RAM and 5GB of CMA
> reserve area. Now if we allow hash page table allocation to consume the
> free space, we would end up hitting page allocation failure for other
> non movable kernel allocation even though we still have 5GB CMA reserve
> space free.

Isn't this a greater problem? We should start swapping before we hit the poi=
nt where non movable kernel allocation fails, no?

The fact that KVM uses a good number of normal kernel pages is maybe subopti=
mal, but shouldn't be a critical problem.


Alex

>=20
> -aneesh
>=20
