Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 51E802C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2012 20:19:12 +1000 (EST)
Message-ID: <5056F918.9020906@windriver.com>
Date: Mon, 17 Sep 2012 18:19:04 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [v5][PATCH 2/3] powerpc/kprobe: complete kprobe and migrate
 exception frame
References: <1347875671-15838-1-git-send-email-tiejun.chen@windriver.com>
 <1347875671-15838-2-git-send-email-tiejun.chen@windriver.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B6FF1@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6FF1@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/17/2012 06:02 PM, David Laight wrote:
>>   /* N.B. the only way to get here is from the beq following ret_from_except. */
>>   resume_kernel:
>> -	/* check current_thread_info->preempt_count */
>> +	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
>>   	CURRENT_THREAD_INFO(r9, r1)
>> +	lwz	r8,TI_FLAGS(r9)
>> +	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h
>> +	beq+	1f
> ...
>> +1:
>
> Does this add a statically mispredicted branch to every
> return to userspace ?

Return usersapce? No, this is just follow 'resume_kernel'.

Note I add this 'unlikely' here since I assume often Kprobe is always disabled 
by default and especially its also rare to kprobe 'stwu' in many kprobe cases.

Tiejun
