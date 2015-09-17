Return-Path: <peter.senna@gmail.com>
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com
 [IPv6:2a00:1450:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 844FC1A0274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 19:58:58 +1000 (AEST)
Received: by wiclk2 with SMTP id lk2so16443677wic.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 02:58:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1442483254.26748.5.camel@ellerman.id.au>
References: <1442481536-11088-1-git-send-email-peter.senna@gmail.com>
 <1442483254.26748.5.camel@ellerman.id.au>
Date: Thu, 17 Sep 2015 11:58:54 +0200
Message-ID: <CA+MoWDraY5XjJu7V+LL4L4OgovyNPEJiuvzZb2C-xZtF8UEUnw@mail.gmail.com>
Subject: Re: [PATCH] arch-powerpc: Return false instead of -EFAULT
From: Peter Senna Tschudin <peter.senna@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 17, 2015 at 11:47 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Thu, 2015-09-17 at 11:18 +0200, Peter Senna Tschudin wrote:
>> Returning a negative value for a boolean function seem to have the
>> undesired effect of returning true. Replace -EINVAL by false in a
>> bool-returning function.
>>
>> The diff of the .s file before and after the change (using cross
>> compilation) starts with:
>>
>> 440,441c440,441
>> < .L43:
>> <     li 3,1   # D.25775,
>> ---
>> > .L42:
>> >     li 3,0   # D.25775,
>> ...
>>
>> while if -EFAULT is replaced by true, the diff is empty.
>
> Ah, that's rather unfortunate.
>
> Can you post the full asm listing, for all three cases?
Sure, but it would be 3 files of 70kb each. You can download them form:

http://petersenna.com/files/module_64.s.tar.xz

Let me know if this download method doesn't work for you.

module_64.s: Original file.
module_64-patched.s: With my patch
module_64-true.s: Changing -EFAULT by true

files were made with:
$ make arch/powerpc/kernel/module_64.s

using:
gcc-powerpc64-linux-gnu-4.9.2-5.fc21.x86_64

>
> cheers
>
>



-- 
Peter
