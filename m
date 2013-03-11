Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 20CAE2C02AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2013 21:14:46 +1100 (EST)
Message-ID: <513DAE85.9010603@windriver.com>
Date: Mon, 11 Mar 2013 18:14:29 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Alex Grad <alex.grad@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH]->[PATCH v2] kgdb: Removed kmalloc returned value cast
References: <1362955188-3023-1-git-send-email-alex.grad@gmail.com>
 <513D346E.20009@windriver.com>
In-Reply-To: <513D346E.20009@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: sfr@canb.auug.org.au, mikey@neuling.org, daniel.baluta@gmail.com,
 linux-kernel@vger.kernel.org, penberg@kernel.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/11/2013 09:33 AM, tiejun.chen wrote:
> On 03/11/2013 06:39 AM, Alex Grad wrote:
>> While at it, check kmalloc return value.
>>
>> Signed-off-by: Alex Grad <alex.grad@gmail.com>
>> ---
>>   arch/powerpc/kernel/kgdb.c |    5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
>> index 5ca82cd..9e81dd8 100644
>> --- a/arch/powerpc/kernel/kgdb.c
>> +++ b/arch/powerpc/kernel/kgdb.c
>> @@ -159,7 +159,10 @@ static int kgdb_singlestep(struct pt_regs *regs)
>>       if (user_mode(regs))
>>           return 0;
>>
>> -    backup_current_thread_info = (struct thread_info *)kmalloc(sizeof(struct
>> thread_info), GFP_KERNEL);
>> +    backup_current_thread_info = kmalloc(sizeof(struct thread_info),
>> GFP_KERNEL);
>> +    if (!backup_current_thread_info)
>> +        return -ENOMEM;
>
> I already send a kgdb patchset in "[v3][PATCH 6/6] powerpc/kgdb: remove copying
> the thread_info" to remove these stuff since its unnecessary to copy current
> thread_info now.

I guess that patchset needs to be reviewed with more time and I also think I can 
leave this copying to be compatible for other platforms in the future, but we 
really should fix this problem I introduced right now. So I'd like to fix this 
with DEFINE_PER_CPU.

I send a patch, "powerpc/kgdb: use DEFINE_PER_CPU to allocate kgdb's 
thread_info", so please take a look at if that version is fine to every one.

Any comments are appreciated.

BTW, I will update that kgdb patchset with this change to resend.

Tiejun
