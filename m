Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybsVb3y0vzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 02:53:27 +1100 (AEDT)
Date: Tue, 14 Nov 2017 09:53:23 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 2/3] powerpc/modules: Don't try to restore r2 after a
 sibling call
Message-ID: <20171114155323.3sjxx3eykinnl2ea@treble>
References: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
 <20171114092910.20399-3-kamalesh@linux.vnet.ibm.com>
 <1510654928.8xrjtkjm8m.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1510654928.8xrjtkjm8m.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 14, 2017 at 03:59:21PM +0530, Naveen N. Rao wrote:
> Kamalesh Babulal wrote:
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > When attempting to load a livepatch module, I got the following error:
> > 
> >   module_64: patch_module: Expect noop after relocate, got 3c820000
> > 
> > The error was triggered by the following code in
> > unregister_netdevice_queue():
> > 
> >   14c:   00 00 00 48     b       14c <unregister_netdevice_queue+0x14c>
> >                          14c: R_PPC64_REL24      net_set_todo
> >   150:   00 00 82 3c     addis   r4,r2,0
> > 
> > GCC didn't insert a nop after the branch to net_set_todo() because it's
> > a sibling call, so it never returns.  The nop isn't needed after the
> > branch in that case.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/module_64.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> > index 39b01fd..9e5391f 100644
> > --- a/arch/powerpc/kernel/module_64.c
> > +++ b/arch/powerpc/kernel/module_64.c
> > @@ -489,6 +489,10 @@ static int restore_r2(u32 *instruction, struct module *me)
> >  	if (is_early_mcount_callsite(instruction - 1))
> >  		return 1;
> > 
> > +	/* Sibling calls don't return, so they don't need to restore r2 */
> > +	if (instruction[-1] == PPC_INST_BRANCH)
> > +		return 1;
> > +
> 
> This looks quite fragile, unless we know for sure that gcc will _always_
> emit this instruction form for sibling calls with relocations.
> 
> As an alternative, does it make sense to do the following check instead?
> 	if ((instr_is_branch_iform(insn) || instr_is_branch_bform(insn))
> 		&& !(insn & 0x1))

Yes, good point.  How about something like this?

(completely untested because I don't have access to a box at the moment)


diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index abef812de7f8..302e4368debc 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -33,6 +33,7 @@ int patch_branch(unsigned int *addr, unsigned long target, int flags);
 int patch_instruction(unsigned int *addr, unsigned int instr);
 
 int instr_is_relative_branch(unsigned int instr);
+int instr_is_link_branch(unsigned int instr);
 int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr);
 unsigned long branch_target(const unsigned int *instr);
 unsigned int translate_branch(const unsigned int *dest,
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 9cb007bc7075..b5148a206b4d 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -487,11 +487,13 @@ static bool is_early_mcount_callsite(u32 *instruction)
    restore r2. */
 static int restore_r2(u32 *instruction, struct module *me)
 {
-	if (is_early_mcount_callsite(instruction - 1))
+	u32 *prev_insn = instruction - 1;
+
+	if (is_early_mcount_callsite(prev_insn))
 		return 1;
 
 	/* Sibling calls don't return, so they don't need to restore r2 */
-	if (instruction[-1] == PPC_INST_BRANCH)
+	if (!instr_is_link_branch(*prev_insn))
 		return 1;
 
 	if (*instruction != PPC_INST_NOP) {
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index c9de03e0c1f1..4727fafd37e4 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -304,6 +304,12 @@ int instr_is_relative_branch(unsigned int instr)
 	return instr_is_branch_iform(instr) || instr_is_branch_bform(instr);
 }
 
+int instr_is_link_branch(unsigned int instr)
+{
+	return (instr_is_branch_iform(instr) || instr_is_branch_bform(instr)) &&
+	       (instr & BRANCH_SET_LINK);
+}
+
 static unsigned long branch_iform_target(const unsigned int *instr)
 {
 	signed long imm;
