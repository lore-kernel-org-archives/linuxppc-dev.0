Return-Path: <phileas-fogg@mail.ru>
Received: from smtp42.i.mail.ru (smtp42.i.mail.ru [94.100.177.102])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C30792C02FE
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2013 23:49:21 +1100 (EST)
Message-ID: <513346AA.5010309@mail.ru>
Date: Sun, 03 Mar 2013 05:48:42 -0700
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
References: <51320F53.9040000@mail.ru> <1362288548.2969.13.camel@pasglop>
In-Reply-To: <1362288548.2969.13.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Sat, 2013-03-02 at 15:40 +0100, Phileas Fogg wrote:
>> recently i got a PowerMac G5 and installed Debian Linux 2.6.32 on it.
>> Everything works so far and Debian boots properly.
>>
>> Today i tried to boot Linux 3 on the machine and it doesn't boot.
>> The Linux 3 kernel was cross-compiled by me.
>>
>> On Linux 3.8.1 it hangs after this line:
>> ---
>> windfarm: Drive bay control loop started.
>>
>> And then i'm getting RCU stall call traces.
>>
>> On Linux 3.2 it hangs too but not at the same place.
>> It hangs after some SCSI message.
>>
>> Have anyone tested Linux 3 kernels on PowerMac G5 recently ?
>
> Hrm, this is odd. I do run pretty much every release on my G5's without
> problems... Can you send me your .config and then try with a
> g5_defconfig just to see if it makes a difference ?
>
> There *might* have been a problem on those older machines vs. the 64T
> address space patches, so maybe try back 3.6 and 3.7 and let me know,
> I'm still trying to get the right fix in (I know it breaks PS/3 under
> some circumstances).
>
> Cheers,
> Ben.
>
>


Reverted 64TB commit on Linux 3.8.1 and it didn't help, it still hangs.

Here is the RCU stall call trace:

BUG - soft lockup - CPU#1 stuck for 23s
Call trace:
padzero
load_elf_binary
search_binary_handler
load_script
search_binary_handler
do_execve_common
sys_execve
syscall_exit

Exception at kernel_execve
LR = run_init_process



regards
