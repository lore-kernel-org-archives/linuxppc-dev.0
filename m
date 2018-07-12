Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41R36L63WWzF35Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 14:36:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oscar Salvador <osalvador@techadventures.net>
Cc: akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
 sfr@canb.auug.org.au, linux-next@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhe@redhat.com, pasha.tatashin@oracle.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: Boot failures with "mm/sparse: Remove
 CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER" on powerpc (was Re: mmotm
 2018-07-10-16-50 uploaded)
In-Reply-To: <20180711133737.GA29573@techadventures.net>
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
 <87lgai9bt5.fsf@concordia.ellerman.id.au>
 <20180711133737.GA29573@techadventures.net>
Date: Thu, 12 Jul 2018 14:36:10 +1000
Message-ID: <87h8l58405.fsf@concordia.ellerman.id.au>
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

Oscar Salvador <osalvador@techadventures.net> writes:

> On Wed, Jul 11, 2018 at 10:49:58PM +1000, Michael Ellerman wrote:
>> akpm@linux-foundation.org writes:
>> > The mm-of-the-moment snapshot 2018-07-10-16-50 has been uploaded to
>> >
>> >    http://www.ozlabs.org/~akpm/mmotm/
>> ...
>> 
>> > * mm-sparse-add-a-static-variable-nr_present_sections.patch
>> > * mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
>> > * mm-sparsemem-defer-the-ms-section_mem_map-clearing-fix.patch
>> > * mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch
>> > * mm-sparse-optimize-memmap-allocation-during-sparse_init.patch
>> > * mm-sparse-optimize-memmap-allocation-during-sparse_init-checkpatch-fixes.patch
>> 
>> > * mm-sparse-remove-config_sparsemem_alloc_mem_map_together.patch
>> 
>> This seems to be breaking my powerpc pseries qemu boots.
>> 
>> The boot log with some extra debug shows eg:
>> 
>>   $ make pseries_le_defconfig
>
> Could you please share the config?
> I was not able to find such config in the kernel tree.

It's a generated config, see:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?commit=021c91791a5e7e85c567452f1be3e4c2c6cb6063#n315


It's based on pseries_defconfig, which is an actual file in the tree,
but with the endian flipped.

You can see the generated result from a recent build here:

  http://kisskb.ellerman.id.au/kisskb/buildresult/13428803/config/


cheers
