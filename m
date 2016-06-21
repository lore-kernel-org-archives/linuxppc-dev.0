Return-Path: <chris@distroguy.com>
Received: from mx-out03.mykolab.com (unknown [95.128.36.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTPm536CzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:39:23 +1000 (AEST)
Received: from mx03.mykolab.com (mx03.mykolab.com [10.20.7.101])
 by mx-out03.mykolab.com (Postfix) with ESMTPS id D978321906
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 02:39:16 +0200 (CEST)
Date: Tue, 21 Jun 2016 10:39:10 +1000
From: Chris Smart <chris@distroguy.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [Patch v2 1/2] powerpc: Send SIGBUS on unaligned copy and paste
Message-ID: <20160621003909.GA11166@distroguy.com>
References: <20160616233340.GA14449@distroguy.com>
 <20160617040412.GC25170@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <20160617040412.GC25170@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 16, 2016 at 11:04:12PM -0500, Segher Boessenkool wrote:
>On Fri, Jun 17, 2016 at 09:33:45AM +1000, Chris Smart wrote:
>> +#define PPC_INST_COPY			0x7c00060c
>> +#define PPC_INST_COPY_FIRST		0x7c20060c
>
>> +#define PPC_INST_PASTE			0x7c00070c
>> +#define PPC_INST_PASTE_LAST		0x7c20070d
>
>That's not quite right I think.
>

Hi Segher,

Thanks for checking that for me, it's good to make sure it's correct.

Just to be sure, I've gone back and compared them all with the ISA. I
think that the only one that differs is the paste_last. Am I missing
something?

>copy is       7c00060c mask fc2007fe (or ffe007fe)

COPY = copy RA,RB,L (L=0)

  31   //// L  RA    RB      774     /
011111 0000 0 00000 00000 1100000110 0 = 0x7c00060c (instruction)
111111 0000 1 00000 00000 1111111111 0 = 0xfc2007fe (specific mask)

>copy_first is 7c20060c mask fc2007fe

COPY_FIRST = copy RA,RB,L (L=1)
If L=1, the instruction identifies the beginning of a move group.

  31   //// L   RA   RB      774     /
011111 0000 1 00000 00000 1100000110 0 = 0x7c20060c (instruction)
111111 0000 1 00000 00000 1111111111 0 = 0xfc2007fe (specific mask)

>paste is      7c00070c mask fc2007fe

PASTE = paste RA,RB,L (L=0 Rc=0)

  31   //// L  RA    RB      902     Rc
011111 0000 0 00000 00000 1110000110 0 = 0x7c00070c (instruction)
111111 0000 1 00000 00000 1111111111 1 = 0xfc2007ff (specific mask)

>paste_last is 7c20070c mask fc2007fe
>

PASTE_LAST = paste. RA,RB,L (L=1 Rc=1)
If L=1, the instruction identifies the end of a move group.
If L≠Rc, the instruction form is invalid.

  31   //// L  RA    RB      902     Rc
011111 0000 1 00000 00000 1110000110 1 = 0x7c20070d (instruction)
111111 0000 1 00000 00000 1111111111 1 = 0xfc2007ff (specific mask)

>(this includes record form for paste; the low bit).
>

To make the test simple I use a combined copy, copy_first, paste and
paste_last mask to compare just against copy. So that excluded:
 - L
 - bit 24 of 32
 - Rc
111111 0000 0 00000 00000 1101111111 0 = 0xfc0006fe

Would it be better and more clear to check each instruction with its
mask? Something like:

#define PPC_INST_COPY_MASK 0xfc2007fe
#define PPC_INST_PASTE_MASK 0xfc2007ff

if (cpu_has_feature(CPU_FTR_ARCH_300)) {
	unsigned int masked_instruction = instruction & PPC_INST_COPY_MASK;

	if (masked_instruction == PPC_INST_COPY || \
			masked_instruction == PPC_INST_COPY_FIRST)
		return -EIO;

	masked_instruction = instruction & PPC_INST_PASTE_MASK;

	if (masked_instruction == PPC_INST_PASTE || \
			masked_instruction == PPC_INST_PASTE_LAST)
		return -EIO;
}

Thanks!
-c
