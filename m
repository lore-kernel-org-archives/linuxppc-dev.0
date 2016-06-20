Return-Path: <kda@linux-powerpc.org>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rY2GB33LwzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 17:16:17 +1000 (AEST)
Received: by mail-yw0-x242.google.com with SMTP id i12so614559ywa.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 00:16:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1466292111.24271.89.camel@kernel.crashing.org>
References: <1466274479-5650-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1466292111.24271.89.camel@kernel.crashing.org>
Date: Mon, 20 Jun 2016 10:16:14 +0300
Message-ID: <CAOJe8K2D3e6EKZr3JYubaC2_eryu94qvvhbZh=qP9pGy+ZJJdg@mail.gmail.com>
Subject: Re: [PATCH V2] powerpc/mm: Don't do debug print before we do feature
 fixup
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/19/16, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Sat, 2016-06-18 at 23:57 +0530, Aneesh Kumar K.V wrote:
>> We use feature fixup in segment and page fault path and hence we should
>> not call any function that can cause either of these before we finish
>> feature fixup.
>>
>> Calling into early debug routine can result in segment fault as updated
>> in
>> https://lkml.kernel.org/r/CAOJe8K2L8D1M_yZPmyiZ11JvJ+HAS0aFHOnsqaY=xLOnQTA3AA@mail.gmail.com
>>
>> Avoid the segment fault by removing the debug print. Also remove the
>> matching closing debug print at the end of the function.
>
> Please add a comment at the beginning of setup_system() explaining
> the situation. IE, that until the fixups are done, not even debug
> printfs can be used.
>
Right, otherwise we'll hit the same issue in the future.

> It used to work though, the fact that we used 256M segment in that
> case wasn't an issue, in part because btext only really existed on
> machines that didn't have 1T segments. It was only ever going to be
> a segment fault, the rest was bolted (early ioremap).
>
> Ben.
>
>
