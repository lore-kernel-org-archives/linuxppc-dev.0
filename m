Return-Path: <kernelfans@gmail.com>
Received: from mail-yh0-x22e.google.com (mail-yh0-x22e.google.com
 [IPv6:2607:f8b0:4002:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C08CA2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 17:06:22 +1100 (EST)
Received: by mail-yh0-f46.google.com with SMTP id v1so470142yhn.19
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 22:06:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140226043552.GA14672@in.ibm.com>
References: <1393381381-30179-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <20140226043552.GA14672@in.ibm.com>
Date: Wed, 26 Feb 2014 14:06:17 +0800
Message-ID: <CAFgQCTtH-V2xNDDG_5E51r4jWmyvwz0uDpYhunUVLuN5MC792A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: ftrace: bugfix for test_24bit_addr
From: Liu ping fan <kernelfans@gmail.com>
To: ananth@in.ibm.com
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 26, 2014 at 12:35 PM, Ananth N Mavinakayanahalli
<ananth@in.ibm.com> wrote:
> On Wed, Feb 26, 2014 at 10:23:01AM +0800, Liu Ping Fan wrote:
>> The branch target should be the func addr, not the addr of func_descr_t.
>> So using ppc_function_entry() to generate the right target addr.
>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>> ---
>> This bug will make ftrace fail to work. It can be triggered when the kernel
>> size grows up.
>> ---
>>  arch/powerpc/kernel/ftrace.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
>> index 9b27b29..b0ded97 100644
>> --- a/arch/powerpc/kernel/ftrace.c
>> +++ b/arch/powerpc/kernel/ftrace.c
>> @@ -74,6 +74,7 @@ ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
>>   */
>>  static int test_24bit_addr(unsigned long ip, unsigned long addr)
>>  {
>> +     addr = ppc_function_entry((void *)addr);
>
> Won't this break on LE?
>
How? I can not figure out it. Anyway, ppc_function_entry() is already
used in other places with LE.

Thx,
Fan
