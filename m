Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 7F54767A70
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 10:56:59 +1100 (EST)
Message-ID: <421A727D.1010103@mrv.com>
Date: Mon, 21 Feb 2005 18:45:01 -0500
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>	<20050210150437.GA19134@logos.cnet>	<c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>
	<Pine.LNX.4.61.0502212206420.14199@acs.sysgo.com>
In-Reply-To: <Pine.LNX.4.61.0502212206420.14199@acs.sysgo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Armin Schindler <armin.schindler@sysgo.com>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Armin Schindler wrote:

> Hi Dan,
>
> On Thu, 10 Feb 2005, Dan Malek wrote:
>
>>
>> On Feb 10, 2005, at 10:04 AM, Marcelo Tosatti wrote:
>>
>>> Does anyone have a clue of what is/can be wrong with the TLB entry 
>>> for the
>>> address being flushed at __flush_dcache_icache()?
>>
>>
>> Not sure. The problem is that the __flush_dcache_icache is passed a
>> user space virtual address that doesn't look like it is mapped for 
>> writing
>> or something. I don't know, as an ooops isn't sufficient to debug the 
>> problem.
>> You have to catch it here and track down the current state of the TLB 
>> and
>> the page tables. Of course, when I do this everything looks OK, so what
>> I've been trying to do is catch the TLBmiss reload that actually 
>> causes this
>> to happen to see what it really tried to load into the tlb. A much more
>> challenging project :-) I'll get it one of these days .....
>
>
> any news on that issue?
>
> I just started with an MPC855/859 and run into the same problem with 
> 2.6.9.
>
> Is there anything I can do or test?
> Right now I'm not sure where to begin.
>
> Even BDI-debugging would be possible...
>
> Thanks,
> Armin
>
> ---
> Armin Schindler SYSGO AG
> Am Pfaffenstein 14
> D-55270 Klein-Winternheim / Germany
> Phone: +49 6136 9948-0
> Fax : +49 6136 9948-10
> armin.schindler@sysgo.com
> www.sysgo.com
> www.elinos.com
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
Hi all,

I am experiencing the same issue with 2.6.11-rc2 (see oops below).
And I also notice something else that may or may not be related. I see 
that doing a DCBZ instruction on an invalid address "hangs" the process 
doing it. My expectation was to get a crash/core instead of hanging 
forever...

The code used is extremely simple (may be too simple ?):

int main( int argc, char **argv ) {
int *where = NULL;
int index = 0;
asm volatile ("dcbz %0,%1" : : "r"(index), "r"(where) );
return 1;
}

Also, the instruction left in the NIP by the Oops is:
0xc0004758 <__flush_dcache_icache+20>: dcbst r0,r3

Yet another dcbX instruction...

Does anyone know where do we go from here ??

Guillaume.


Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C0004758 LR: C0009804 SP: C7C4BE10 REGS: c7c4bd60 TRAP: 0300 Not 
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 3000A038, DSISR: C2000000
TASK = c7c76ae0[24] 'ldconfig' THREAD: c7c4a000
Last syscall: 90
GPR00: C01C38C0 C7C4BE10 C7C76AE0 3000A000 00000100 00007FCB 3000A000 
C03FC028
GPR08: C03FE300 C01C38C0 00000000 000FF960 00000000 10099C8C 000000D8 
00000000
GPR16: 0000A038 3000A7F4 1009386B 00000007 7FFFFAD8 00000000 C03FE300 
00000000
GPR24: 00000000 C67732B0 C01C38C0 3000A038 C03FC028 C01C08B0 07FCB889 
C02FE960
NIP [c0004758] __flush_dcache_icache+0x14/0x40
LR [c0009804] update_mmu_cache+0x64/0x98
Call trace:
[c003aba0] do_no_page+0x4b8/0x54c
[c003ad28] handle_mm_fault+0xf4/0x2b4
[c0008de4] do_page_fault+0x208/0x424
[c0002ae8] handle_page_fault+0xc/0x80
.........

-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 
