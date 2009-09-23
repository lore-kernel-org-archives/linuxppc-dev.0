Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58760B7B7A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 18:34:34 +1000 (EST)
Message-ID: <4AB9DD8F.1040305@kernel.org>
Date: Wed, 23 Sep 2009 17:34:23 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>
	<1253185994.8375.352.camel@pasglop>	<4AB25B61.9020609@kernel.org>
	<4AB266AF.9080705@in.ibm.com> <4AB49C37.6020003@in.ibm.com>
	<4AB9DAEC.3060309@in.ibm.com>
In-Reply-To: <4AB9DAEC.3060309@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sachin Sant wrote:
> Sachin Sant wrote:
>> Sachin Sant wrote:
>>> Tejun Heo wrote:
>>>> Ah... sorry about that.  Sachin, is it possible for you to build the
>>>> kernel with debug info and ask gdb where the stalling NIP is in the c
>>>> file?
>>>>   
>>> <6>NET: Registered protocol family 10
>>> <3>BUG: soft lockup - CPU#2 stuck for 61s! [modprobe:1865]
>>> <4>Modules linked in: ipv6(+) fuse loop dm_mod sg sd_mod crc_t10dif
>>> ibmvscsic scsi_transport_srp scsi_tgt scsi_mod
>>> <4>NIP: c00000000004198c LR: c00000000015dac8 CTR: 0000000000000040
>>> <4>REGS: c0000000fbdbb6f0 TRAP: 0901   Not tainted  (2.6.31-git5)
>>> <4>MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 44224420  XER: 20000001
>>> <4>TASK = c0000000fbd57840[1865] 'modprobe' THREAD: c0000000fbdb8000
>>> CPU: 2
>>> <4>GPR00: 0000000000000040 c0000000fbdbb970 c000000000a96d08
>>> d00007fffff00000
>>> <4>GPR04: 0000000000000000 0000000000000000 d00007fffff00000
>>> d00007fffff00000
>>> <4>GPR08: 0000000000000000 c000000001020180 c000000000b6b4e8
>>> 00000000000003c0
>>> <4>GPR12: 0000000048224428 c000000000b82a00
>>> <4>NIP [c00000000004198c] .memset+0x60/0xfc
>>> <4>LR [c00000000015dac8] .pcpu_alloc+0x758/0x960
>>> <4>Call Trace:
>>> <4>[c0000000fbdbb970] [c00000000015da58] .pcpu_alloc+0x6e8/0x960
>>> (unreliable)
>>> <4>[c0000000fbdbba90] [c000000000565664] .snmp_mib_init+0x34/0x9c
>>> <4>[c0000000fbdbbb20] [d00000000212e130] .ipv6_add_dev+0x1cc/0x3dc
>>> [ipv6]
>>> <4>[c0000000fbdbbbc0] [d0000000021598ac] .addrconf_init+0x6c/0x194
>>> [ipv6]
>>> <4>[c0000000fbdbbc50] [d00000000215967c] .inet6_init+0x1bc/0x34c [ipv6]
>>> <4>[c0000000fbdbbce0] [c0000000000097a4] .do_one_initcall+0x88/0x1bc
>>> <4>[c0000000fbdbbd90] [c0000000000c84dc] .SyS_init_module+0x11c/0x29c
>>> <4>[c0000000fbdbbe30] [c0000000000085b4] syscall_exit+0x0/0x40
>>> <4>Instruction dump:
>>> <4>98860000 38c60001 409e000c b0860000 38c60002 409d000c 90860000
>>> 38c60004
>>> <4>78a0d183 78a506a0 7c0903a6 4182002c <f8860000> f8860008 f8860010
>>> f8860018
>> Latest git (2.6.31-git9:78f28b7c555359c67c2a0d23f7436e915329421e)
>> still has this bug. 
> One workaround i have found for this problem is to disable IPv6.
> With IPv6 disabled the machine boots OK. Till a reliable solution
> is available for this issue, i will keep IPv6 disabled in my configs.

I'm think it's most likely caused by some code accessing invalid
percpu address.  I'm currently writing up access validator.  Should be
done in several hours.  So, ipv6 it is.  I couldn't reproduce your
problem here.  I'll give ipv6 a shot.

Thanks.

-- 
tejun
