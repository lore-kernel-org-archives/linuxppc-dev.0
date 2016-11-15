Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHtl675WQzDvj7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 14:52:50 +1100 (AEDT)
Date: Tue, 15 Nov 2016 14:52:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Thiago Jung
 Bauermann <bauerman@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the akpm tree with the powerpc tree
Message-ID: <20161115145250.4f38496e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

Today's linux-next merge of the akpm tree got a conflict in:

  arch/powerpc/kernel/module_64.c

between commit:

  9f751b82b491 ("powerpc/module: Add support for R_PPC64_REL32 relocations")

from the powerpc tree and patch:

  "powerpc: factor out relocation code in module_64.c"

from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/kernel/module_64.c
index bb1807184bad,61baad036639..000000000000
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@@ -507,6 -507,181 +507,186 @@@ static int restore_r2(u32 *instruction
  	return 1;
  }
  
+ static int elf64_apply_relocate_add_item(const Elf64_Shdr *sechdrs,
+ 					 const char *strtab,
+ 					 const Elf64_Rela *rela,
+ 					 const Elf64_Sym *sym,
+ 					 unsigned long *location,
+ 					 unsigned long value,
+ 					 unsigned long my_r2,
+ 					 const char *obj_name,
+ 					 struct module *me)
+ {
+ 	switch (ELF64_R_TYPE(rela->r_info)) {
+ 	case R_PPC64_ADDR32:
+ 		/* Simply set it */
+ 		*(u32 *)location = value;
+ 		break;
+ 
+ 	case R_PPC64_ADDR64:
+ 		/* Simply set it */
+ 		*(unsigned long *)location = value;
+ 		break;
+ 
+ 	case R_PPC64_TOC:
+ 		*(unsigned long *)location = my_r2;
+ 		break;
+ 
+ 	case R_PPC64_TOC16:
+ 		/* Subtract TOC pointer */
+ 		value -= my_r2;
+ 		if (value + 0x8000 > 0xffff) {
+ 			pr_err("%s: bad TOC16 relocation (0x%lx)\n",
+ 			       obj_name, value);
+ 			return -ENOEXEC;
+ 		}
+ 		*((uint16_t *) location)
+ 			= (*((uint16_t *) location) & ~0xffff)
+ 			| (value & 0xffff);
+ 		break;
+ 
+ 	case R_PPC64_TOC16_LO:
+ 		/* Subtract TOC pointer */
+ 		value -= my_r2;
+ 		*((uint16_t *) location)
+ 			= (*((uint16_t *) location) & ~0xffff)
+ 			| (value & 0xffff);
+ 		break;
+ 
+ 	case R_PPC64_TOC16_DS:
+ 		/* Subtract TOC pointer */
+ 		value -= my_r2;
+ 		if ((value & 3) != 0 || value + 0x8000 > 0xffff) {
+ 			pr_err("%s: bad TOC16_DS relocation (0x%lx)\n",
+ 			       obj_name, value);
+ 			return -ENOEXEC;
+ 		}
+ 		*((uint16_t *) location)
+ 			= (*((uint16_t *) location) & ~0xfffc)
+ 			| (value & 0xfffc);
+ 		break;
+ 
+ 	case R_PPC64_TOC16_LO_DS:
+ 		/* Subtract TOC pointer */
+ 		value -= my_r2;
+ 		if ((value & 3) != 0) {
+ 			pr_err("%s: bad TOC16_LO_DS relocation (0x%lx)\n",
+ 			       obj_name, value);
+ 			return -ENOEXEC;
+ 		}
+ 		*((uint16_t *) location)
+ 			= (*((uint16_t *) location) & ~0xfffc)
+ 			| (value & 0xfffc);
+ 		break;
+ 
+ 	case R_PPC64_TOC16_HA:
+ 		/* Subtract TOC pointer */
+ 		value -= my_r2;
+ 		value = ((value + 0x8000) >> 16);
+ 		*((uint16_t *) location)
+ 			= (*((uint16_t *) location) & ~0xffff)
+ 			| (value & 0xffff);
+ 		break;
+ 
+ 	case R_PPC_REL24:
+ 		/* FIXME: Handle weak symbols here --RR */
+ 		if (sym->st_shndx == SHN_UNDEF) {
+ 			/* External: go via stub */
+ 			value = stub_for_addr(sechdrs, value, me);
+ 			if (!value)
+ 				return -ENOENT;
+ 			if (!restore_r2((u32 *)location + 1, me))
+ 				return -ENOEXEC;
+ 
+ 			squash_toc_save_inst(strtab + sym->st_name, value);
+ 		} else
+ 			value += local_entry_offset(sym);
+ 
+ 		/* Convert value to relative */
+ 		value -= (unsigned long)location;
+ 		if (value + 0x2000000 > 0x3ffffff || (value & 3) != 0) {
+ 			pr_err("%s: REL24 %li out of range!\n",
+ 			       obj_name, (long int)value);
+ 			return -ENOEXEC;
+ 		}
+ 
+ 		/* Only replace bits 2 through 26 */
+ 		*(uint32_t *)location
+ 			= (*(uint32_t *)location & ~0x03fffffc)
+ 			| (value & 0x03fffffc);
+ 		break;
+ 
+ 	case R_PPC64_REL64:
+ 		/* 64 bits relative (used by features fixups) */
+ 		*location = value - (unsigned long)location;
+ 		break;
+ 
++	case R_PPC64_REL32:
++		/* 32 bits relative (used by relative exception tables) */
++		*(u32 *)location = value - (unsigned long)location;
++		break;
++
+ 	case R_PPC64_TOCSAVE:
+ 		/*
+ 		 * Marker reloc indicates we don't have to save r2.
+ 		 * That would only save us one instruction, so ignore
+ 		 * it.
+ 		 */
+ 		break;
+ 
+ 	case R_PPC64_ENTRY:
+ 		/*
+ 		 * Optimize ELFv2 large code model entry point if
+ 		 * the TOC is within 2GB range of current location.
+ 		 */
+ 		value = my_r2 - (unsigned long)location;
+ 		if (value + 0x80008000 > 0xffffffff)
+ 			break;
+ 		/*
+ 		 * Check for the large code model prolog sequence:
+ 		 *	ld r2, ...(r12)
+ 		 *	add r2, r2, r12
+ 		 */
+ 		if ((((uint32_t *)location)[0] & ~0xfffc)
+ 		    != 0xe84c0000)
+ 			break;
+ 		if (((uint32_t *)location)[1] != 0x7c426214)
+ 			break;
+ 		/*
+ 		 * If found, replace it with:
+ 		 *	addis r2, r12, (.TOC.-func)@ha
+ 		 *	addi r2, r12, (.TOC.-func)@l
+ 		 */
+ 		((uint32_t *)location)[0] = 0x3c4c0000 + PPC_HA(value);
+ 		((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
+ 		break;
+ 
+ 	case R_PPC64_REL16_HA:
+ 		/* Subtract location pointer */
+ 		value -= (unsigned long)location;
+ 		value = ((value + 0x8000) >> 16);
+ 		*((uint16_t *) location)
+ 			= (*((uint16_t *) location) & ~0xffff)
+ 			| (value & 0xffff);
+ 		break;
+ 
+ 	case R_PPC64_REL16_LO:
+ 		/* Subtract location pointer */
+ 		value -= (unsigned long)location;
+ 		*((uint16_t *) location)
+ 			= (*((uint16_t *) location) & ~0xffff)
+ 			| (value & 0xffff);
+ 		break;
+ 
+ 	default:
+ 		pr_err("%s: Unknown ADD relocation: %lu\n", obj_name,
+ 		       (unsigned long)ELF64_R_TYPE(rela->r_info));
+ 		return -ENOEXEC;
+ 	}
+ 
+ 	return 0;
+ }
+ 
  int apply_relocate_add(Elf64_Shdr *sechdrs,
  		       const char *strtab,
  		       unsigned int symindex,
