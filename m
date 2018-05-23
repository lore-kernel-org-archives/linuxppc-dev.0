Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rNh83DBLzDrbm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:00:39 +1000 (AEST)
Subject: Re: [PATCH v7 2/3] powerpc/mm: Only read faulting instruction when
 necessary in do_page_fault()
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1053e5f43a2ea9a9d9abb1f45c88dffb60b9b4fc.1526995927.git.christophe.leroy@c-s.fr>
 <d37d9ce7b925bc254082cd664e37a062131d04b8.1526995927.git.christophe.leroy@c-s.fr>
 <20180523003801.43070ddc@roar.ozlabs.ibm.com>
 <cb0eaf6d-80ab-b503-d797-cadcd60d4c17@c-s.fr>
 <20180523162901.791deea9@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <2214c384-5821-ef5e-d074-ef85b4f7f92d@c-s.fr>
Date: Wed, 23 May 2018 09:00:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180523162901.791deea9@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 23/05/2018 à 08:29, Nicholas Piggin a écrit :
> On Tue, 22 May 2018 16:50:55 +0200
> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> 
>> Le 22/05/2018 à 16:38, Nicholas Piggin a écrit :
>>> On Tue, 22 May 2018 16:02:56 +0200 (CEST)
>>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>    
>>>> Commit a7a9dcd882a67 ("powerpc: Avoid taking a data miss on every
>>>> userspace instruction miss") has shown that limiting the read of
>>>> faulting instruction to likely cases improves performance.
>>>>
>>>> This patch goes further into this direction by limiting the read
>>>> of the faulting instruction to the only cases where it is likely
>>>> needed.
>>>>
>>>> On an MPC885, with the same benchmark app as in the commit referred
>>>> above, we see a reduction of about 3900 dTLB misses (approx 3%):
>>>>
>>>> Before the patch:
>>>>    Performance counter stats for './fault 500' (10 runs):
>>>>
>>>>            683033312      cpu-cycles                                                    ( +-  0.03% )
>>>>               134538      dTLB-load-misses                                              ( +-  0.03% )
>>>>                46099      iTLB-load-misses                                              ( +-  0.02% )
>>>>                19681      faults                                                        ( +-  0.02% )
>>>>
>>>>          5.389747878 seconds time elapsed                                          ( +-  0.06% )
>>>>
>>>> With the patch:
>>>>
>>>>    Performance counter stats for './fault 500' (10 runs):
>>>>
>>>>            682112862      cpu-cycles                                                    ( +-  0.03% )
>>>>               130619      dTLB-load-misses                                              ( +-  0.03% )
>>>>                46073      iTLB-load-misses                                              ( +-  0.05% )
>>>>                19681      faults                                                        ( +-  0.01% )
>>>>
>>>>          5.381342641 seconds time elapsed                                          ( +-  0.07% )
>>>>
>>>> The proper work of the huge stack expansion was tested with the
>>>> following app:
>>>>
>>>> int main(int argc, char **argv)
>>>> {
>>>> 	char buf[1024 * 1025];
>>>>
>>>> 	sprintf(buf, "Hello world !\n");
>>>> 	printf(buf);
>>>>
>>>> 	exit(0);
>>>> }
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> ---
>>>>    v7: Following comment from Nicholas on v6 on possibility of the page getting removed from the pagetables
>>>>        between the fault and the read, I have reworked the patch in order to do the get_user() in
>>>>        __do_page_fault() directly in order to reduce complexity compared to version v5
>>>
>>> This is looking better, thanks.
>>>    
>>>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>>>> index fcbb34431da2..dc64b8e06477 100644
>>>> --- a/arch/powerpc/mm/fault.c
>>>> +++ b/arch/powerpc/mm/fault.c
>>>> @@ -450,9 +450,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>>>>    	 * can result in fault, which will cause a deadlock when called with
>>>>    	 * mmap_sem held
>>>>    	 */
>>>> -	if (is_write && is_user)
>>>> -		get_user(inst, (unsigned int __user *)regs->nip);
>>>> -
>>>>    	if (is_user)
>>>>    		flags |= FAULT_FLAG_USER;
>>>>    	if (is_write)
>>>> @@ -498,6 +495,26 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>>>>    	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>>>>    		return bad_area(regs, address);
>>>>    
>>>> +	if (unlikely(is_write && is_user && address + 0x100000 < vma->vm_end &&
>>>> +		     !inst)) {
>>>> +		unsigned int __user *nip = (unsigned int __user *)regs->nip;
>>>> +
>>>> +		if (likely(access_ok(VERIFY_READ, nip, sizeof(inst)))) {
>>>> +			int res;
>>>> +
>>>> +			pagefault_disable();
>>>> +			res = __get_user_inatomic(inst, nip);
>>>> +			pagefault_enable();
>>>> +			if (unlikely(res)) {
>>>> +				up_read(&mm->mmap_sem);
>>>> +				res = __get_user(inst, nip);
>>>> +				if (!res && inst)
>>>> +					goto retry;
>>>
>>> You're handling error here but the previous code did not?
>>
>> The previous code did in store_updates_sp()
>>
>> When I moved get_user() out of that function in preceeding patch, I did
>> consider that if get_user() fails, inst will remain 0, which means that
>> store_updates_sp() will return false if ever called.
> 
> Well it handles it just by saying no the store does not update SP.
> Yours now segfaults it, doesn't it?

Yes it segfaults the same way as before, as it tell the expansion is bad.

> 
> I don't think that's a bad idea, I think it should go in a patch by
> itself though. In theory we can have execute but not read, I guess
> that's not really going to work here either way and I don't know if
> Linux exposes it ever.

I don't understand what you mean, that's not different from before, is it ?

> 
>>
>> Now, as the semaphore has been released, we really need to do something,
>> because if we goto retry inconditionally, we may end up in an infinite
>> loop, and we can't let it continue either as the semaphore is not held
>> anymore.
>>
>>>    
>>>> +				return bad_area_nosemaphore(regs, address);
>>>> +			}
>>>> +		}
>>>> +	}
>>>
>>> Would it be nicer to move all this up into bad_stack_expansion().
>>> It would need a way to handle the retry and insn, but I think it
>>> would still look better.
>>
>> That's what I did in v5 indeed, but it looked too complex to me at the
>> end. Can you have a look at it
>> (https://patchwork.ozlabs.org/patch/799053/) and tell me if you feel it
>> better than v7, or if you have any suggestion to improve based on v5
>> and/or v7 ?
> 
> Yeah I'm kind of liking that direction a bit more. I took your code
> and hacked on it a bit more... Completely untested but I wonder what
> you think?
> 
> We can put almost all the checking logic out of the main fault
> path, and the retry stuff can fit into the unlikely failure
> path. Also we only get_user at the last minute.
> 
> It does use fault_in_pages_readable which in theory means you might
> repeat the loop if the page gets faulted out between retry, but that
> same pattern exists in places in the filesystem code. Basically it
> would be edge case trashing and if it persists then the system is
> already finished. So I think it's okay. Just makes the retry loop a
> bit simpler.
> 
> Any thoughts?

Indeed, after writing you I looked at it once more and I think I ended 
up with something rather similar as what you are proposing here.
The complexity in v5 was because I left the get_user() in 
store_updates_sp(). By moving it up into bad_stack_expansion(), it looks 
better.
The main difference I see between your proposal and my v8 is that I do 
the up_read() in bad_stack_expansion(). Maybe that's not a good idea.

I'll release it in a few minutes, let me know what you think about it.

Thanks,
Christophe

> 
> Thanks,
> Nick
> 
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index c01d627e687a..f0d36ec949b3 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -69,12 +69,8 @@ static inline bool notify_page_fault(struct pt_regs *regs)
>    * Check whether the instruction at regs->nip is a store using
>    * an update addressing form which will update r1.
>    */
> -static bool store_updates_sp(struct pt_regs *regs)
> +static bool store_updates_sp(unsigned int inst)
>   {
> -	unsigned int inst;
> -
> -	if (get_user(inst, (unsigned int __user *)regs->nip))
> -		return false;
>   	/* check for 1 in the rA field */
>   	if (((inst >> 16) & 0x1f) != 1)
>   		return false;
> @@ -233,10 +229,23 @@ static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
>   	return is_exec || (address >= TASK_SIZE);
>   }
>   
> -static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
> +static bool bad_stack_expand(struct pt_regs *regs, unsigned long address,
>   				struct vm_area_struct *vma,
> -				bool store_update_sp)
> +				bool *retry)
>   {
> +	unsigned int __user *nip = (unsigned int __user *)regs->nip;
> +	struct pt_regs *uregs = current->thread.regs;
> +	unsigned int inst;
> +	int res;
> +
> +	/*
> +	 * We want to do this outside mmap_sem, because reading code around nip
> +	 * can result in fault, which will cause a deadlock when called with
> +	 * mmap_sem held
> +	 */
> +	if (is_write && is_user)
> +		store_update_sp = store_updates_sp(regs);
> +
>   	/*
>   	 * N.B. The POWER/Open ABI allows programs to access up to
>   	 * 288 bytes below the stack pointer.
> @@ -246,26 +255,46 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
>   	 * before setting the user r1.  Thus we allow the stack to
>   	 * expand to 1MB without further checks.
>   	 */
> -	if (address + 0x100000 < vma->vm_end) {
> -		/* get user regs even if this fault is in kernel mode */
> -		struct pt_regs *uregs = current->thread.regs;
> -		if (uregs == NULL)
> -			return true;
> +	if (address + 0x100000 >= vma->vm_end)
> +		return false;
>   
> -		/*
> -		 * A user-mode access to an address a long way below
> -		 * the stack pointer is only valid if the instruction
> -		 * is one which would update the stack pointer to the
> -		 * address accessed if the instruction completed,
> -		 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
> -		 * (or the byte, halfword, float or double forms).
> -		 *
> -		 * If we don't check this then any write to the area
> -		 * between the last mapped region and the stack will
> -		 * expand the stack rather than segfaulting.
> -		 */
> -		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
> -			return true;
> +	/* get user regs even if this fault is in kernel mode */
> +	if (unlikely(uregs == NULL)) {
> +		*must_retry = false;
> +		return true;
> +	}
> +
> +	/*
> +	 * A user-mode access to an address a long way below
> +	 * the stack pointer is only valid if the instruction
> +	 * is one which would update the stack pointer to the
> +	 * address accessed if the instruction completed,
> +	 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
> +	 * (or the byte, halfword, float or double forms).
> +	 *
> +	 * If we don't check this then any write to the area
> +	 * between the last mapped region and the stack will
> +	 * expand the stack rather than segfaulting.
> +	 */
> +	if (address + 2048 >= uregs->gpr[1])
> +		return false;
> +
> +	if (unlikely(!access_ok(VERIFY_READ, nip, sizeof(inst)))) {
> +		*must_retry = true;
> +		return true;
> +	}
> +
> +	pagefault_disable();
> +	res = __get_user_inatomic(inst, nip);
> +	pagefault_enable();
> +	if (unlikely(res)) {
> +		*must_retry = true;
> +		return true;
> +	}
> +
> +	if (!store_updates_sp(inst)) {
> +		*must_retry = true;
> +		return true;
>   	}
>   	return false;
>   }
> @@ -403,7 +432,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>   	int is_user = user_mode(regs);
>   	int is_write = page_fault_is_write(error_code);
>   	int fault, major = 0;
> -	bool store_update_sp = false;
> +	bool must_retry;
>   
>   	if (notify_page_fault(regs))
>   		return 0;
> @@ -449,14 +478,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>   		return bad_key_fault_exception(regs, address,
>   					       get_mm_addr_key(mm, address));
>   
> -	/*
> -	 * We want to do this outside mmap_sem, because reading code around nip
> -	 * can result in fault, which will cause a deadlock when called with
> -	 * mmap_sem held
> -	 */
> -	if (is_write && is_user)
> -		store_update_sp = store_updates_sp(regs);
> -
>   	if (is_user)
>   		flags |= FAULT_FLAG_USER;
>   	if (is_write)
> @@ -503,8 +524,17 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>   		return bad_area(regs, address);
>   
>   	/* The stack is being expanded, check if it's valid */
> -	if (unlikely(bad_stack_expansion(regs, address, vma, store_update_sp)))
> +	if (unlikely(bad_stack_expand(regs, address, vma, &must_retry))) {
> +		if (must_retry) {
> +			up_read(&mm->mmap_sem);
> +			if (fault_in_pages_readable(address, sizeof(unsigned int)))
> +				return bad_area_nosemaphore(regs, address);
> +			goto retry;
> +		}
> +
>   		return bad_area(regs, address);
> +	}
> +
>   
>   	/* Try to expand it */
>   	if (unlikely(expand_stack(vma, address)))
> 
