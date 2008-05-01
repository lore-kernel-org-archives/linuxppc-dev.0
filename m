Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DCA3CDDE16
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 23:22:13 +1000 (EST)
Message-Id: <CF55CEE2-CAF5-4728-947E-C1C37E262EDB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1209628423.18023.286.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
Date: Thu, 1 May 2008 08:22:08 -0500
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
	<A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
	<1209628423.18023.286.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> So we have 4 actual exceptions:
>> * CriticalInput (some external device signaled this.  There are two
>> concepts of critical.  One is error the other is high priority)
>> However this would have the same caveats as any ExternalInput  
>> handler.
>
> No, it's worse. It can interrupt code that normally has
> local_irq_disabled() and thus doesn't expect to be interrupted. That
> means that everything becomes unsafe including locks etc....

Fair.  Should local_irq_disable() clear MSR_SE & MSR_BE on classic  
parts?

> Note that driver that want to make active use of that probably want  
> some
> explicit local_crit_irq_disable/enable functions to be able to  
> implement
> some sort of synchronization.

Or we could just have local_irq_disable -- clear MSR_EE and MSR_CE

>> * Watchdog - pretty severe if this fires.
>>
>> * Debug - user space debug is pretty straight forward.  However we
>> have features like kprobes that require kernel level support.
>
> Which means we have to be extra careful, in fact, I consider it a  
> design
> bug of BookE to have made debug be a critical interrupt...

I consider the whole BookE debug arch a design bug :)

- k
