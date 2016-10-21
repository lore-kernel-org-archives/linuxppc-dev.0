Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0VLg6wl6zDvbK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 13:41:47 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L2d6jF015550
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:41:46 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2675yhs22v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:41:45 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 00:41:43 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 595FA1DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:41:42 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L2fg0U4350160
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:41:42 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L2ffS5006109
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:41:42 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v9 05/10] powerpc: Factor out relocation code in module_64.c
Date: Fri, 21 Oct 2016 00:40:12 -0200
In-Reply-To: <1477017617-8540-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1477017617-8540-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1477017617-8540-6-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kexec_file_load system call needs to relocate the purgatory, so
factor out the module relocation code so that it can be shared.

This patch's purpose is to move the ELF relocation logic from
apply_relocate_add to the new function elf64_apply_relocate_add_item
with as few changes as possible. The following changes were needed:

elf64_apply_relocate_add_item takes a my_r2 argument because the kexec
code can't use the my_r2 function since it doesn't have a struct module
to pass to it. For the same reason, it also takes an obj_name argument to
use in error messages. It still takes a pointer to struct module argument,
but kexec code can just pass NULL because except for the TOC symbol, the
purgatory doesn't have undefined symbols so the module pointer isn't used.

Apart from what is described in the paragraph above, the code has no
functional changes.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/module_64.c | 344 +++++++++++++++++++++-------------------
 1 file changed, 182 insertions(+), 162 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 183368e008cf..61baad036639 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -507,6 +507,181 @@ static int restore_r2(u32 *instruction, struct module *me)
 	return 1;
 }
 
