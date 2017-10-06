Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7f7T6NprzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 16:57:57 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v965sGsX012522
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 01:57:54 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ddx0p7m3t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Oct 2017 01:57:54 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 15:57:51 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v965voSZ50331840
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 16:57:50 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v965vnBN025003
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 16:57:50 +1100
Subject: Re: [PATCH v2] kernel/module_64.c: Add REL24 relocation support of
 livepatch symbols
To: Torsten Duwe <duwe@lst.de>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
 <20171005124313.GA25100@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Fri, 6 Oct 2017 11:27:42 +0530
MIME-Version: 1.0
In-Reply-To: <20171005124313.GA25100@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 05 October 2017 06:13 PM, Torsten Duwe wrote:
> On Wed, Oct 04, 2017 at 11:25:16AM -0400, Kamalesh Babulal wrote:
>>
>> Both the failures with REL24 livepatch symbols relocation, can be
>> resolved by constructing a new livepatch stub. The newly setup klp_stub
>> mimics the functionality of entry_64.S::livepatch_handler introduced by
>> commit 85baa095497f ("powerpc/livepatch: Add live patching support on
>> ppc64le").
>
> So, do I get his right that this patch is based on your June 13 proposal
> "powerpc/modules: Introduce new stub code for SHN_LIVEPATCH symbols" ?
> I guess you lost many of us already at that point. What is the new, much
> bigger stub code needed for? Stub code should do only the very bare minimum,
> all common functionality is handled in the kernel main object.
>
> What exactly is the problem you're trying to solve, what is to be achieved?

Resending the reply, sorry about the word wrapping in the previous mail.

Thanks for the review.

With apply_relocate_add() writing out relocations for livepatch symbols
too. R_PPC_REL24: Doesn't handle SHN_LIVEPATCH symbols and ends up
being treated as local symbol and calls local_entry_offset(). Which
triggers an error:

module_64: kpatch_meminfo: REL24 -1152921504897399800 out of range!

Whereas SHN_LIVEPATCH symbols are essentially SHN_UNDEF, should be
called via external stub. This issue can be fixed by handling both
SHN_UNDEF and SHN_LIVEPATCH via same external stub. It isn't a complete
fix, because it will fail with local calls becoming global.

Consider the livepatch sequence[1]. Where function A calls B, B is the
function which has been livepatched and the call to function B is
redirected to patched version P. P calls the function C in M2, whereas
C was local to the function B and have became SHN_UNDEF in function P.
Local call becoming global.

   +--------+            +--------+    +--------+      +--------+
   |        |   +--------+--------+--->|        |  +-->|        |
   |  A     |   |        |  B     |    |  F     |  |   |  P     |
   |        |   |        |        |    |        +--+   |        |
   |        +---+        |        |    |        |<-+   |        |
   |        |<--+   +----+   C    |    |        |  |   |        |
   |        |   |   | +->|        |    |        |  |   |        |<---+
   | K / M1 |   |   | |  | K / M2 |  +-+ Kernel |  +---+ Mod3   +--+ |
   +--------+   |   | |  +--------+  | +--------+      +--------+  | |
                |   | |              |                             | |
                +---+-+--------------+                             | |
                    | |                                            | |
                    | +--------------------------------------------+ |
                    +------------------------------------------------+


Handling such call with regular stub, triggers another error:

module_64: kpatch_meminfo: Expect noop after relocate, got 3d220000

Every branch to SHN_UNDEF is followed by a nop instruction, that gets
overwritten by an instruction to restore TOC with r2 value that get
stored onto the stack, before calling the function via global entry
point.

Given that C was local to function B, it does not store/restore TOC as
they are not expected to be clobbered for functions called via local
entry point.

Current stub can be extended to re-store TOC and have a single stub for
both SHN_UNDEF/SHN_LIVEPATCH symbols. Constructing a single stub is an
overhead for non livepatch calla, as it adds extra instructions for TOC
restore.

Idea was to create a new stub for SHN_LIVEPATCH symbols. Which would
also restore the TOC on the return to livepatched function, by
introducing an intermediate stack between function P and function C.
This was the earlier proposal made in June.

It will work for most of the cases but will not work, when arguments to
C as passes through stack. This issue has been already solved by
introduction of livepatch_handler, which runs in _mcount context by
creating a livepatch stack to store/restore TOC/LR. It avoids the need
for an intermediate stack.

Current approach, creates a hybrid stub. Which is a combination of
regular stub (stub setup code) +  livepatch_handler (stores/restores
TOC/LR with livepatch stack).

>
>> +
>> +	/*
>> +	 * Patch the code required to load the trampoline address into r11,
>> +	 * function global entry point into r12, ctr.
>> +	 */
>> +	entry->jump[klp_stub_idx++] = (PPC_INST_ADDIS | ___PPC_RT(11) |
>> +					___PPC_RA(2) | PPC_HA(reladdr));
>> +
>> +	entry->jump[klp_stub_idx++] = (PPC_INST_ADDI | ___PPC_RT(11) |
>> +					 ___PPC_RA(11) | PPC_LO(reladdr));
>> +
>> +	entry->jump[klp_stub_idx++] = (PPC_INST_LD | ___PPC_RT(12) |
>> +					 ___PPC_RA(11) | 128);
> 							 ^^^
> Also, I was a bit puzzled by this constant, BTW.
> Can you #define a meaning to this, perhaps?

Naveen too pointed it out. Will introduce a define for the offset.

>
>> @@ -201,8 +204,33 @@ livepatch_handler:
>>  	ori     r12, r12, STACK_END_MAGIC@l
>>  	std	r12, -8(r11)
>>
>> +	/*
>> +	 * klp_stub_insn/klp_stub_insn_end marks the beginning/end of the
>> +	 * additional instructions, which gets patched by create_klp_stub()
>> +	 * for livepatch symbol relocation stub. The instructions are:
>> +	 *
>> +	 * Load TOC relative address into r11. module_64.c::klp_stub_for_addr()
>> +	 * identifies the available free stub slot and loads the address into
>> +	 * r11 with two instructions.
>> +	 *
>> +	 * addis r11, r2, stub_address@ha
>> +	 * addi  r11, r11, stub_address@l
>> +	 *
>> +	 * Load global entry into r12 from entry->funcdata offset
>> +	 * ld    r12, 128(r11)
>
> Is that the same 128 as above? Then it should definitely be a #define to
> avoid inconsistencies.
>

Yes, it's the same offset as above in the comments.

[1] ASCII diagram adopted from:
http://mpe.github.io/posts/2016/05/23/kernel-live-patching-for-ppc64le/


-- 
cheers,
Kamalesh.
