Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id D2427476B6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 03:07:52 +1100 (EST)
In-Reply-To: <18706.30114.75625.811901@cargo.ozlabs.ibm.com>
References: <patch-ipi-2@bga.com> <patch-ipi-2-v2@bga.com>
	<18706.30114.75625.811901@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <01840c9e092f2a8323d72e5b5d29b1a3@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 14/16 v2] powerpc: expand vs demux ipi actions per message
Date: Tue, 11 Nov 2008 10:12:22 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 5, 2008, at 10:42 PM, Paul Mackerras wrote:

> Milton Miller writes:
>
>> With the new generic smp call function helpers, I noticed the code in
>> smp_message_recv was a single function call in many cases.  While
>> getting the message number from the ipi data is easy, we can reduce
>> the path length by a function and data dependent switch by registering
>> separate ipi actions for these simple calls.
>
> With this I get:
>
>   CC      arch/powerpc/kernel/smp.o
> arch/powerpc/kernel/smp.c: In function 'smp_request_message_ipi':
> arch/powerpc/kernel/smp.c:177: error: 'ipi_names' undeclared (first 
> use in this function)
> arch/powerpc/kernel/smp.c:177: error: (Each undeclared identifier is 
> reported only once
> arch/powerpc/kernel/smp.c:177: error: for each function it appears in.)
> make[2]: *** [arch/powerpc/kernel/smp.o] Error 1
>
> I think you need smp_ipi_name rather than ipi_names here:
>
>> +	WARN(err < 0, "unable to request_irq %d for %s (rc %d)\n",
>> +		virq, ipi_names[msg], err);
>

You are exactly correct.  I changed my mind on the name of this 
varable, and missed this spot on the final edit.  However, my compile 
passed because it was during the time that the powerpc version of WARN 
was never evaluating its printf arguments.

I wrote and compile tested the change, but need to find or setup a 
mailer to send it.

milton
