Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7Z2R1l2KzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 18:51:42 +1000 (AEST)
Subject: Re: ppc64 sbrk returns executable heap in 32-bit emulation mode
To: Alan Modra <amodra@gmail.com>
References: <5590cf46-aaa2-451e-f21d-acf5f2eb4928@redhat.com>
 <20160516062425.GA24091@bubble.grove.modra.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <998d04cd-6653-7029-51a6-2540ec7dd798@redhat.com>
Date: Mon, 16 May 2016 10:51:38 +0200
MIME-Version: 1.0
In-Reply-To: <20160516062425.GA24091@bubble.grove.modra.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2016 08:24 AM, Alan Modra wrote:
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
> nested functions.  I presume that's why the heap is executable.  (If
> I'm wrong about heap+stack needing the same protection then I can't
> think of any reason to require an executable heap.)

But the stack is *not* executable.  The program is marked correctly with 
GNU_STACK:

   GNU_STACK      0x000000 0x00000000 0x00000000 0x000000 0x000000 RW  0x10

If this program header were not there (or said RWX instead of RW), then 
I expect the kernel would make the stack executable, for backwards 
compatibility.

And the test reports this:

# Subtests with executable mappings or inconsistent results
        exec  MAP_ANONYMOUS with R|W, then mprotect R|X
        exec  MAP_ANONYMOUS with R|X, then mprotect R|W, mprotect R|X
   FAIL exec  malloc (small) (unexpected result)
   FAIL exec  malloc (page size) (unexpected result)
        exec  MAP_ANONYMOUS, with PROT_EXEC, without mprotect
        exec  file with MAP_PRIVATE, with PROT_EXEC, without mprotect, 
without alias
        exec  file with MAP_SHARED, with PROT_EXEC, without mprotect, 
without alias
        exec  shared memory with MAP_PRIVATE, with PROT_EXEC, without 
mprotect, without alias
        exec  shared memory with MAP_SHARED, with PROT_EXEC, without 
mprotect, without alias
        exec  file with MAP_SHARED, with PROT_EXEC, without mprotect, 
with alias
        exec  shared memory with MAP_SHARED, with PROT_EXEC, without 
mprotect, with alias
        exec  MAP_ANONYMOUS, with PROT_EXEC, with mprotect
        exec  file with MAP_PRIVATE, with PROT_EXEC, with mprotect, 
without alias
        exec  file with MAP_SHARED, with PROT_EXEC, with mprotect, 
without alias
        exec  shared memory with MAP_PRIVATE, with PROT_EXEC, with 
mprotect, without alias
        exec  shared memory with MAP_SHARED, with PROT_EXEC, with 
mprotect, without alias
        exec  file with MAP_SHARED, with PROT_EXEC, with mprotect, with 
alias
        exec  shared memory with MAP_SHARED, with PROT_EXEC, with 
mprotect, with alias

(Sorry for the line wrapping, also available at 
<https://paste.fedoraproject.org/367036/>.)

The tests I'm using are these: <https://pagure.io/execmod-tests>  It 
also covers the stack, but it is not listed in the summary because it is 
not executable.

Only the heap is executable.  Everything else is set up as expected by 
the kernel or by glibc.

Florian
