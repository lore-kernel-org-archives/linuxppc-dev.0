Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yw5nr2bdBzDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 13:02:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>, Gustavo Romero <gromero@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: leitao@debian.org
Subject: Re: [PATCH 2/2] selftests/powerpc: Calculate spin time in
 tm-unavailable
In-Reply-To: <1511307683.7121.5.camel@gmail.com>
References: <20171121071720.24619-1-cyrilbur@gmail.com>
 <20171121071720.24619-2-cyrilbur@gmail.com>
 <5A142ABD.9060705@linux.vnet.ibm.com> <1511307683.7121.5.camel@gmail.com>
Date: Mon, 11 Dec 2017 13:02:50 +1100
Message-ID: <871sk2c985.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cyril Bur <cyrilbur@gmail.com> writes:

> On Tue, 2017-11-21 at 11:31 -0200, Gustavo Romero wrote:
>> Hi Cyril,
>> 
>> On 21-11-2017 05:17, Cyril Bur wrote:
>> > Currently the tm-unavailable test spins for a fixed amount of time in
>> > an attempt to ensure the FPU/VMX/VSX facilities are off. This value was
>> > experimentally tested to be long enough.
>> > 
>> > Problems may arise if kernel heuristics were to change. This patch
>> > should future proof this test.
>> 
>> I've tried it on a VM running on '4.14.0-rc7' and apparently it gets stuck
>> pretty slow on calibration, since it ran ~7m without finding the correct value
>> (before it would take about 3m), like:
>> 
>> $ time ./tm-unavailable
>> Testing required spin time required for facility unavailable...
>> 	Trying 0x18000000...
>> 	Trying 0x19000000...
>> 	Trying 0x1a000000...
>> ...
>> 	Trying 0xfd000000... ^C
>> 
>> real	7m15.304s
>> user	7m15.291s
>> sys	0m0.004s
>> 
>
> Interesting! I didn't test in a VM. I guess hypervisor switching
> completely changes the heuristic. Ok I'll have to rethink.
>
> Maybe the increase should be a multiplier to get to a good state more
> quickly.

Yeah this sucks in a VM:

# /home/michael/tm-unavailable 
Testing required spin time required for facility unavailable...
	Trying 0x18000000... 
	Trying 0x19000000... 
...
	Trying 0x110000000...  

etc.

I got sick of waiting for it, but it's causing my selftests job to time
out so it must be taking > ~1 hour.

cheers
