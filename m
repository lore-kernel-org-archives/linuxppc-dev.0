Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 290A8DDF50
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 03:45:08 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m38HikQZ013450
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 03:44:46 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m38HmwuI188068
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 03:48:58 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m38Hj5o8003008
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 03:45:05 +1000
Message-ID: <47FBAF1E.1040405@linux.vnet.ibm.com>
Date: Tue, 08 Apr 2008 23:15:02 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [BUG] 2.6.25-rc2-git4 - Regression Kernel oops  while running
	kernbench and tbench on powerpc
References: <47BC40BC.3040405@linux.vnet.ibm.com>
	<18427.11023.8067.795279@cargo.ozlabs.ibm.com>
	<47FB5C5A.5020104@linux.vnet.ibm.com>
	<18427.27360.30297.84859@cargo.ozlabs.ibm.com>
In-Reply-To: <18427.27360.30297.84859@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Cc: kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, nacc@us.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Kamalesh Babulal writes:
> 
>> The kernel oops after applying the patch. Some time it takes more than
>> one run to reproduce it, it was reproducible in the second run this
>> time.
>>
>>  Unrecoverable exception 4100 at c000000000008c8c
>> Oops: Unrecoverable exception, sig: 6 [#1]
>> SMP NR_CPUS=128 NUMA pSeries
>> Modules linked in:
>> NIP: c000000000008c8c LR: 000000000ff0135c CTR: 000000000ff012f0
>> REGS: c000000772343bb0 TRAP: 4100   Not tainted  (2.6.25-rc8-autotest)
>> MSR: 8000000000001030 <ME,IR,DR>  CR: 44044228  XER: 00000000
>> TASK = c00000077cfa0900[13437] 'cc1' THREAD: c000000772340000 CPU: 2
>> GPR00: 0000000000004000 c000000772343e30 00000000000000bb 000000000000d032 
>> GPR04: 00000000000000bb 0000000000000400 000000000000000a 0000000000000002 
>> GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>> GPR12: 0000000000000000 c000000000734000 0000000000000064 00000000ffe6df08 
>> GPR16: 00000000105b0000 00000000105b0000 0000000010440000 00000000105b0000 
>> GPR20: 00000000ffe6e008 00000000105b0000 00000000105b0000 000000000000000a 
>> GPR24: 000000000ffec408 0000000000000001 00000000ffe6ddca 0000000000000400 
>> GPR28: 000000000ffec408 00000000f7ff8000 000000000ffebff4 0000000000000400 
>> NIP [c000000000008c8c] restore+0x8c/0xc0
>> LR [000000000ff0135c] 0xff0135c
>> Call Trace:
>> [c000000772343e30] [c000000000008cd4] do_work+0x14/0x2c (unreliable)
>> Instruction dump:
>> 7c840078 7c810164 70604000 41820028 60000000 7c4c42e6 e88d01f0 f84d01f0 
>> 7c841050 e84d01e8 7c422214 f84d01e8 <e9a100d8> 7c7b03a6 e84101a0 7c4ff120 
>>
<snip>
> The exception happened at c...8c8c but you looked at c...8cdc with
> gdb.  What's at c...8c8c?
> 
>> please let me know if you need more information.
> 
> The .config would be useful, but don't spam everyone on cc with it,
> just send it to me privately.
> 
> Paul.

Hi Paul,

Similar call trace was seen in 2.6.24-rc3-git2 kernel while bootup, I have attached the
boot log to bugzilla (http://bugzilla.kernel.org/attachment.cgi?id=15666&action=view).
When looking for the last good one, we found that the kernel oops seems to be reproducible 
from the 2.6.24-rc8-git3 kernel onwards.

Thanks to nishanth for pointing it out, Please let me know if you need more information.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
