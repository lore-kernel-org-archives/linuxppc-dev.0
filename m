Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id EFF8FDDE07
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 00:17:37 +1000 (EST)
Message-ID: <46B5DC7C.70602@ru.mvista.com>
Date: Sun, 05 Aug 2007 18:19:40 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [patch 06/10] 40x decrementer fixes
References: <20070803160900.069522000@linux.vnet.ibm.com> >	
	<20070803161710.931656000@linux.vnet.ibm.com> >	
	<46B35C07.4090806@ru.mvista.com> <1186194491.5733.2.camel@gruick>
In-Reply-To: <1186194491.5733.2.camel@gruick>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>>>Allow generic_calibrate_decr to work for 40x platforms.  Given that the hardware
>>>behavior is identical, this also changes the set_dec function to reload the PIT
>>>on 40x to match the behavior 44x currently has.

>>    Why bother doing this?! This will only warrant you imprecise decrementer 
>>interrupts while it should be interrupting at the precise period currently (if 
>>you load PIT once)...

> Because that's what the kernel timekeeping code expects ? The reference
> time is the timebase and it doesn't drift.

> The DEC/PIT is commonly used to trigger any timing, such as what is done
> for lost interrupts on some platforms. Also, with dynticks, we'll most
> certainly want variable reload values as well.

    That's another matter. :-)
    BTW, because of that mere return in set_dec() for the 40x case I had to 
write to the PIT myself in the decrementer clockevent's set_next_event() 
method -- while for classic PPC I was just calling set_dec(n-1)...

> So I'm very happy to have Josh change the code that way. It makes things
> more consistent accross the board and removes confusion.

    Yeah, it's OK now that's my temporary confusion has passed.
    Well, it wasn't only not only mine -- the set_dec() code was suggesting 
auto-reload mode, and has been obviosuly copied from <asm-ppc/time.h>, so 
arch/ppc/ was using the auto-reload mode indeed.

> Ben.

WBR, Sergei
