Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id 5791414007F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 15:39:40 +1000 (EST)
Message-ID: <53705E93.803@roeck-us.net>
Date: Sun, 11 May 2014 22:39:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix "attempt to move .org backwards" error
 (again)
References: <1399680478-4970-1-git-send-email-linux@roeck-us.net>	
 <1399867920.17624.73.camel@pasglop> <1399873020.17624.79.camel@pasglop>
In-Reply-To: <1399873020.17624.79.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2014 10:37 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2014-05-12 at 14:12 +1000, Benjamin Herrenschmidt wrote:
>> On Fri, 2014-05-09 at 17:07 -0700, Guenter Roeck wrote:
>>> Commit 4e243b7 (powerpc: Fix "attempt to move .org backwards" error) fixes the
>>> allyesconfig build by moving machine_check_common to a different location.
>>> While this fixes most of the errors, both allmodconfig and allyesconfig still
>>> fail as follows.
>>>
>>> arch/powerpc/kernel/exceptions-64s.S:1315: Error: attempt to move .org backwards
>>>
>>> Fix by moving machine_check_common after the offending address.
>>
>> This suffers from the same problem as previous attempts, on some of my
>> test configs I get:
>>
>> arch/powerpc/kernel/head_64.o:(__ftr_alt_97+0xb0): relocation truncated to fit: R_PPC64_REL14 against `.text'+1c90
>> make[1]: *** [vmlinux] Error 1
>> make: *** [sub-make] Error 2
>>
>> IE, it breaks currently working configs.
>>
>> So we need to move more things around and I haven't had a chance to
>> sort it out.
>
> Ok, I think I sorted it out for now. It's a mess and likely to break
> again until we do something more drastic like moving everything that's
> after 0x8000 to a separate file but for now that will do. Patch on its
> way, I'll also shoot it to Linus today along with a few other things.
>

Great, thanks a lot!

Guenter
