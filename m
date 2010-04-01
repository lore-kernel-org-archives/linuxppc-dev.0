Return-Path: <Gavin.Shan@alcatel-lucent.com>
Received: from cnshjsmin03.cn.alcatel-lucent.com (unknown [211.144.215.47])
	by ozlabs.org (Postfix) with ESMTP id 3FA83B7C67
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 14:19:31 +1100 (EST)
Message-ID: <4BB4109E.8020607@alcatel-lucent.com>
Date: Thu, 01 Apr 2010 11:18:54 +0800
From: gshan <Gavin.Shan@alcatel-lucent.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: spin_lock_irqsave and multi-core
References: <4BB3FE05.6040800@alcatel-lucent.com>	
	<1270089545.7101.84.camel@pasglop>
	<4BB407F6.3070106@alcatel-lucent.com>
	<1270090589.7101.86.camel@pasglop>
In-Reply-To: <1270090589.7101.86.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>
> Then your driver is most certainly doing something wrong :-) No driver
> needs that. Ever.
>
> What is it trying to do more precisely ? I might be able to explain what
> the right approach is if you can tell me what the driver is trying to
> disable all system IRQs for ? Keep in mind that local_irq_save() does a
> lot more than just masking external interrupts from your device. It
> masks them from -all- devices, including timer interrupts, perfmon
> interrupts, etc... Doing so on all cores is generally a big no-no and
> almost never really necessary.
>   
I agree with you. Actually, I can disable the individual interrupt via 
disable_irq_sync() to make sure
system cooherence. It's just my concern when reading kernel source. 
Anyway, thanks a lot
for your kindly answer.

Thanks,
Gavin
> Cheers,
> Ben.
>
>
>   
