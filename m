Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 99C73DE16D
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 00:14:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: FW: 1 GB lowmem
Date: Thu, 22 May 2008 09:14:58 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B046E7C6E@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On May 21, 2008, at 4:24 PM, Rune Torgersen wrote:
>=20
>> Kumar Gala wrote:
>>> On May 21, 2008, at 3:55 PM, Rune Torgersen wrote:
>>>> Argh... Found it. Had to set CONFIG_TASK_SIZE to 0x80000000. Now it
>>>> works in both vaniulla an d RT kernel.
>>>=20
>>> We should really add some sanity check on CONFIG_TASK_SIZE vs
>>> KERNEL_START.
>>=20
>> Something like this?
>> Wording sould probablyy be a bit different/cleare.
>>=20
>> diff --git a/include/asm-powerpc/processor.h
>> b/include/asm-powerpc/processor.h
>> index fd98ca9..72e0e3f 100644
>> --- a/include/asm-powerpc/processor.h
>> +++ b/include/asm-powerpc/processor.h
>> @@ -81,6 +81,10 @@ extern struct task_struct *last_task_used_altivec;
>> extern struct task_struct *last_task_used_spe;
>>=20
>> #ifdef CONFIG_PPC32
>> +
>> +#if CONFIG_TASK_SIZE > CONFIG_KERNEL_START
>> +#error User TASK_SIZE overlaps with KERNEL_START address
>> +#endif
>> #define TASK_SIZE      (CONFIG_TASK_SIZE)
>>=20
>> /* This decides where the kernel will search for a free chunk of vm
>>=20
>=20
> something like that would be good.  is there really anything PPC32
> specific about it?=20
>=20
Probably not. Could this be done in the Kconfig file instead?. Don't
know if Kconfig supports doing a comparison.
