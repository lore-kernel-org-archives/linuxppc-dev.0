Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id D2A64DDE24
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 13:48:03 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04BC5B2A@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807172143.57576.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B34E18@ismail.innsys.innovsys.com>
	<200807172332.18030.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04BC5B2A@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <52cfb363300164e2d5d566ac635e9d20@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: 82xx performance
Date: Fri, 25 Jul 2008 22:47:36 -0500
To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 25, 2008, at 3:41 PM, Rune Torgersen wrote:

>> From: Arnd Bergmann [mailto:arnd@arndb.de]
>> On Thursday 17 July 2008, Rune Torgersen wrote:
>>> Arnd Bergmann wrote:
>>>> So again, nothing conclusive. I'm running out of ideas.
>>>
>>> Is the syscall path different or the same on ppc and powerpc?
>>> Any differences in the task switching, irq handling or page fault
>>> handling?
>>>
>>
>> It's all different in suble ways, but those changes should only
>> show up in the system time accounting, not user time accounting.
>
> I've been running the workload this board will see. On a 2.6.18 kernel
> %idle is ~50% and %wa (waiting for IO) is less than 1% most of the 
> time.
> On 2.6.25, the idle% is lower (by about 10-15%) and the %wa is
> consistently hovering around 20-30% sometimes spiking to 100%.
>
> The workload involves quite a bit of socket IO (TCP, UDP, Unix Sockets
> and TIPC) and disk IO.
> Any easy way of finding what is causing the wait for IO?
>
> (Ive been trying to get lttng to work, but not any good results so 
> far).

In both idle and wait, the cpu is in the idle loop waiting for something
to do.  The difference is that a cpu is considered in disk wait if the
there is a task in uninterruptible sleep that is not being counted as
waiting on another cpu.

With a significant change in wait time, I would suggest restating the
current observations to the linux-mm community, probably with a cc
to linux-kernel.

Be sure to state what you have done to equalize the comparison (eg
highmen, ram size left, etc).

There may be some tunables that could adjust the behavior.

milton
