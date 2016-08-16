Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sD3354dNxzDr45
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 16:53:05 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id cf3so4791623pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 23:53:05 -0700 (PDT)
Subject: Re: [PATCH v5 04/13] powerpc: Factor out relocation code from
 module_64.c to elf_util_64.c.
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956898-5991-5-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160815074634.GC21080@balbir.ozlabs.ibm.com> <4126991.2tm6WB17SD@hactar>
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Eric Biederman <ebiederm@xmission.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vivek Goyal <vgoyal@redhat.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <3ca4a2de-0d44-dbc6-b57b-c149d10b048f@gmail.com>
Date: Tue, 16 Aug 2016 16:52:54 +1000
MIME-Version: 1.0
In-Reply-To: <4126991.2tm6WB17SD@hactar>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/08/16 09:25, Thiago Jung Bauermann wrote:
> Am Montag, 15 August 2016, 17:46:34 schrieb Balbir Singh:
>> On Thu, Aug 11, 2016 at 08:08:09PM -0300, Thiago Jung Bauermann wrote:
>>> +/**
>>> + * elf64_apply_relocate_add - apply 64 bit RELA relocations
>>> + * @elf_info:		Support information for the ELF binary being 
> relocated.
>>> + * @strtab:		String table for the associated symbol 
> table.
>>> + * @symindex:		Section header index for the associated 
> symbol table.
>>> + * @relsec:		Section header index for the relocations to 
> apply.
>>> + * @obj_name:		The name of the ELF binary, for information 
> messages.
>>> + */
>>> +int elf64_apply_relocate_add(const struct elf_info *elf_info,
>>> +			     const char *strtab, unsigned int symindex,
>>> +			     unsigned int relsec, const char *obj_name)
>>> +{
>>> +	unsigned int i;
>>> +	Elf64_Shdr *sechdrs = elf_info->sechdrs;
>>> +	Elf64_Rela *rela = (void *)sechdrs[relsec].sh_addr;
>>> +	Elf64_Sym *sym;
>>> +	unsigned long *location;
>>> +	unsigned long value;
>>> +
>>
>> For the relocatable kernel we expect only
>>
>> R_PPC64_RELATIVE
>> R_PPC64_NONE
>> R_PPC64_ADDR64
>>
>> In the future we can use this to check/assert the usage of this
>> for the core kernel (vmlinux) when loaded.
>>
>> Did we check elf64_apply_relocate_add with zImage and vmlinux?
> 
> kexec_file_load doesn't call call elf64_apply_relocate_add on the kernel 
> image, it only uses it to relocate the purgatory. So whether it is loading a 
> zImage or a vmlinux file, the function will work in the same way since the 
> purgatory binary is the same regardless of the kernel image format.

Thanks for clarifying.

> 
> For the same reason, as it currently stands kexec_file_load can't check the 
> relocation types used in the kernel image. But it is possible to add such a 
> check/assertion in kexec_elf_64.c:build_elf_exec_info if we want.
> 
> I tested kexec_file_load on both relocatable and non-relocatable vmlinux and 
> it works correctly.
> 
> I hadn't tested with zImage yet. I just did, and I had two problems:
> 
> 1. For some reason, it has an INTERP segment. This patch series doesn't 
> support loading program interpreters for ELF binaries, so 
> kexec_elf_64.c:build_elf_exec_info refuses to load them.
> 
> 2. If I disable the check for the INTERP segment, the zImage file loads 
> correctly, but then I get an exception during reboot when loading the kexec 
> image, right before jumping into the purgatory. I suspect this is because 
> the LOAD segment has a virtual address of 0, and the first kernel is not 
> coping well with that. But I still have to debug it further.
> 
> Is there a reason for the zImage ELF header to request an interpreter and to 
> have a virtual address of 0?
> 

Not that I am aware of. 

Balbir Singh
