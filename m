Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4AF51A028D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 21:00:43 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Wed, 13 Jan 2016 20:00:42 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BFB233578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 21:00:39 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0DA0Vd253739562
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 21:00:39 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0DA06gR006488
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 21:00:07 +1100
Message-ID: <56962014.5040702@linux.vnet.ibm.com>
Date: Wed, 13 Jan 2016 15:29:48 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: =?UTF-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?=
 <masami.hiramatsu.pt@hitachi.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "mjw@redhat.com" <mjw@redhat.com>,
 "sukadev@linux.vnet.ibm.com" <sukadev@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>,
 "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v2] perf/probe: Search both .eh_frame and .debug_frame
 sections for probe location
References: <1451900918-6710-1-git-send-email-hemant@linux.vnet.ibm.com>
 <50399556C9727B4D88A595C8584AAB37526926A9@GSjpTKYDCembx32.service.hitachi.net>
In-Reply-To: <50399556C9727B4D88A595C8584AAB37526926A9@GSjpTKYDCembx32.service.hitachi.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/12/2016 04:34 PM, 平松雅巳 / HIRAMATU，MASAMI wrote:
> Hi Hemant,
>
>> From: Hemant Kumar [mailto:hemant@linux.vnet.ibm.com]
>>
>> perf probe through debuginfo__find_probes() in util/probe-finder.c
>> checks for the functions' frame descriptions in either .eh_frame section
>> of an ELF or the .debug_frame. The check is based on whether either one
>> of these sections is present. Depending on distro, toolchain defaults,
>> architetcutre, build flags, etc., CFI might be found in either .eh_frame
>> and/or .debug_frame. Sometimes, it may happen that, .eh_frame, even if
>> present, may not be complete and may miss some descriptions. Therefore,
>> to be sure, to find the CFI covering an address we will always have to
>> investigate both if available.
> OK, so we'd better check both cfi's.
>   [...]
>> +/* Find probe points from debuginfo */
>> +static int debuginfo__find_probes(struct debuginfo *dbg,
>> +				  struct probe_finder *pf)
>> +{
>> +	int ret = 0;
>> +
>> +#if _ELFUTILS_PREREQ(0, 142)
>> +	Elf *elf;
>> +	GElf_Ehdr ehdr;
>> +	GElf_Shdr shdr;
>> +
>> +	if (pf->cfi_eh || pf->cfi_dbg)
>> +		return debuginfo__find_probe_location(dbg, pf);
>> +
>> +	/* Get the call frame information from this dwarf */
>> +	elf = dwarf_getelf(dbg->dbg);
>> +	if (elf == NULL)
>> +		return -EINVAL;
>> +
>> +	if (gelf_getehdr(elf, &ehdr) == NULL)
>> +		return -EINVAL;
>> +
>> +	if (elf_section_by_name(elf, &ehdr, &shdr, ".eh_frame", NULL) &&
>> +	    shdr.sh_type == SHT_PROGBITS) {
>> +		pf->cfi_eh = dwarf_getcfi_elf(elf);
>> +	} else {
>> +		pf->cfi_dbg = dwarf_getcfi(dbg->dbg);
>> +	}
> Hmm, if you want to check both of those cfi's, don't we have to do below?
>
> 	if (elf_section_by_name(elf, &ehdr, &shdr, ".eh_frame", NULL) &&
> 	    shdr.sh_type == SHT_PROGBITS)
> 		pf->cfi_eh = dwarf_getcfi_elf(elf);
>
> 	pf->cfi_dbg = dwarf_getcfi(dbg->dbg);
>
> Then, both of pf->cfi_* will be filled (if the elf has ".eh_frame").
>
> Thanks!

Ah, right. Fixed in v3.

>
>

-- 
Thanks,
Hemant Kumar
