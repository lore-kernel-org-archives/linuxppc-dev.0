Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D66DB6F90
	for <linuxppc-dev@ozlabs.org>; Sat, 28 May 2011 09:19:50 +1000 (EST)
Subject: Re: [PATCH 10/13] kvm/powerpc: Add support for Book3S processors in
	hypervisor mode
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <b833d9df4fc8e1e6a8b6a56311c6f344@kernel.crashing.org>
Date: Sat, 28 May 2011 01:19:38 +0200
Message-Id: <6A1CA2C8-8032-4D67-9C14-4ABD81ABCDD7@suse.de>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104456.GK2837@brick.ozlabs.ibm.com>
	<BDD550B2-02CA-4B1A-A05B-6CB3EF89B7B3@suse.de>
	<20110516055809.GA3590@drongo>
	<D8CAE971-9A97-4C02-8908-2B199C81947A@suse.de>
	<20110527103334.GA4236@brick.ozlabs.ibm.com>
	<b833d9df4fc8e1e6a8b6a56311c6f344@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
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


On 27.05.2011, at 22:59, Segher Boessenkool wrote:

>>>> I do the check there because I was having problems where, if the =
HDEC
>>>> goes negative before we do the partition switch, we would =
occasionally
>>>> not get the HDEC interrupt at all until the next time HDEC went
>>>> negative, ~ 8.4 seconds later.
>>>=20
>>> Yikes - so HDEC is edge and doesn't even keep the interrupt line up?
>>> That sounds like a serious hardware limitation. What if you only use
>>> HDEC and it triggers while interrupts are off in a critical section?
>>> Is the hardware really that broken?
>>=20
>> If HDEC expires when interrupts are off, the HDEC interrupt stays
>> pending until interrupts get re-enabled.  I'm not sure exactly what
>> the conditions are that cause an HDEC interrupt to get lost, but they
>> seem to involve at least a partition switch.
>=20
> On some CPUs, if the top bit of the decrementer is 0 again when you =
re-enable
> the interrupt, the interrupt is lost (so it is actually =
level-triggered).
> The arch books talk a bit about this AFAIR.

Sure, but that shouldn't happen with HDEC during the odd 50 instructions =
that it takes to enter the guest :)

Alex
