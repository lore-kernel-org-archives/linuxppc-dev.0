Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 6CDF567C45
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Aug 2006 00:39:26 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <d510e54618e033b9c4fb25f0baa22cc4@bga.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: KiJun Kwon <gjkwon@idis.co.kr>,
 linuxppc-dev@ozlabs.org
From: Milton Miller <miltonm@bga.com>
Subject: Fwd: When mounting using USB-CDROM,
	segment fault is called and system hangon
Date: Fri, 25 Aug 2006 09:39:21 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ooops sent to -request somehow.

Begin forwarded message:

> From: Milton Miller <miltonm@bga.com>
> Date: August 25, 2006 8:55:54 AM CDT
> To: KiJun Kwon <gjkwon@idis.co.kr>
> Cc: linuxppc-dev-request@ozlabs.org
> Subject: Re: When mounting using USB-CDROM,  segment fault is called 
> and system hangon
>
> On Fri Aug 25 19:12:18 EST 2006, KiJun Kwon wrote:
>> Most recent kernel where this bug did not occur:
>> For 2.6.15, 2.6.17, it is occurred
>>
>> Hardware Environment: bamboo board(PPC440EP Rev.B)
>>
>> Software Environment: debian
>>
>> Problem Description:
>> To read the files in the cdrom, I used USB-CDROM device(it is not 
>> specific to
>> a vendor, model). When I try to mount, below dmesg is printed and 
>> system is
>> hangon or segmentation fault is called.
>>
>> juno-nfs:~# mount -o ro -t iso9660 /dev/sr0 /mnt
>> Oops: kernel access of bad area, sig: 11 [#1]
>> NIP: 7C0802A4 LR: D101CB7C CTR: 7C0802A6
>> REGS: cb747990 TRAP: 0400   Not tainted  (2.6.17)
>> MSR: 00029000 <EE,ME>  CR: 22002428  XER: 00000000
>> TASK = cbe2e830[377] 'mount' THREAD: cb746000
>> GPR00: 7C0802A6 CB747A40 CBE2E830 C062E1F8 00000000 CB747A00 00000000 
>> C027E130
>> GPR08: CB646B3C 0000000C C02FA100 C04BC02C 0000825F 1002A544 10024B18 
>> 10024AE8
>> GPR16: 10024AC8 00000000 00000000 10024AB8 00000000 10020000 00000000 
>> 10024AF8
>> GPR24: C04AFC08 CB747A58 CB747CB8 D1020000 D102A144 00000000 D1020000 
>> C062E1F8
>> NIP [7C0802A4] 0x7c0802a4
>> LR [D101CB7C] cdrom_open+0x3a0/0xad8 [cdrom]
>> Call Trace:
>> [CB747A40] [D101CB18] cdrom_open+0x33c/0xad8 [cdrom] (unreliable)
>> [CB747BD0] [D1029DF0] sr_block_open+0x8c/0xd8 [sr_mod]
>> [CB747BF0] [C0060444] do_open+0x94/0x398
>> [CB747C30] [C0060840] blkdev_get+0x64/0x78
>> [CB747D70] [C00608A4] open_bdev_excl+0x50/0xd8
>> [CB747D90] [C005F1F4] get_sb_bdev+0x30/0x188
>> [CB747DE0] [C00E4B08] isofs_get_sb+0x18/0x28
>> [CB747DF0] [C005E60C] do_kern_mount+0x58/0x10c
>> [CB747E10] [C007701C] do_mount+0x254/0x704
>> [CB747F10] [C007755C] sys_mount+0x90/0xe4
>> [CB747F40] [C0001C88] ret_from_syscall+0x0/0x3c
>> Instruction dump:
>> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
>> XXXXXXXX
>> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
>> XXXXXXXX
>> Segmentation fault
>>
>
> Your system tried to execute an instruction at an invalid address (trap
> 400).  The NIA is the same as the CTR (truncating the bottom 2 bits), 
> so
> it was probably from following a function pointer in C.  The address in
> the CTR (counter) register is the opcode for "mflr r0", which is the
> first instruction in just about every non-leaf function.
>
> It appears that someone dereferenced a function pointer before 
> assigning
> it.  The stack trace shows it was called about 30 % of the way in
> cdrom_open, which was called from  called from sr_block_open.  That
> should give you a good indication what structure contains the bad
> pointer.
>
>> After this error, when I try to remount, system is freezed without 
>> any mesg.
>
> The oops means the kernel terminated this thread of execution without
> cleaning up the locks.  The new attempt encounters a locked resource
> and waits for it to be unlocked, which will not happen because of
> the first bug.
>
>
> milton
>
