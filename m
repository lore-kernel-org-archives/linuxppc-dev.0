Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjBKr3L6nzDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 18:49:20 +1100 (AEDT)
Subject: Re: [PATCH v2] powerpc: fix boot on BOOK3S_32 with
 CONFIG_STRICT_KERNEL_RWX
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Meelis Roos <mroos@linux.ee>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
References: <20171121142820.C744F6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
 <CAKTCnznviUQfizSdfMDGxO_8CFuwhPCNSkK2VagNSRvZdpLqyg@mail.gmail.com>
 <141a04c4-a236-430d-f346-ad31252e146a@c-s.fr>
 <87h8tm355i.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <74521488-5ddb-4fe2-f419-9a9debeaaf0f@c-s.fr>
Date: Thu, 23 Nov 2017 08:49:16 +0100
MIME-Version: 1.0
In-Reply-To: <87h8tm355i.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/11/2017 à 12:48, Michael Ellerman a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
> 
>> Le 22/11/2017 à 00:07, Balbir Singh a écrit :
>>> On Wed, Nov 22, 2017 at 1:28 AM, Christophe Leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>>> On powerpc32, patch_instruction() is called by apply_feature_fixups()
>>>> which is called from early_init()
>>>>
>>>> There is the following note in front of early_init():
>>>>    * Note that the kernel may be running at an address which is different
>>>>    * from the address that it was linked at, so we must use RELOC/PTRRELOC
>>>>    * to access static data (including strings).  -- paulus
>>>>
>>>> Therefore, slab_is_available() cannot be called yet, and
>>>> text_poke_area must be addressed with PTRRELOC()
>>>>
>>>> Fixes: 37bc3e5fd764f ("powerpc/lib/code-patching: Use alternate map
>>>> for patch_instruction()")
>>>> Reported-by: Meelis Roos <mroos@linux.ee>
>>>> Cc: Balbir Singh <bsingharora@gmail.com>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> ---
>>>>    v2: Added missing asm/setup.h
>>>>
>>>>    arch/powerpc/lib/code-patching.c | 6 ++----
>>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
>>>> index c9de03e0c1f1..d469224c4ada 100644
>>>> --- a/arch/powerpc/lib/code-patching.c
>>>> +++ b/arch/powerpc/lib/code-patching.c
>>>> @@ -21,6 +21,7 @@
>>>>    #include <asm/tlbflush.h>
>>>>    #include <asm/page.h>
>>>>    #include <asm/code-patching.h>
>>>> +#include <asm/setup.h>
>>>>
>>>>    static int __patch_instruction(unsigned int *addr, unsigned int instr)
>>>>    {
>>>> @@ -146,11 +147,8 @@ int patch_instruction(unsigned int *addr, unsigned int instr)
>>>>            * During early early boot patch_instruction is called
>>>>            * when text_poke_area is not ready, but we still need
>>>>            * to allow patching. We just do the plain old patching
>>>> -        * We use slab_is_available and per cpu read * via this_cpu_read
>>>> -        * of text_poke_area. Per-CPU areas might not be up early
>>>> -        * this can create problems with just using this_cpu_read()
>>>>            */
>>>> -       if (!slab_is_available() || !this_cpu_read(text_poke_area))
>>>> +       if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
>>>>                   return __patch_instruction(addr, instr);
>>>
>>> On ppc64, we call apply_feature_fixups() in early_setup() after we've
>>> relocated ourselves. Sorry for missing the ppc32 case. I would like to
>>> avoid PTRRELOC when unnecessary.
>>
>> What do you suggest then ?
>>
>> Some #ifdef PPC32 around that ?
> 
> No I don't think that improves anything.
> 
> I think the comment about per-cpu not being up is wrong, you'll just get
> the static version of text_poke_area, which should be NULL. So we don't
> need the slab_available() check anyway.
> 
> So I'll take this as-is.
> 
> Having said that I absolutely hate PTRRELOC, so if it starts spreading
> we will have to come up with something less bug prone.

Would something like that be the solution ?

diff --git a/arch/powerpc/include/asm/code-patching.h 
b/arch/powerpc/include/asm/code-patching.h
index abef812de7f8..1c8dd340f5fc 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -30,7 +30,11 @@ unsigned int create_branch(const unsigned int *addr,
  unsigned int create_cond_branch(const unsigned int *addr,
  				unsigned long target, int flags);
  int patch_branch(unsigned int *addr, unsigned long target, int flags);
-int patch_instruction(unsigned int *addr, unsigned int instr);
+int patch_instruction_early(unsigned int *addr, unsigned int instr, 
bool early);
+static inline int patch_instruction(unsigned int *addr, unsigned int instr)
+{
+	return patch_instruction_early(addr, instr, false);
+}

  int instr_is_relative_branch(unsigned int instr);
  int instr_is_branch_to_addr(const unsigned int *instr, unsigned long 
addr);
diff --git a/arch/powerpc/lib/code-patching.c 
b/arch/powerpc/lib/code-patching.c
index d469224c4ada..84ebf9203e40 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -135,7 +135,7 @@ static inline int unmap_patch_area(unsigned long addr)
  	return 0;
  }

-int patch_instruction(unsigned int *addr, unsigned int instr)
+int patch_instruction_early(unsigned int *addr, unsigned int instr, 
bool early)
  {
  	int err;
  	unsigned int *dest = NULL;
@@ -148,7 +148,7 @@ int patch_instruction(unsigned int *addr, unsigned 
int instr)
  	 * when text_poke_area is not ready, but we still need
  	 * to allow patching. We just do the plain old patching
  	 */
-	if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
+	if (early || !this_cpu_read(text_poke_area))
  		return __patch_instruction(addr, instr);

  	local_irq_save(flags);
@@ -182,13 +182,13 @@ int patch_instruction(unsigned int *addr, unsigned 
int instr)
  }
  #else /* !CONFIG_STRICT_KERNEL_RWX */

-int patch_instruction(unsigned int *addr, unsigned int instr)
+int patch_instruction_early(unsigned int *addr, unsigned int instr, 
bool early)
  {
  	return __patch_instruction(addr, instr);
  }

  #endif /* CONFIG_STRICT_KERNEL_RWX */
-NOKPROBE_SYMBOL(patch_instruction);
+NOKPROBE_SYMBOL(patch_instruction_early);

  int patch_branch(unsigned int *addr, unsigned long target, int flags)
  {
diff --git a/arch/powerpc/lib/feature-fixups.c 
b/arch/powerpc/lib/feature-fixups.c
index 41cf5ae273cf..4c98ece9e558 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -45,7 +45,8 @@ static unsigned int *calc_addr(struct fixup_entry 
*fcur, long offset)
  }

  static int patch_alt_instruction(unsigned int *src, unsigned int *dest,
-				 unsigned int *alt_start, unsigned int *alt_end)
+				 unsigned int *alt_start, unsigned int *alt_end,
+				 bool early)
  {
  	unsigned int instr;

@@ -62,12 +63,13 @@ static int patch_alt_instruction(unsigned int *src, 
unsigned int *dest,
  		}
  	}

-	patch_instruction(dest, instr);
+	patch_instruction_early(dest, instr, early);

  	return 0;
  }

