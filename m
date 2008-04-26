Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BF6B5DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 22:30:48 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m3QCUln5019918
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 22:30:47 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3QCYk0g273974
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 22:34:46 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3QCUvfm027131
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 22:30:57 +1000
Message-ID: <48132072.9060308@linux.vnet.ibm.com>
Date: Sat, 26 Apr 2008 18:00:42 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [BUG] 2.6.25-git8 Kernel Bug while bootup on ppc and x86
References: <48131052.2080102@linux.vnet.ibm.com>
	<20080426113040.GC2252@cs181133002.pp.htv.fi>
In-Reply-To: <20080426113040.GC2252@cs181133002.pp.htv.fi>
Content-Type: text/plain; charset=UTF-8
Cc: kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@elte.hu>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk wrote:
> On Sat, Apr 26, 2008 at 04:51:54PM +0530, Kamalesh Babulal wrote:
>> While booting the 2.6.25-git8 kernel on the ppc and x86_64 machine, kernel
>> bug is hit. This was reported in the next-20080423 kernel 
>> http://lkml.org/lkml/2008/4/23/206.
>>
>> Call trace of x86_64 machine
>>
>> BUG: unable to handle kernel paging request at 00000000ffffffff
>> IP: [<ffffffff802359e5>] put_files_struct+0x25/0x110
>> PGD 0 
>> Oops: 0002 [333] SMP 
>> CPU 3 
>> Modules linked in:
>> Pid: 1391, comm: khelper Tainted: G      D  2.6.25-git8-autotest #1
>> RIP: 0010:[<ffffffff802359e5>]  [<ffffffff802359e5>] put_files_struct+0x25/0x110
>> RSP: 0000:ffff81090d06bdb0  EFLAGS: 00010282
>> RAX: 0000000000000101 RBX: fffffffffffffffe RCX: ffff8100010260e0
>> RDX: 0000000000000007 RSI: 0000000000000001 RDI: 00000000ffffffff
>> RBP: 00000000fffffffe R08: 2222222222222267 R09: 2222222222222222
>> R10: 0000000000000010 R11: 2222222222222222 R12: 00000000ffffffff
>> R13: ffff81032d2e9000 R14: ffff81090e74b000 R15: ffff81061e4cbce0
>> FS:  0000000000000000(0000) GS:ffff81032e4ae940(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
>> CR2: 00000000ffffffff CR3: 0000000000201000 CR4: 00000000000006e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>> Process khelper (pid: 1391, threadinfo ffff81090d06a000, task ffff81090d8113a0)
>> Stack:  ffff81090d8113a0 fffffffffffffffe 00000000fffffffe ffff81032e556e00
>>  ffff81032d2e9000 ffff81090e74b000 ffff81061e4cbce0 ffffffff80294278
>>  ffff81090d06be70 ffffffff80636bc0 ffff81090d3646c0 ffff81032d2e9000
>> Call Trace:
>>  [<ffffffff80294278>] do_execve+0x108/0x230
>> ...
> 
> Most likely fixed by
>   http://lkml.org/lkml/2008/4/26/1

Hi Adrian,

Thanks, the patch fixes the boot up bug.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