+static int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs,
+					 const char *strtab,
+					 const Elf64_Rela *rela,
+					 const Elf64_Sym *sym,
+					 unsigned long *location,
+					 unsigned long value,
+					 unsigned long my_r2,
+					 const char *obj_name,
+					 struct module *me)
+{
+	switch (ELF64_R_TYPE(rela->r_info)) {
+	case R_PPC64_ADDR32:
+		/* Simply set it */
+		*(u32 *)location = value;
+		break;
+
+	case R_PPC64_ADDR64:
+		/* Simply set it */
+		*(unsigned long *)location = value;
+		break;
+
+	case R_PPC64_TOC:
+		*(unsigned long *)location = my_r2;
+		break;
+
+	case R_PPC64_TOC16:
+		/* Subtract TOC pointer */
+		value -= my_r2;
+		if (value + 0x8000 > 0xffff) {
+			pr_err("%s: bad TOC16 relocation (0x%lx)\n",
+			       obj_name, value);
+			return -ENOEXEC;
+		}
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xffff)
+			| (value & 0xffff);
+		break;
+
+	case R_PPC64_TOC16_LO:
+		/* Subtract TOC pointer */
+		value -= my_r2;
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xffff)
+			| (value & 0xffff);
+		break;
+
+	case R_PPC64_TOC16_DS:
+		/* Subtract TOC pointer */
+		value -= my_r2;
+		if ((value & 3) != 0 || value + 0x8000 > 0xffff) {
+			pr_err("%s: bad TOC16_DS relocation (0x%lx)\n",
+			       obj_name, value);
+			return -ENOEXEC;
+		}
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xfffc)
+			| (value & 0xfffc);
+		break;
+
+	case R_PPC64_TOC16_LO_DS:
+		/* Subtract TOC pointer */
+		value -= my_r2;
+		if ((value & 3) != 0) {
+			pr_err("%s: bad TOC16_LO_DS relocation (0x%lx)\n",
+			       obj_name, value);
+			return -ENOEXEC;
+		}
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xfffc)
+			| (value & 0xfffc);
+		break;
+
+	case R_PPC64_TOC16_HA:
+		/* Subtract TOC pointer */
+		value -= my_r2;
+		value = ((value + 0x8000) >> 16);
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xffff)
+			| (value & 0xffff);
+		break;
+
+	case R_PPC_REL24:
+		/* FIXME: Handle weak symbols here --RR */
+		if (sym->st_shndx == SHN_UNDEF) {
+			/* External: go via stub */
+			value = stub_for_addr(sechdrs, value, me);
+			if (!value)
+				return -ENOENT;
+			if (!restore_r2((u32 *)location + 1, me))
+				return -ENOEXEC;
+
+			squash_toc_save_inst(strtab + sym->st_name, value);
+		} else
+			value += local_entry_offset(sym);
+
+		/* Convert value to relative */
+		value -= (unsigned long)location;
+		if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0) {
+			pr_err("%s: REL24 %li out of range!\n",
+			       obj_name, (long int)value);
+			return -ENOEXEC;
+		}
+
+		/* Only replace bits 2 through 26 */
+		*(uint32_t *)location
+			= (*(uint32_t *)location & ~0x03fffffc)
+			| (value & 0x03fffffc);
+		break;
+
+	case R_PPC64_REL64:
+		/* 64 bits relative (used by features fixups) */
+		*location = value - (unsigned long)location;
+		break;
+
+	case R_PPC64_TOCSAVE:
+		/*
+		 * Marker reloc indicates we don't have to save r2.
+		 * That would only save us one instruction, so ignore
+		 * it.
+		 */
+		break;
+
+	case R_PPC64_ENTRY:
+		/*
+		 * Optimize ELFv2 large code model entry point if
+		 * the TOC is within 2GB range of current location.
+		 */
+		value = my_r2 - (unsigned long)location;
+		if (value + 0x80008000 > 0xffffffff)
+			break;
+		/*
+		 * Check for the large code model prolog sequence:
+		 *	ld r2, ...(r12)
+		 *	add r2, r2, r12
+		 */
+		if ((((uint32_t *)location)[0] & ~0xfffc)
+		    != 0xe84c0000)
+			break;
+		if (((uint32_t *)location)[1] != 0x7c426214)
+			break;
+		/*
+		 * If found, replace it with:
+		 *	addis r2, r12, (.TOC.-func)@ha
+		 *	addi r2, r12, (.TOC.-func)@l
+		 */
+		((uint32_t *)location)[0] = 0x3c4c0000 + PPC_HA(value);
+		((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
+		break;
+
+	case R_PPC64_REL16_HA:
+		/* Subtract location pointer */
+		value -= (unsigned long)location;
+		value = ((value + 0x8000) >> 16);
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xffff)
+			| (value & 0xffff);
+		break;
+
+	case R_PPC64_REL16_LO:
+		/* Subtract location pointer */
+		value -= (unsigned long)location;
+		*((uint16_t *) location)
+			= (*((uint16_t *) location) & ~0xffff)
+			| (value & 0xffff);
+		break;
+
+	default:
+		pr_err("%s: Unknown ADD relocation: %lu\n", obj_name,
+		       (unsigned long)ELF64_R_TYPE(rela->r_info));
+		return -ENOEXEC;
+	}
+
+	return 0;
+}
+
 int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       const char *strtab,
 		       unsigned int symindex,
