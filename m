Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydWDl3mxxzDr8x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 19:17:11 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAH8F6vm064341
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 03:17:08 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e9tbs46wk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 03:17:08 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Fri, 17 Nov 2017 08:17:07 -0000
Subject: Re: [PATCH v4.2] powerpc/modules: Don't try to restore r2 after a
 sibling call
To: Josh Poimboeuf <jpoimboe@redhat.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
 <20171114092910.20399-3-kamalesh@linux.vnet.ibm.com>
 <1510654928.8xrjtkjm8m.naveen@linux.ibm.com>
 <20171114155323.3sjxx3eykinnl2ea@treble>
 <1510737417.g8rnjuztlf.naveen@linux.ibm.com>
 <20171116012628.6ajxlychto365sf6@treble>
 <1510837263.5d3ac8knzo.naveen@linux.ibm.com>
 <20171116174537.duz4x6vfzhp44lfh@treble>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Fri, 17 Nov 2017 13:47:03 +0530
MIME-Version: 1.0
In-Reply-To: <20171116174537.duz4x6vfzhp44lfh@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2094a573-d236-e1b7-6f4d-47049f3d0dfb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 16 November 2017 11:15 PM, Josh Poimboeuf wrote:
> On Thu, Nov 16, 2017 at 06:39:03PM +0530, Naveen N. Rao wrote:
>> Josh Poimboeuf wrote:
>>> On Wed, Nov 15, 2017 at 02:58:33PM +0530, Naveen N. Rao wrote:
>>>>> +int instr_is_link_branch(unsigned int instr)
>>>>> +{
>>>>> +	return (instr_is_branch_iform(instr) || instr_is_branch_bform(instr)) &&
>>>>> +	       (instr & BRANCH_SET_LINK);
>>>>> +}
>>>>> +
>>>>
>>>> Nitpicking here, but since we're not considering the other branch forms,
>>>> perhaps this can be renamed to instr_is_link_relative_branch() (or maybe
>>>> instr_is_relative_branch_link()), just so we're clear :)
>>>
>>> My understanding is that the absolute/relative bit isn't a "form", but
>>> rather a bit that can be set for either the b-form (conditional) or the
>>> i-form (unconditional).  And the above function isn't checking the
>>> absolute bit, so it isn't necessarily a relative branch.  Or did I miss
>>> something?
>>
>> Ah, good point. I was coming from the fact that we are only considering the
>> i-form and b-form branches and not the lr/ctr/tar based branches, which are
>> always absolute branches, but can also set the link register.
>
> Hm, RISC is more complicated than I realized ;-)
>
>> Thinking about this more, aren't we only interested in relative branches
>> here (for relocations), so can we actually filter out the absolute branches?
>> Something like this?
>>
>> int instr_is_relative_branch_link(unsigned int instr)
>> {
>> 	return ((instr_is_branch_iform(instr) || instr_is_branch_bform(instr)) &&
>> 	       !(instr & BRANCH_ABSOLUTE) && (instr & BRANCH_SET_LINK));
>
> Yeah, makes sense to me.  Here's another try (also untested).  If this
> looks ok, Kamalesh would you mind testing again?
>
> ----8<----
>
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH v4.2] powerpc/modules: Don't try to restore r2 after a sibling call
>
> When attempting to load a livepatch module, I got the following error:
>
>   module_64: patch_module: Expect noop after relocate, got 3c820000
>
> The error was triggered by the following code in
> unregister_netdevice_queue():
>
>   14c:   00 00 00 48     b       14c <unregister_netdevice_queue+0x14c>
>                          14c: R_PPC64_REL24      net_set_todo
>   150:   00 00 82 3c     addis   r4,r2,0
>
> GCC didn't insert a nop after the branch to net_set_todo() because it's
> a sibling call, so it never returns.  The nop isn't needed after the
> branch in that case.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-and-tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/code-patching.h |  1 +
>  arch/powerpc/kernel/module_64.c          | 12 +++++++++++-
>  arch/powerpc/lib/code-patching.c         |  5 +++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> index abef812de7f8..2c895e8d07f7 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -33,6 +33,7 @@ int patch_branch(unsigned int *addr, unsigned long target, int flags);
>  int patch_instruction(unsigned int *addr, unsigned int instr);
>
>  int instr_is_relative_branch(unsigned int instr);
> +int instr_is_relative_link_branch(unsigned int instr);
>  int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr);
>  unsigned long branch_target(const unsigned int *instr);
>  unsigned int translate_branch(const unsigned int *dest,
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index 759104b99f9f..180c16f04063 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -487,7 +487,17 @@ static bool is_early_mcount_callsite(u32 *instruction)
>     restore r2. */
>  static int restore_r2(u32 *instruction, struct module *me)
>  {
> -	if (is_early_mcount_callsite(instruction - 1))
> +	u32 *prev_insn = instruction - 1;
> +
> +	if (is_early_mcount_callsite(prev_insn))
> +		return 1;
> +
> +	/*
> +	 * Make sure the branch isn't a sibling call.  Sibling calls aren't
> +	 * "link" branches and they don't return, so they don't need the r2
> +	 * restore afterwards.
> +	 */
> +	if (!instr_is_relative_link_branch(*prev_insn))
>  		return 1;
>
>  	if (*instruction != PPC_INST_NOP) {
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index c9de03e0c1f1..d81aab7441f7 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -304,6 +304,11 @@ int instr_is_relative_branch(unsigned int instr)
>  	return instr_is_branch_iform(instr) || instr_is_branch_bform(instr);
>  }
>
> +int instr_is_relative_link_branch(unsigned int instr)
> +{
> +	return instr_is_relative_branch(instr) && (instr & BRANCH_SET_LINK);
> +}
> +
>  static unsigned long branch_iform_target(const unsigned int *instr)
>  {
>  	signed long imm;
>
