Return-Path: <dsafonov@virtuozzo.com>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03on0704.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe09::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCpbg1wsJzDt1j
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 23:32:15 +1100 (AEDT)
Subject: Re: [PATCHv3 1/8] powerpc/vdso: unify return paths in
 setup_additional_pages
To: Michael Ellerman <mpe@ellerman.id.au>, <linux-kernel@vger.kernel.org>
References: <20161027170948.8279-1-dsafonov@virtuozzo.com>
 <20161027170948.8279-2-dsafonov@virtuozzo.com>
 <87mvhaltl5.fsf@concordia.ellerman.id.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov
 <oleg@redhat.com>, <linuxppc-dev@lists.ozlabs.org>, <linux-mm@kvack.org>
From: Dmitry Safonov <dsafonov@virtuozzo.com>
Message-ID: <4fac19b7-aeec-f2b7-02fe-85c219151c3b@virtuozzo.com>
Date: Tue, 8 Nov 2016 15:29:14 +0300
MIME-Version: 1.0
In-Reply-To: <87mvhaltl5.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/08/2016 03:10 AM, Michael Ellerman wrote:
> Hi Dmitry,
>
> Thanks for the patches.
>
> Dmitry Safonov <dsafonov@virtuozzo.com> writes:
>> Impact: cleanup
>
> I'm not a fan of these "Impact" lines, especially when they're not
> correct, ie. this is not a cleanup, a cleanup doesn't change logic.
>
>> Rename `rc' variable which doesn't seems to mean anything into
>> kernel-known `ret'.
>
> 'rc' means "Return Code", it's fairly common. I see at least ~8500
> "int rc" declarations in the kernel.
>
> Please don't rename variables and change logic in one patch.

Ok, right - just didn't saw `rc' that freq as `ret'.
Will leave the name.

>> Combine two function returns into one as it's
>> also easier to read.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-mm@kvack.org
>> Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
>> ---
>>  arch/powerpc/kernel/vdso.c | 19 +++++++------------
>>  1 file changed, 7 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
>> index 4111d30badfa..4ffb82a2d9e9 100644
>> --- a/arch/powerpc/kernel/vdso.c
>> +++ b/arch/powerpc/kernel/vdso.c
>> @@ -154,7 +154,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>>  	struct page **vdso_pagelist;
>>  	unsigned long vdso_pages;
>>  	unsigned long vdso_base;
>> -	int rc;
>> +	int ret = 0;
>
> Please don't initialise return codes in the declaration, it prevents the
> compiler from warning you if you forget to initialise it in a
> particular path.
>
> AFAICS you never even use the default value either.

Oh, right - I split this patch from converting install_special_mapping()
to special vma version _install_special_mapping(), 6/8 patch in series.
Will move initialization to that patch.

>>  	if (!vdso_ready)
>>  		return 0;
>> @@ -203,8 +203,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>>  				      ((VDSO_ALIGNMENT - 1) & PAGE_MASK),
>>  				      0, 0);
>>  	if (IS_ERR_VALUE(vdso_base)) {
>> -		rc = vdso_base;
>> -		goto fail_mmapsem;
>> +		ret = vdso_base;
>> +		goto out_up_mmap_sem;
>>  	}
>>
>>  	/* Add required alignment. */
>> @@ -227,21 +227,16 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>>  	 * It's fine to use that for setting breakpoints in the vDSO code
>>  	 * pages though.
>>  	 */
>> -	rc = install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
>> +	ret = install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
>>  				     VM_READ|VM_EXEC|
>>  				     VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>>  				     vdso_pagelist);
>> -	if (rc) {
>> +	if (ret)
>>  		current->mm->context.vdso_base = 0;
>> -		goto fail_mmapsem;
>> -	}
>> -
>> -	up_write(&mm->mmap_sem);
>> -	return 0;
>>
>> - fail_mmapsem:
>> +out_up_mmap_sem:
>>  	up_write(&mm->mmap_sem);
>> -	return rc;
>> +	return ret;
>>  }
>
>
> If you strip out the variable renames then I think that change would be
> OK.
>
> cheers
>


-- 
              Dmitry
