Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id A08B9DDE49
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 04:24:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: On the other side of early_debug...
Date: Mon, 13 Aug 2007 14:24:06 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90108DAB7C4@EMPBEDEX.empirix.com>
In-Reply-To: <mailman.1.1186797602.26064.linuxppc-dev@ozlabs.org>
References: <mailman.1.1186797602.26064.linuxppc-dev@ozlabs.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It looks like I am getting up to the point where the=20
rootfs has been NFS mounted correctly. Whew, but the
first thing the INIT program does it try to open the
/dev/console device - and it goes oops:

>> kernel BUG at drivers/char/tty_io.c:781!
>> Oops: Exception in kernel mode, sig: 5 [#1]
>> Empirix MPC848 Cheetah Board
>> Modules linked in:
>> NIP: c01390d4 LR: c013abe4 CTR: 00000000
>> REGS: effc3d50 TRAP: 0700   Not tainted
(2.6.23-r3_tom-g46b28357-dirty)
>> MSR: 00021000 <ME>  CR: 24242422  XER: 00000000
>> TASK =3D effc1a80[1] 'init' THREAD: effc2000
>> GPR00: 00000001 effc3e00 effc1a80 00000000 effc3de0 00000001 00000000

>>   c02b60c8
>> GPR08: 00001aa3 00000000 c030b730 00000000 22242422 1001f2f8 fffffff0

>>   007fff94
>> GPR16: 20000000 00000000 00000000 effc3e30 c17c2528 c17c2530 00000130

>>   00000128
>> GPR24: c02c0000 00000001 00000001 00000000 00000000 00029000 c17c2400
>>  00000001
>> NIP [c01390d4] tty_ldisc_put+0x44/0x70
>> LR [c013abe4] release_dev+0x4ec/0x6a0
>> Call Trace:
>>  [effc3e00] [c021d800] __mutex_unlock_slowpath+0x40/0xd4 (unreliable)
>>  [effc3e20] [c013abe4] release_dev+0x4ec/0x6a0
>>  [effc3ee0] [c013adac] tty_release+0x14/0x28
>>  [effc3ef0] [c0068844] __fput+0x178/0x19c
>>  [effc3f10] [c0066a5c] filp_close+0x54/0xac
>>  [effc3f30] [c0066b34] sys_close+0x80/0xc0
>>  [effc3f40] [c000c54c] ret_from_syscall+0x0/0x3c
>> Instruction dump:
>> 7c000110 7c0000d0 0f000000 7fa000a6 7c000146 1d43004c 3d20c031
3929b730
>> 7d4a4a14 816a0048 212b0000 7c095914 <0f000000> 396bffff 806a0044
916a0048

Now, it seems the root cause is that the tty's=20
console_init was NEVER being called.=20

I am wondering if there was a reason or rhyme for this?
