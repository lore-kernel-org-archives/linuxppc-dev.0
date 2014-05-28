Return-Path: <dev@codyps.com>
Received: from mail-la0-x236.google.com (mail-la0-x236.google.com
 [IPv6:2a00:1450:4010:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3433C1A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 08:07:30 +1000 (EST)
Received: by mail-la0-f54.google.com with SMTP id pv20so7630806lab.41
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 15:07:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1401237869.20587.12.camel@joe-AO725>
References: <1401236684-10579-1-git-send-email-dev@codyps.com>
 <1401236684-10579-12-git-send-email-dev@codyps.com>
 <1401237869.20587.12.camel@joe-AO725>
Date: Wed, 28 May 2014 17:07:25 -0500
Message-ID: <CAPoQQ-0Zdva0HiAB9yJ2CWCWtQNvYpfXW7BjNoc0CQ-m=6m3xA@mail.gmail.com>
Subject: Re: [PATCH 11/16] byteorder: provide a linux/byteorder.h with
 {be,le}_to_cpu() and cpu_to_{be,le}() macros
From: Cody P Schafer <dev@codyps.com>
To: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset=UTF-8
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 27, 2014 at 7:44 PM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2014-05-27 at 17:22 -0700, Cody P Schafer wrote:
>> Rather manually specifying the size of the integer to be converted, key
>> off of the type size. Reduces duplicate size info and the occurance of
>> certain types of bugs (using the wrong sized conversion).
> []
>> diff --git a/include/linux/byteorder.h b/include/linux/byteorder.h
> []
>> @@ -0,0 +1,34 @@
>> +#ifndef LINUX_BYTEORDER_H_
>> +#define LINUX_BYTEORDER_H_
>> +
>> +#include <asm/byteorder.h>
>> +
>> +#define be_to_cpu(v) \
>> +     __builtin_choose_expr(sizeof(v) =3D=3D sizeof(uint8_t) , v, \
>> +     __builtin_choose_expr(sizeof(v) =3D=3D sizeof(uint16_t), be16_to_c=
pu(v), \
>> +     __builtin_choose_expr(sizeof(v) =3D=3D sizeof(uint32_t), be32_to_c=
pu(v), \
>> +     __builtin_choose_expr(sizeof(v) =3D=3D sizeof(uint64_t), be64_to_c=
pu(v), \
>> +             (void)0))))
>
> probably better to use BUILD_BUG instead of these 0 returns
>

They aren't 0 returns.

$ echo "int main(void) { int x =3D (void)0; return x; }" | gcc -x c -
<stdin>: In function =E2=80=98main=E2=80=99:
<stdin>:1:26: error: void value not ignored as it ought to be
