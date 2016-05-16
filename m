Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7ZBx3ZMbzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 18:59:05 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Alan Modra <amodra@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>,  linuxppc-dev@lists.ozlabs.org
Subject: Re: ppc64 sbrk returns executable heap in 32-bit emulation mode
References: <5590cf46-aaa2-451e-f21d-acf5f2eb4928@redhat.com>
 <20160516062425.GA24091__32035.8907142237$1463379977$gmane$org@bubble.grove.modra.org>
Date: Mon, 16 May 2016 10:49:29 +0200
In-Reply-To: <20160516062425.GA24091__32035.8907142237$1463379977$gmane$org@bubble.grove.modra.org>
 (Alan Modra's message of "Mon, 16 May 2016 15:54:25 +0930")
Message-ID: <m21t52xu92.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan Modra <amodra@gmail.com> writes:

> On Thu, May 12, 2016 at 03:41:09PM +0200, Florian Weimer wrote:
>> We noticed that on ppc64, the sbrk system call in the 32-bit subsystem 
>> returns executable memory.  I assume it is related to this, in 
>> arch/powerpc/include/asm/page.h:
>> 
>> /*
>>   * Unfortunately the PLT is in the BSS in the PPC32 ELF ABI,
>>   * and needs to be executable.  This means the whole heap ends
>>   * up being executable.
>>   */
>> #define VM_DATA_DEFAULT_FLAGS32 (VM_READ | VM_WRITE | VM_EXEC | \
>>                                   VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>> 
>> 
>> What is the rationale for this?  This comment must be *really* old, 
>
> I think the comment is just plain wrong.  ppc32 needs an executable
> stack because it builds trampolines on the stack to support calling
> nested functions.  I presume that's why the heap is executable.

The stack and the heap are separate mappings.

>  (If
> I'm wrong about heap+stack needing the same protection then I can't
> think of any reason to require an executable heap.)

The heap and the BSS initially share the same page.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