@@ -514,6 +689,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       struct module *me)
 {
 	unsigned int i;
+	int ret;
 	Elf64_Rela *rela = (void *)sechdrs[relsec].sh_addr;
 	Elf64_Sym *sym;
 	unsigned long *location;
@@ -548,168 +724,12 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		/* `Everything is relative'. */
 		value = sym->st_value + rela[i].r_addend;
 
-		switch (ELF64_R_TYPE(rela[i].r_info)) {
-		case R_PPC64_ADDR32:
-			/* Simply set it */
-			*(u32 *)location = value;
-			break;
-
-		case R_PPC64_ADDR64:
-			/* Simply set it */
-			*(unsigned long *)location = value;
-			break;
-
-		case R_PPC64_TOC:
-			*(unsigned long *)location = my_r2(sechdrs, me);
-			break;
-
-		case R_PPC64_TOC16:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			if (value + 0x8000 > 0xffff) {
-				pr_err("%s: bad TOC16 relocation (0x%lx)\n",
-				       me->name, value);
-				return -ENOEXEC;
-			}
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC64_TOC16_LO:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC64_TOC16_DS:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			if ((value & 3) != 0 || value + 0x8000 > 0xffff) {
-				pr_err("%s: bad TOC16_DS relocation (0x%lx)\n",
-				       me->name, value);
-				return -ENOEXEC;
-			}
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xfffc)
-				| (value & 0xfffc);
-			break;
-
-		case R_PPC64_TOC16_LO_DS:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			if ((value & 3) != 0) {
-				pr_err("%s: bad TOC16_LO_DS relocation (0x%lx)\n",
-				       me->name, value);
-				return -ENOEXEC;
-			}
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xfffc)
-				| (value & 0xfffc);
-			break;
-
-		case R_PPC64_TOC16_HA:
-			/* Subtract TOC pointer */
-			value -= my_r2(sechdrs, me);
-			value = ((value + 0x8000) >> 16);
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC_REL24:
-			/* FIXME: Handle weak symbols here --RR */
-			if (sym->st_shndx == SHN_UNDEF) {
-				/* External: go via stub */
-				value = stub_for_addr(sechdrs, value, me);
-				if (!value)
-					return -ENOENT;
-				if (!restore_r2((u32 *)location + 1, me))
-					return -ENOEXEC;
-
-				squash_toc_save_inst(strtab + sym->st_name, value);
-			} else
-				value += local_entry_offset(sym);
-
-			/* Convert value to relative */
-			value -= (unsigned long)location;
-			if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0){
-				pr_err("%s: REL24 %li out of range!\n",
-				       me->name, (long int)value);
-				return -ENOEXEC;
-			}
-
-			/* Only replace bits 2 through 26 */
-			*(uint32_t *)location
-				= (*(uint32_t *)location & ~0x03fffffc)
-				| (value & 0x03fffffc);
-			break;
-
-		case R_PPC64_REL64:
-			/* 64 bits relative (used by features fixups) */
-			*location = value - (unsigned long)location;
-			break;
-
-		case R_PPC64_TOCSAVE:
-			/*
-			 * Marker reloc indicates we don't have to save r2.
-			 * That would only save us one instruction, so ignore
-			 * it.
-			 */
-			break;
-
-		case R_PPC64_ENTRY:
-			/*
-			 * Optimize ELFv2 large code model entry point if
-			 * the TOC is within 2GB range of current location.
-			 */
-			value = my_r2(sechdrs, me) - (unsigned long)location;
-			if (value + 0x80008000 > 0xffffffff)
-				break;
-			/*
-			 * Check for the large code model prolog sequence:
-		         *	ld r2, ...(r12)
-			 *	add r2, r2, r12
-			 */
-			if ((((uint32_t *)location)[0] & ~0xfffc)
-			    != 0xe84c0000)
-				break;
-			if (((uint32_t *)location)[1] != 0x7c426214)
-				break;
-			/*
-			 * If found, replace it with:
-			 *	addis r2, r12, (.TOC.-func)@ha
-			 *	addi r2, r12, (.TOC.-func)@l
-			 */
-			((uint32_t *)location)[0] = 0x3c4c0000 + PPC_HA(value);
-			((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
-			break;
-
-		case R_PPC64_REL16_HA:
-			/* Subtract location pointer */
-			value -= (unsigned long)location;
-			value = ((value + 0x8000) >> 16);
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		case R_PPC64_REL16_LO:
-			/* Subtract location pointer */
-			value -= (unsigned long)location;
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
-			break;
-
-		default:
-			pr_err("%s: Unknown ADD relocation: %lu\n",
-			       me->name,
-			       (unsigned long)ELF64_R_TYPE(rela[i].r_info));
-			return -ENOEXEC;
-		}
+		ret = elf64_apply_relocate_add_item(sechdrs, strtab, &rela[i],
+						    sym, location, value,
+						    my_r2(sechdrs, me),
+						    me->name, me);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.7.4
