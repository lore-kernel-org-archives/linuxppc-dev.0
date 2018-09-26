Return-Path: <daniel.thompson@linaro.org>
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KwH50mBGzF3F5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 21:11:12 +1000 (AEST)
Received: by mail-wm1-x343.google.com with SMTP id b19-v6so1829120wme.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 04:11:12 -0700 (PDT)
Subject: Re: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Jason Wessel <jason.wessel@windriver.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kgdb-bugreport@lists.sourceforge.net,
 stable@vger.kernel.org, me@tobin.cc
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org>
Date: Wed, 26 Sep 2018 12:11:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/09/2018 20:06, Daniel Thompson wrote:
> On Fri, Sep 14, 2018 at 12:35:44PM +0000, Christophe Leroy wrote:
>> On a powerpc 8xx, 'btc' fails as follows:
>>
>> Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
>> kdb> btc
>> btc: cpu status: Currently on cpu 0
>> Available cpus: 0
>> kdb_getarea: Bad address 0x0
>>
>> when booting the kernel with 'debug_boot_weak_hash', it fails as well
>>
>> Entering kdb (current=0xba99ad80, pid 284) due to Keyboard Entry
>> kdb> btc
>> btc: cpu status: Currently on cpu 0
>> Available cpus: 0
>> kdb_getarea: Bad address 0xba99ad80
>>
>> On other platforms, Oopses have been observed too, see
>> https://github.com/linuxppc/linux/issues/139
>>
>> This is due to btc calling 'btt' with %p pointer as an argument.
>>
>> This patch replaces %p by %px to get the real pointer value as
>> expected by 'btt'
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: <stable@vger.kernel.org> # 4.15+
> 
> Would a Fixes: be better here?
> Fixes: ad67b74d2469d9b82 ("printk: hash addresses printed with %p")

Christophe, When you add the Fixes: could you also add my

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Thanks.


> 
> No blame attached to Tobin, but the fixes makes it super clear what
> changed and why this breaks kdb (which was not explicitly called out
> the patch description).
> 
> 
> Daniel.
> 
>> ---
>>   kernel/debug/kdb/kdb_bt.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
>> index 6ad4a9fcbd6f..7921ae4fca8d 100644
>> --- a/kernel/debug/kdb/kdb_bt.c
>> +++ b/kernel/debug/kdb/kdb_bt.c
>> @@ -179,14 +179,14 @@ kdb_bt(int argc, const char **argv)
>>   				kdb_printf("no process for cpu %ld\n", cpu);
>>   				return 0;
>>   			}
>> -			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
>> +			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
>>   			kdb_parse(buf);
>>   			return 0;
>>   		}
>>   		kdb_printf("btc: cpu status: ");
>>   		kdb_parse("cpu\n");
>>   		for_each_online_cpu(cpu) {
>> -			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
>> +			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
>>   			kdb_parse(buf);
>>   			touch_nmi_watchdog();
>>   		}
>> -- 
>> 2.13.3
>>
