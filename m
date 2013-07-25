Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 5ECCC2C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 02:08:00 +1000 (EST)
Subject: Re: [PATCH 2/2] kvm: powerpc: set cache coherency only for kernel
 managed pages
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20130725085042.GJ16400@redhat.com>
Date: Thu, 25 Jul 2013 18:07:55 +0200
Message-Id: <4DADA80E-9513-45D5-AFC0-1CEE2290F691@suse.de>
References: <03EEFDFE-4603-44FC-8449-2450607F2864@suse.de>
 <1374697969.15592.67@snotra> <20130725085042.GJ16400@redhat.com>
To: Gleb Natapov <gleb@redhat.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
 =?windows-1252?Q?=22=93tiejun=2Echen=94_Chen=22?= <tiejun.chen@windriver.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 Scott Wood <scottwood@freescale.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 25.07.2013, at 10:50, Gleb Natapov wrote:

> On Wed, Jul 24, 2013 at 03:32:49PM -0500, Scott Wood wrote:
>> On 07/24/2013 04:39:59 AM, Alexander Graf wrote:
>>>=20
>>> On 24.07.2013, at 11:35, Gleb Natapov wrote:
>>>=20
>>>> On Wed, Jul 24, 2013 at 11:21:11AM +0200, Alexander Graf wrote:
>>>>>> Are not we going to use page_is_ram() from
>>> e500_shadow_mas2_attrib() as Scott commented?
>>>>>=20
>>>>> rWhy aren't we using page_is_ram() in kvm_is_mmio_pfn()?
>>>>>=20
>>>>>=20
>>>> Because it is much slower and, IIRC, actually used to build pfn
>>> map that allow
>>>> us to check quickly for valid pfn.
>>>=20
>>> Then why should we use page_is_ram()? :)
>>>=20
>>> I really don't want the e500 code to diverge too much from what
>>> the rest of the kvm code is doing.
>>=20
>> I don't understand "actually used to build pfn map...".  What code
>> is this?  I don't see any calls to page_is_ram() in the KVM code, or
>> in generic mm code.  Is this a statement about what x86 does?
> It may be not page_is_ram() directly, but the same into page_is_ram() =
is
> using. On power both page_is_ram() and do_init_bootmem() walks some =
kind
> of memblock_region data structure. What important is that pfn_valid()
> does not mean that there is a memory behind page structure. See =
Andrea's
> reply.
>=20
>>=20
>> On PPC page_is_ram() is only called (AFAICT) for determining what
>> attributes to set on mmaps.  We want to be sure that KVM always
>> makes the same decision.  While pfn_valid() seems like it should be
>> equivalent, it's not obvious from the PPC code that it is.
>>=20
> Again pfn_valid() is not enough.
>=20
>> If pfn_valid() is better, why is that not used for mmap?  Why are
>> there two different names for the same thing?
>>=20
> They are not the same thing. page_is_ram() tells you if phys address =
is
> ram backed. pfn_valid() tells you if there is struct page behind the
> pfn. PageReserved() tells if you a pfn is marked as reserved. All non
> ram pfns should be reserved, but ram pfns can be reserved too. Again,
> see Andrea's reply.
>=20
> Why ppc uses page_is_ram() for mmap? How should I know? But looking at

That one's easy. Let's just ask Ben. Ben, is there any particular reason =
PPC uses page_is_ram() rather than what KVM does here to figure out =
whether a pfn is RAM or not? It would be really useful to be able to run =
the exact same logic that figures out whether we're cacheable or not in =
both TLB writers (KVM and linux-mm).


Alex

> the function it does it only as a fallback if
> ppc_md.phys_mem_access_prot() is not provided. Making access to MMIO
> noncached as a safe fallback makes sense. It is also make sense to =
allow
> noncached access to reserved ram sometimes.
>=20
> --
> 			Gleb.
