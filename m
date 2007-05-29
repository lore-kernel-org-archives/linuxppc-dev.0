Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D93EDE009
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 23:31:28 +1000 (EST)
In-Reply-To: <1180438885.19517.157.camel@localhost.localdomain>
References: <20070529064533.CA8C4DDFF8@ozlabs.org>
	<20070529113232.GA6071@lst.de>
	<1180438885.19517.157.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <45D20D41-E3AE-4812-BB30-2610FD54DC67@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH 4/5] powerpc: Make syscall restart code more common
Date: Tue, 29 May 2007 08:30:30 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, ulrich.weigand@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 29, 2007, at 6:41 AM, Benjamin Herrenschmidt wrote:

> On Tue, 2007-05-29 at 13:32 +0200, Christoph Hellwig wrote:
>> On Tue, May 29, 2007 at 04:45:23PM +1000, Benjamin Herrenschmidt
>> wrote:
>>> +static inline void check_syscall_restart(struct pt_regs *regs,
>>> +                                      struct k_sigaction *ka,
>>> +                                      int has_handler)
>>> +{
>>
>> I don't think this should be inlined.  Just create a new signal.c
>> file,
>> which can grow a lot more common signal code later on aswell.
>
> I've been thinking about doing that too. In fact, some of the
> ptrace-common.h stuff should probably be turned back into ptrace.c too
> for the same reason. I'm still toying with that part of the designm  
> but
> yeah, I think that's something to do.

I think this makes sense for the ptrace code as well.  Eventually  
we'll end up moving or supporting some of the 'features' that only  
exist on one platform or the other in both.  I can see us supporting  
PTRACE_{GET,SET}_DEBUGREG on ppc32 and we'll need to support the  
BOOKE stuff on ppc64.

- k
