Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2A79DDDE7
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 10:06:08 +1100 (EST)
Message-Id: <EAAB7B1A-49DC-4D61-A76F-F87C777566D8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1228253423.7356.195.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH][for 2.6.28] powerpc: Use physical cpu id when setting the
	processor affinity
Date: Tue, 2 Dec 2008 17:05:25 -0600
References: <1228246621-25622-1-git-send-email-galak@kernel.crashing.org>
	<1228253423.7356.195.camel@pasglop>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 2, 2008, at 3:30 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2008-12-02 at 13:37 -0600, Kumar Gala wrote:
>> In the CONFIG_SMP case the irq_choose_cpu() code was returning back
>> a logical cpu id not the physical id.  We were writing that directly
>> into the HW register.
>>
>> We need to be calling get_hard_smp_processor_id() so irq_choose_cpu()
>> always returns a physical cpu id.
>
> That will probably do for now but if we ever move that routine to
> generic code, I'd rather have the caller do the conversion.

Fair.. I felt at this point matching what the !CONFIG_SMP case of  
irq_choose_cpu() is doing was the best choice.

- k
