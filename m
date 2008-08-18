Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts5-srv.bellnexxia.net (tomts5.bellnexxia.net
	[209.226.175.25]) by ozlabs.org (Postfix) with ESMTP id B15D8DE71B
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 03:04:47 +1000 (EST)
Received: from toip7.srvr.bell.ca ([209.226.175.124])
	by tomts5-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20080818170445.KPYX1572.tomts5-srv.bellnexxia.net@toip7.srvr.bell.ca>
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 13:04:45 -0400
Date: Mon, 18 Aug 2008 13:04:42 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Steven Rostedt <srostedt@redhat.com>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
Message-ID: <20080818170442.GA29337@Krystal>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A99F51.8090504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48A99F51.8090504@redhat.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Eran Liberty <liberty@extricom.com>,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Steven Rostedt (srostedt@redhat.com) wrote:
> Mathieu Desnoyers wrote:
>>
>> Steve ? I just noticed this :
>>
>>
>> ftrace_modify_code(unsigned long ip, unsigned char *old_code,
>>                    unsigned char *new_code)
>> {
>>         unsigned replaced;
>>         unsigned old = *(unsigned *)old_code;
>>         unsigned new = *(unsigned *)new_code;
>>         int faulted = 0;
>>
>>         /*
>>          * Note: Due to modules and __init, code can
>>          *  disappear and change, we need to protect against faulting
>>          *  as well as code changing.
>>          *
>>          * No real locking needed, this code is run through
>>          * kstop_machine.
>>          */
>>         asm volatile (
>>                 "1: lwz         %1, 0(%2)\n"
>>                 "   cmpw        %1, %5\n"
>>                 "   bne         2f\n"
>>                 "   stwu        %3, 0(%2)\n"
>>                 "2:\n"
>>                 ".section .fixup, \"ax\"\n"
>>                 "3:     li %0, 1\n"
>>                 "       b 2b\n"
>>                 ".previous\n"
>>                 ".section __ex_table,\"a\"\n"
>>                 _ASM_ALIGN "\n"
>>                 _ASM_PTR "1b, 3b\n"
>>                 ".previous"
>>                 : "=r"(faulted), "=r"(replaced)
>>                 : "r"(ip), "r"(new),
>>                   "0"(faulted), "r"(old)
>>                 : "memory");
>>
>>         if (replaced != old && replaced != new)
>>                 faulted = 2;
>>
>>         if (!faulted)
>>                 flush_icache_range(ip, ip + 8);
>>
>>         return faulted;
>> }
>>
>> What happens if you are really unlucky and get the following execution
>> sequence ?
>>
>>
>> Load module A at address 0xddfc3e00
>> Populate ftrace function table while the system runs
>> Unload module A
>> Load module B at address 0xddfc3e00
>> Activate ftrace
>> -> At that point, since there is another module loaded in the same
>> address space, it won't fault. If there happens to be an instruction
>> which looks exactly like the instruction we are replacing at the same
>> location, we are introducing a bug. True both on x86 ans powerpc...
>>
>>   
>
> Hi Mathieu,
>
> Yep I know of this issue, and it is very unlikely it would happen.  But 
> that's not good enough, so this is why I did this:
>
> http://marc.info/?l=linux-kernel&m=121876928124384&w=2
> http://marc.info/?l=linux-kernel&m=121876938524523&w=2
>
> ;-)
>
> On powerpc it would be less likely an issue since the code segments are all 
> 4 bytes aligned. And a call being replaced would be a call to mcount 
> (relative jump). A call to mcount would be the same for both. Then again, 
> we could be replacing a nop, but most likely that wouldn't hurt either, 
> since nops are seldom used, and if we did call mcount, it would probably 
> not hurt. But it would be an issue if Module B happen to put a data section 
> that matched the code to jmp to mcount or a nop.
>

Ah, I did not see this one passing by :) That's the right solution
indeed. I guess it's not in 2.6.27-rc2/rc3 though ? I wonder if the
bug can be repeated with a module-free kernel ?

Mathieu

> -- Steve
>

-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
