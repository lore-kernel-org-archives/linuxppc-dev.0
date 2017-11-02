Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySDh41nB3zDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 16:50:10 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA25mliL051891
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Nov 2017 01:50:08 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dyq9234t6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Nov 2017 01:50:07 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Thu, 2 Nov 2017 05:50:06 -0000
Subject: Re: [PATCH v3] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
To: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <1508217523-18885-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 Torsten Duwe <duwe@lst.de>, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Thu, 2 Nov 2017 11:19:59 +0530
MIME-Version: 1.0
In-Reply-To: <20171031141959.7pqnlncg2236yqqg@naverao1-tp.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5fa0632e-7488-f28a-77f4-2598a0c2be84@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 31 October 2017 07:49 PM, Naveen N . Rao wrote:
> Hi Kamalesh,
> Sorry for the late review. Overall, the patch looks good to me. So:
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>
> However, I have a few minor comments which can be addressed in a
> subsequent patch.
>

Thanks for the review.

[...]

>> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
>> index 0b0f896..005aaea 100644
>> --- a/arch/powerpc/kernel/module_64.c
>> +++ b/arch/powerpc/kernel/module_64.c

[...]

>> @@ -239,10 +257,19 @@ static void relaswap(void *_x, void *_y, int size)
>>
>>  /* Get size of potential trampolines required. */
>>  static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
>> -				    const Elf64_Shdr *sechdrs)
>> +				    const Elf64_Shdr *sechdrs,
>> +				    struct module *me)
>>  {
>>  	/* One extra reloc so it's always 0-funcaddr terminated */
>>  	unsigned long relocs = 1;
>
> You might want to get rid of 'relocs' above and simply use the below
> two.
>
>> +	/*
>> +	 * size of livepatch stub is 28 instructions, whereas the
>> +	 * non-livepatch stub requires 7 instructions. Account for
>> +	 * different stub sizes and track the livepatch relocation
>> +	 * count in me->arch.klp_relocs.
>> +	 */
>> +	unsigned long sec_relocs = 0;
>> +	unsigned long klp_relocs = 0;
>
> You should also initialize this to 1 (similar to relocs above) for use
> in the iterators below. Or, update the iterators to use
> me->arch.klp_relocs (1)

relocs is Sum(sec_relocs), whereas per section relocation count is 
assigned to sec_relocs.  If the section is livepatch section, then it
added to klp_relocs or else to relocs. sec_relocs acts like a temp 
variable to hold the current section relocation count.

>
>>  	unsigned i;
>>
>>  	/* Every relocated section... */
>> @@ -262,9 +289,14 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
>>  			     sechdrs[i].sh_size / sizeof(Elf64_Rela),
>>  			     sizeof(Elf64_Rela), relacmp, relaswap);
>>
>> -			relocs += count_relocs((void *)sechdrs[i].sh_addr,
>> +			sec_relocs = count_relocs((void *)sechdrs[i].sh_addr,
>>  					       sechdrs[i].sh_size
>>  					       / sizeof(Elf64_Rela));
>
> How about also capturing 'sec_relocs' in 'struct mod_arch_specific'? (2)
> That will help simplify a lot of the calculations here and elsewhere.
> Note that there are many other places where the number of stubs is
> derived looking at 'sh_size', which is incorrect since we now have klp
> stubs as well (create_ftrace_stub() for instance).
>
>> +			relocs += sec_relocs;
>> +#ifdef CONFIG_LIVEPATCH
>> +			if (sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH)
>> +				klp_relocs += sec_relocs;
>> +#endif
>
> If a module has SHF_RELA_LIVEPATCH, but the kernel is compiled without
> CONFIG_LIVEPATCH, should we refuse to load the kernel module?

Yes, the module load will fail.

>
> You might want to consider removing the above #ifdef and processing some
> of these flags regardless of CONFIG_LIVEPATCH.

ifdef guard, can be replaced with check for SHF_RELA_LIVEPATCH in 
section flag.

>
>>  		}
>>  	}
>>
>> @@ -273,6 +305,15 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
>>  	relocs++;
>>  #endif
>>
>> +	relocs -= klp_relocs;
>> +#ifdef CONFIG_LIVEPATCH
>> +	me->arch.klp_relocs = klp_relocs;
>> +
>> +	pr_debug("Looks like a total of %lu stubs, (%lu) livepatch stubs, max\n",
> 						   ^^^^^
> 						   (%lu livepatch stubs)
>
> Just wondering why the brackets are the way they are...

Makes it better to use the brackets like you suggested.


>
>> +				relocs, klp_relocs);
>> +	return (relocs * sizeof(struct ppc64_stub_entry) +
>> +		klp_relocs * sizeof(struct ppc64le_klp_stub_entry));
>> +#endif
>>  	pr_debug("Looks like a total of %lu stubs, max\n", relocs);
>>  	return relocs * sizeof(struct ppc64_stub_entry);
>>  }

[...]

>>
>> +#ifdef CONFIG_LIVEPATCH
>> +static unsigned long klp_stub_for_addr(const Elf64_Shdr *sechdrs,
>> +				       unsigned long addr,
>> +				       struct module *me)
>> +{
>> +	struct ppc64le_klp_stub_entry *klp_stubs;
>> +	unsigned int num_klp_stubs = me->arch.klp_relocs;
>> +	unsigned int i, num_stubs;
>> +
>> +	num_stubs = (sechdrs[me->arch.stubs_section].sh_size -
>> +		    (num_klp_stubs * sizeof(*klp_stubs))) /
>> +				sizeof(struct ppc64_stub_entry);
>
> (2) This can be simplified if we have me->arch.sec_relocs.

Having it will make the calculation look simple:
num_stubs = (me->arch.sec_relocs * size(struct ppc64_stub_entry).


>
>> +
>> +	/*
>> +	 * Create livepatch stubs after the regular stubs.
>> +	 */
>> +	klp_stubs = (void *)sechdrs[me->arch.stubs_section].sh_addr +
>> +		    (num_stubs * sizeof(struct ppc64_stub_entry));
>> +	for (i = 0; stub_func_addr(klp_stubs[i].funcdata); i++) {
> 		    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 		    (1) This needs us to allocate one additional stub.
>
>

Good catch, yes there should an extra stub.

-- 
cheers,
Kamalesh.
