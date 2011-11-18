Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6B88EB7253
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2011 00:57:16 +1100 (EST)
Subject: Re: [RFC PATCH 0/11] KVM: PPC: Update Book3S HV memory handling
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
Date: Fri, 18 Nov 2011 14:57:11 +0100
Message-Id: <AA9CC080-B96B-41C7-A054-8286CF8BC3FE@suse.de>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Avi Kivity <avi@redhat.com>, kvm-ppc@vger.kernel.org,
 kvm list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 16.11.2011, at 23:50, Paul Mackerras wrote:

> This series of patches updates the Book3S-HV KVM code that manages the
> guest hashed page table (HPT) to enable several things:
>=20
> * MMIO emulation and MMIO pass-through
>=20
> * Use of small pages (4kB or 64kB, depending on config) to back the
>  guest memory
>=20
> * Pageable guest memory - i.e. backing pages can be removed from the
>  guest and reinstated on demand, using the MMU notifier mechanism.
>=20
> On PPC970 we have no way to get DSIs and ISIs to come to the
> hypervisor, so we can't do MMIO emulation or pageable guest memory.
> On POWER7 we set the VPM1 bit in the LPCR to make all DSIs and ISIs
> come to the hypervisor (host) as HDSIs or HISIs.
>=20
> This series is RFC for the moment, although the first 5 or so patches
> are pretty solid and could go in.  I am going to rework the later
> patches to use HPTEs with V=3D0 for the absent pages rather than =
key=3D31,
> which will require handling the HPTE-not-present HDSIs we will get and
> differentiating the case where the guest has created a HPTE but the
> underlying page is not resident from the case where the guest has
> created no HPTE for the address.

This touches areas that I'm sure non-PPC people would want to see as =
well. Could you please CC kvm@vger too next time?

Avi, Marcelo, mind to review some of the bits in this patch set? :)


Alex
