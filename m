Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id 6EAD71A04C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 02:25:12 +1000 (EST)
Message-ID: <53E8EE64.8020607@roeck-us.net>
Date: Mon, 11 Aug 2014 09:25:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: Fix "attempt to move .org backwards" error
References: <1407561732-817-1-git-send-email-linux@roeck-us.net>
 <20140811102052.6d9c28cb@canb.auug.org.au>
In-Reply-To: <20140811102052.6d9c28cb@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2014 05:20 PM, Stephen Rothwell wrote:
> Hi Guenter,
>
> On Fri,  8 Aug 2014 22:22:12 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Once again, we see
>>
>> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
>> arch/powerpc/kernel/exceptions-64s.S:865: Error: attempt to move .org backwards
>> arch/powerpc/kernel/exceptions-64s.S:866: Error: attempt to move .org backwards
>> arch/powerpc/kernel/exceptions-64s.S:890: Error: attempt to move .org backwards
>>
>> when compiling ppc:allmodconfig.
>>
>> This time the problem has been caused by to commit 0869b6fd209bda
>> ("powerpc/book3s: Add basic infrastructure to handle HMI in Linux"),
>> which adds functions hmi_exception_early and hmi_exception_after_realmode
>> into a critical (size-limited) code area, even though that does not appear
>> to be necessary.
>>
>> Move those functions to a non-critical area of the file.
>>
>> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Compile tested with all ppc configurations.
>> The reported checkpatch error appears to be a false positive.
>
> Thanks.
>
> I have added that to my fixes tree for today.
>
Thanks!

Guenter
