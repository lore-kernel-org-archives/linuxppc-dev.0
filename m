Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id AAC35B70B3
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Nov 2009 09:38:11 +1100 (EST)
Message-ID: <4AF4A554.9010000@ru.mvista.com>
Date: Sat, 07 Nov 2009 01:38:12 +0300
From: Valentine <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/ppc64: Use preempt_schedule_irq instead of
	preempt_schedule
References: <20091019182858.GA10495@ru.mvista.com>	
	<1256601324.2076.49.camel@pasglop>
	<1256622077.11607.85.camel@pasglop>	
	<4AE89936.6080803@ru.mvista.com>
	<1256761844.26770.2.camel@pasglop>	
	<4AE8B761.3090902@ru.mvista.com>
	<1256765834.26770.6.camel@pasglop>	
	<4AE8CA95.7060402@ru.mvista.com>
	<1256777373.26770.14.camel@pasglop>
In-Reply-To: <1256777373.26770.14.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> Yes, the MSR_EE is cleared before we jump to do_work. I'm OK with 
>> clearing the hardirqenable flag. I just assumed that the hardirq flag 
>> was supposed to reflect the MSR_EE state, so it looked a bit odd 
>> clearing the MSR_EE at one place and then reflecting the change at another.
> 
> Yeah well, it is supposed to reflect EE in the "general case", it's just
> that in the exception entry/exit, we take shortcuts when turning EE off
> for short amount of times without reflecting it in the PACA. This is
> why, in this case, since we are going back to C code, I want to have it
> "fixed up" to reflect reality.
> 

Ben, this one works fine. Are you going to pick it?

Thanks,
Val.
