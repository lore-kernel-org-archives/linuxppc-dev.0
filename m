Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F19FB6F8F
	for <linuxppc-dev@ozlabs.org>; Sat, 28 May 2011 11:05:27 +1000 (EST)
In-Reply-To: <6A1CA2C8-8032-4D67-9C14-4ABD81ABCDD7@suse.de>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104456.GK2837@brick.ozlabs.ibm.com>
	<BDD550B2-02CA-4B1A-A05B-6CB3EF89B7B3@suse.de>
	<20110516055809.GA3590@drongo>
	<D8CAE971-9A97-4C02-8908-2B199C81947A@suse.de>
	<20110527103334.GA4236@brick.ozlabs.ibm.com>
	<b833d9df4fc8e1e6a8b6a56311c6f344@kernel.crashing.org>
	<6A1CA2C8-8032-4D67-9C14-4ABD81ABCDD7@suse.de>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <10cc079a31947ec4b6d39f30f2ac50f2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/13] kvm/powerpc: Add support for Book3S processors in
	hypervisor mode
Date: Sat, 28 May 2011 03:07:04 +0200
To: Alexander Graf <agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	kvm-ppc@vger.kernel.org, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> If HDEC expires when interrupts are off, the HDEC interrupt stays
>>> pending until interrupts get re-enabled.  I'm not sure exactly what
>>> the conditions are that cause an HDEC interrupt to get lost, but they
>>> seem to involve at least a partition switch.
>>
>> On some CPUs, if the top bit of the decrementer is 0 again when you 
>> re-enable
>> the interrupt, the interrupt is lost (so it is actually 
>> level-triggered).
>> The arch books talk a bit about this AFAIR.
>
> Sure, but that shouldn't happen with HDEC during the odd 50 
> instructions that it takes to enter the guest :)

It's more like 500 insns, including some ptesync, so lots of cycles too.
Can another hardware thread be running at the same time?


Segher
