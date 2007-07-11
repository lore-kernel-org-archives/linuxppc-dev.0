Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EC30DDE19
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 10:16:27 +1000 (EST)
In-Reply-To: <18066.63111.703924.714899@cargo.ozlabs.ibm.com>
References: <20070709214853.GA29912@ld0162-tx32.am.freescale.net>
	<18066.63111.703924.714899@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6BAF4A2-B82D-4A69-A4AD-AE797DAE531C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Date: Wed, 11 Jul 2007 02:16:15 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> In older versions of glibc (through 2.3), the dynamic linker  
>> executes a
>> small amount of code from the data segment, which is not marked as
>> executable.  A recent change (commit  
>> 9ba4ace39fdfe22268daca9f28c5df384ae462cf)
>> stops this from working; there should be a deprecation period before
>> older glibc versions stop working.
>
> Actually I see no good reason to enforce no-exec at all if we can't do
> it consistently.  And if we're not going to enforce it then there is
> no point whinging about it.

I have a new patch with just this behaviour, Scott is
testing it on old glibc (I think it succeeded, need
confirmation though), I'll have it tested on new glibc
tomorrow.  So patch tomorrow, and let's try to forget
about all this after that, eh?  :-)

> When I applied Segher's original patch I thought that we had the
> read-implies-exec stuff enabled for the affected CPUs, but it turns
> out we don't.  (We only have that stuff turned on for 32-bit processes
> on 64-bit cpus - see elf_read_implies_exec in include/asm-powerpc/ 
> elf.h.)

I never thought "real code" would rely on executing stuff
it didn't map as executable before.  Silly me.  In my
defense, no one else noticed in time either ;-)


Segher
