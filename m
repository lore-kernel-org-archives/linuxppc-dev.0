Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41997B6F7C
	for <linuxppc-dev@ozlabs.org>; Sat, 28 May 2011 06:58:04 +1000 (EST)
In-Reply-To: <20110527103334.GA4236@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104456.GK2837@brick.ozlabs.ibm.com>
	<BDD550B2-02CA-4B1A-A05B-6CB3EF89B7B3@suse.de>
	<20110516055809.GA3590@drongo>
	<D8CAE971-9A97-4C02-8908-2B199C81947A@suse.de>
	<20110527103334.GA4236@brick.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b833d9df4fc8e1e6a8b6a56311c6f344@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/13] kvm/powerpc: Add support for Book3S processors in
	hypervisor mode
Date: Fri, 27 May 2011 22:59:41 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, kvm-ppc@vger.kernel.org,
	KVM list <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> I do the check there because I was having problems where, if the HDEC
>>> goes negative before we do the partition switch, we would 
>>> occasionally
>>> not get the HDEC interrupt at all until the next time HDEC went
>>> negative, ~ 8.4 seconds later.
>>
>> Yikes - so HDEC is edge and doesn't even keep the interrupt line up?
>> That sounds like a serious hardware limitation. What if you only use
>> HDEC and it triggers while interrupts are off in a critical section?
>> Is the hardware really that broken?
>
> If HDEC expires when interrupts are off, the HDEC interrupt stays
> pending until interrupts get re-enabled.  I'm not sure exactly what
> the conditions are that cause an HDEC interrupt to get lost, but they
> seem to involve at least a partition switch.

On some CPUs, if the top bit of the decrementer is 0 again when you 
re-enable
the interrupt, the interrupt is lost (so it is actually 
level-triggered).
The arch books talk a bit about this AFAIR.


Segher
