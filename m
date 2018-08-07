Return-Path: <breno.debian@gmail.com>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lNfD38J7zDqgF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 04:41:55 +1000 (AEST)
Received: by mail-qt0-f196.google.com with SMTP id f18-v6so19038374qtp.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Aug 2018 11:41:55 -0700 (PDT)
Subject: Re: [PATCH v2] powerpc/tm: Print 64-bits MSR
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
References: <5b85006b6695bd94f4818357be607036e9df8696.camel@neuling.org>
 <1533648900-7933-1-git-send-email-leitao@debian.org>
 <95db63eb-6fb7-eed3-1ce8-8b2c053dff47@c-s.fr>
From: Breno Leitao <leitao@debian.org>
Message-ID: <c5be0bf4-de2c-6fe4-3192-f48aade9506b@debian.org>
Date: Tue, 7 Aug 2018 15:41:47 -0300
MIME-Version: 1.0
In-Reply-To: <95db63eb-6fb7-eed3-1ce8-8b2c053dff47@c-s.fr>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 08/07/2018 02:15 PM, Christophe LEROY wrote:
> Le 07/08/2018 à 15:35, Breno Leitao a écrit :
>> On a kernel TM Bad thing program exception, the Machine State Register
>> (MSR) is not being properly displayed. The exception code dumps a 32-bits
>> value but MSR is a 64 bits register for all platforms that have HTM
>> enabled.
>>
>> This patch dumps the MSR value as a 64-bits value instead of 32 bits. In
>> order to do so, the 'reason' variable could not be used, since it trimmed
>> MSR to 32-bits (int).
> 
> reason is not always regs->msr, see get_reason(), allthough in your case it is.
> 
> I think it would be better to change 'reason' to 'unsigned long' instead of
> replacing it by regs->msr for the printk.

That was my initial approach, but this code seems to run on 32 bits system,
and I do not want to change the whole 'reason' bit width without having a 32
bits to test, at least.

Also, it is a bit weird doing something as:

	printk("....(msr 0x%lx)....", reason);

I personally think that the follow code is much more readable:

	printk(".... (msr 0x%lx)...", regs->msr);
