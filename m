Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCs7F1l6SzDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 09:26:00 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7FNIOha111146
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 19:25:58 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24th40ye8g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 19:25:58 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 15 Aug 2016 20:25:56 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id BC4D41DC006F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 19:25:45 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7FNPsnf4956182
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 20:25:54 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7FNPr3G005368
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 20:25:54 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: bsingharora@gmail.com
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 04/13] powerpc: Factor out relocation code from
 module_64.c to elf_util_64.c.
Date: Mon, 15 Aug 2016 20:25:51 -0300
In-Reply-To: <20160815074634.GC21080@balbir.ozlabs.ibm.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956898-5991-5-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160815074634.GC21080@balbir.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <4126991.2tm6WB17SD@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Montag, 15 August 2016, 17:46:34 schrieb Balbir Singh:
> On Thu, Aug 11, 2016 at 08:08:09PM -0300, Thiago Jung Bauermann wrote:
> > +/**
> > + * elf64_apply_relocate_add - apply 64 bit RELA relocations
> > + * @elf_info:		Support information for the ELF binary being 
relocated.
> > + * @strtab:		String table for the associated symbol 
table.
> > + * @symindex:		Section header index for the associated 
symbol table.
> > + * @relsec:		Section header index for the relocations to 
apply.
> > + * @obj_name:		The name of the ELF binary, for information 
messages.
> > + */
> > +int elf64_apply_relocate_add(const struct elf_info *elf_info,
> > +			     const char *strtab, unsigned int symindex,
> > +			     unsigned int relsec, const char *obj_name)
> > +{
> > +	unsigned int i;
> > +	Elf64_Shdr *sechdrs = elf_info->sechdrs;
> > +	Elf64_Rela *rela = (void *)sechdrs[relsec].sh_addr;
> > +	Elf64_Sym *sym;
> > +	unsigned long *location;
> > +	unsigned long value;
> > +
> 
> For the relocatable kernel we expect only
> 
> R_PPC64_RELATIVE
> R_PPC64_NONE
> R_PPC64_ADDR64
> 
> In the future we can use this to check/assert the usage of this
> for the core kernel (vmlinux) when loaded.
> 
> Did we check elf64_apply_relocate_add with zImage and vmlinux?

kexec_file_load doesn't call call elf64_apply_relocate_add on the kernel 
image, it only uses it to relocate the purgatory. So whether it is loading a 
zImage or a vmlinux file, the function will work in the same way since the 
purgatory binary is the same regardless of the kernel image format.

For the same reason, as it currently stands kexec_file_load can't check the 
relocation types used in the kernel image. But it is possible to add such a 
check/assertion in kexec_elf_64.c:build_elf_exec_info if we want.

I tested kexec_file_load on both relocatable and non-relocatable vmlinux and 
it works correctly.

I hadn't tested with zImage yet. I just did, and I had two problems:

1. For some reason, it has an INTERP segment. This patch series doesn't 
support loading program interpreters for ELF binaries, so 
kexec_elf_64.c:build_elf_exec_info refuses to load them.

2. If I disable the check for the INTERP segment, the zImage file loads 
correctly, but then I get an exception during reboot when loading the kexec 
image, right before jumping into the purgatory. I suspect this is because 
the LOAD segment has a virtual address of 0, and the first kernel is not 
coping well with that. But I still have to debug it further.

Is there a reason for the zImage ELF header to request an interpreter and to 
have a virtual address of 0?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
