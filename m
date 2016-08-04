Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4jkP3YhPzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 18:28:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, wei.guo.simon@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Anton Blanchard <anton@samba.org>,
 Cyril Bur <cyrilbur@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 06/30] powerpc/ptrace: Adapt gpr32_get,
 gpr32_set functions for transaction
In-Reply-To: <877fbxqbvd.fsf@possimpible.ozlabs.ibm.com>
References: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
 <1469674679-8580-7-git-send-email-wei.guo.simon@gmail.com>
 <877fbxqbvd.fsf@possimpible.ozlabs.ibm.com>
Date: Thu, 04 Aug 2016 18:28:09 +1000
Message-ID: <87r3a5ey5i.fsf@concordia.ellerman.id.au>
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

Daniel Axtens <dja@axtens.net> writes:

> [ Unknown signature status ]
> Hi all,
>
> This is causing cppcheck warnings (having just landed in next):
>
> [arch/powerpc/kernel/ptrace.c:2062]: (error) Uninitialized variable: ckpt_regs
> [arch/powerpc/kernel/ptrace.c:2130]: (error) Uninitialized variable: ckpt_regs

Sigh.

> This is from...
>> -static int gpr32_get(struct task_struct *target,
>> +static int gpr32_get_common(struct task_struct *target,
>>  		     const struct user_regset *regset,
>>  		     unsigned int pos, unsigned int count,
>> -		     void *kbuf, void __user *ubuf)
>> +			    void *kbuf, void __user *ubuf, bool tm_active)
>>  {
>>  	const unsigned long *regs = &target->thread.regs->gpr[0];
>> +	const unsigned long *ckpt_regs;
>>  	compat_ulong_t *k = kbuf;
>>  	compat_ulong_t __user *u = ubuf;
>>  	compat_ulong_t reg;
>>  	int i;
>>  
>> -	if (target->thread.regs == NULL)
>> -		return -EIO;
>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>> +	ckpt_regs = &target->thread.ckpt_regs.gpr[0];
>> +#endif
>> +	if (tm_active) {
>> +		regs = ckpt_regs;
> ... this bit here. If the ifdef doesn't trigger, cppcheck can't find an
> initialisation for ckpt_regs, so it complains.
>
> Techinically it's a false positive as (I assume!) tm_active cannot ever
> be true in the absense of CONFIG_PPC_TRANSACTIONAL_MEM.

That's correct, so the code is safe. See the one call site (which passes an int!):

  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
  static int tm_cgpr32_get(struct task_struct *target,
  		     const struct user_regset *regset,
  		     unsigned int pos, unsigned int count,
  		     void *kbuf, void __user *ubuf)
  {
  	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf, 1);
  }

> Is there a nice simple fix we could deploy to squash this warning, or
> will we just live with it?

This series has been nothing but pain. Given we're already at v13, and people
really want this support to go in, I'm going to leave it in the tree.

Once it's in we can refactor the implementation, which is a bit of a mess, and
hopefully in the process fix the warnings.

cheers
