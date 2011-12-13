Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C34081007D3
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 17:03:28 +1100 (EST)
Message-ID: <4EE6EA83.5030905@windriver.com>
Date: Tue, 13 Dec 2011 14:02:43 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] ppc64: fix missing to check all bits of
 _TIF_USER_WORK_MASK in preempt
References: <1323681035-19350-1-git-send-email-tiejun.chen@windriver.com>	
 <4EE6DC33.6090409@windriver.com> <1323755709.19891.60.camel@pasglop>
In-Reply-To: <1323755709.19891.60.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2011-12-13 at 13:01 +0800, tiejun.chen wrote:
>> Tiejun Chen wrote:
>>> In entry_64.S version of ret_from_except_lite, you'll notice that
>>> in the !preempt case, after we've checked MSR_PR we test for any
>>> TIF flag in _TIF_USER_WORK_MASK to decide whether to go to do_work
>>> or not. However, in the preempt case, we do a convoluted trick to
>>> test SIGPENDING only if PR was set and always test NEED_RESCHED ...
>>> but we forget to test any other bit of _TIF_USER_WORK_MASK !!! So
>>> that means that with preempt, we completely fail to test for things
>>> like single step, syscall tracing, etc...
>>>
>>> This should be fixed as the following path:
>>>
>>>  - Test PR. If set, go to test_work_user, else continue.
>>>
>>>  - In test_work_user, always test for _TIF_USER_WORK_MASK to decide to
>>> go to do_work, maybe call it do_user_work
>>>
>>>  - In test_work_kernel, test for _TIF_KERNEL_WORK_MASK which is set to
>>> our new flag along with NEED_RESCHED if preempt is enabled and branch to
>>> do_kernel_work.
>> Ben,
>>
>> Any comment for this?
> 
> Sorry, I didn't get to review that one yet (nor reply to your newer

I'm nothing, please do this when you're fine completely.

Thanks
Tiejun

> responses), I have very sore eyes and basically had to get off the
> computer. Hopefully I'll be better tomorrow.
> 
> Cheers,
> Ben.