-static int patch_feature_section(unsigned long value, struct 
fixup_entry *fcur)
+static int __patch_feature_section(unsigned long value, struct 
fixup_entry *fcur,
+				   bool early)
  {
  	unsigned int *start, *end, *alt_start, *alt_end, *src, *dest;

@@ -86,17 +88,18 @@ static int patch_feature_section(unsigned long 
value, struct fixup_entry *fcur)
  	dest = start;

  	for (; src < alt_end; src++, dest++) {
-		if (patch_alt_instruction(src, dest, alt_start, alt_end))
+		if (patch_alt_instruction(src, dest, alt_start, alt_end, early))
  			return 1;
  	}

  	for (; dest < end; dest++)
-		patch_instruction(dest, PPC_INST_NOP);
+		patch_instruction_early(dest, PPC_INST_NOP, early);

  	return 0;
  }

-void do_feature_fixups(unsigned long value, void *fixup_start, void 
*fixup_end)
+static void __do_feature_fixups(unsigned long value, void *fixup_start,
+				void *fixup_end, bool early)
  {
  	struct fixup_entry *fcur, *fend;

@@ -104,7 +107,7 @@ void do_feature_fixups(unsigned long value, void 
*fixup_start, void *fixup_end)
  	fend = fixup_end;

  	for (; fcur < fend; fcur++) {
-		if (patch_feature_section(value, fcur)) {
+		if (__patch_feature_section(value, fcur, early)) {
  			WARN_ON(1);
  			printk("Unable to patch feature section at %p - %p" \
  				" with %p - %p\n",
@@ -116,7 +119,13 @@ void do_feature_fixups(unsigned long value, void 
*fixup_start, void *fixup_end)
  	}
  }

-void do_lwsync_fixups(unsigned long value, void *fixup_start, void 
*fixup_end)
+void do_feature_fixups(unsigned long value, void *fixup_start, void 
*fixup_end)
+{
+	__do_feature_fixups(value, fixup_start, fixup_end, false);
+}
+
+static void __do_lwsync_fixups(unsigned long value, void *fixup_start,
+			       void *fixup_end, bool early)
  {
  	long *start, *end;
  	unsigned int *dest;
@@ -129,10 +138,15 @@ void do_lwsync_fixups(unsigned long value, void 
*fixup_start, void *fixup_end)

  	for (; start < end; start++) {
  		dest = (void *)start + *start;
-		patch_instruction(dest, PPC_INST_LWSYNC);
+		patch_instruction_early(dest, PPC_INST_LWSYNC, early);
  	}
  }

+void do_lwsync_fixups(unsigned long value, void *fixup_start, void 
*fixup_end)
+{
+	__do_lwsync_fixups(value, fixup_start, fixup_end, false);
+}
+
  static void do_final_fixups(void)
  {
  #if defined(CONFIG_PPC64) && defined(CONFIG_RELOCATABLE)
@@ -147,7 +161,7 @@ static void do_final_fixups(void)
  	length = (__end_interrupts - _stext) / sizeof(int);

  	while (length--) {
-		patch_instruction(dest, *src);
+		patch_instruction_early(dest, *src, true);
  		src++;
  		dest++;
  	}
@@ -171,22 +185,23 @@ void __init apply_feature_fixups(void)
  	 * Apply the CPU-specific and firmware specific fixups to kernel text
  	 * (nop out sections not relevant to this CPU or this firmware).
  	 */
-	do_feature_fixups(spec->cpu_features,
+	__do_feature_fixups(spec->cpu_features,
  			  PTRRELOC(&__start___ftr_fixup),
-			  PTRRELOC(&__stop___ftr_fixup));
+			  PTRRELOC(&__stop___ftr_fixup), true);

-	do_feature_fixups(spec->mmu_features,
+	__do_feature_fixups(spec->mmu_features,
  			  PTRRELOC(&__start___mmu_ftr_fixup),
-			  PTRRELOC(&__stop___mmu_ftr_fixup));
+			  PTRRELOC(&__stop___mmu_ftr_fixup), true);

-	do_lwsync_fixups(spec->cpu_features,
+	__do_lwsync_fixups(spec->cpu_features,
  			 PTRRELOC(&__start___lwsync_fixup),
-			 PTRRELOC(&__stop___lwsync_fixup));
+			 PTRRELOC(&__stop___lwsync_fixup), true);

  #ifdef CONFIG_PPC64
  	saved_firmware_features = powerpc_firmware_features;
  	do_feature_fixups(powerpc_firmware_features,
-			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
+			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup,
+			  true);
  #endif
  	do_final_fixups();
  }
@@ -226,6 +241,11 @@ late_initcall(check_features);
  /* This must be after the text it fixes up, vmlinux.lds.S enforces 
that atm */
  static struct fixup_entry fixup;

+static int patch_feature_section(unsigned long value, struct 
fixup_entry *fcur)
+{
+	return __patch_feature_section(value, fcur, false);
+}
+
  static long calc_offset(struct fixup_entry *entry, unsigned int *p)
  {
  	return (unsigned long)p - (unsigned long)entry;


Christophe
