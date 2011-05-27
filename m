Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53F5FB6F82
	for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2011 20:43:17 +1000 (EST)
Subject: Re: [PATCH 10/13] kvm/powerpc: Add support for Book3S processors in
	hypervisor mode
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110527103334.GA4236@brick.ozlabs.ibm.com>
Date: Fri, 27 May 2011 12:43:10 +0200
Message-Id: <196413A8-500A-4A72-99D2-7ED7E3BBD056@suse.de>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104456.GK2837@brick.ozlabs.ibm.com>
	<BDD550B2-02CA-4B1A-A05B-6CB3EF89B7B3@suse.de>
	<20110516055809.GA3590@drongo>
	<D8CAE971-9A97-4C02-8908-2B199C81947A@suse.de>
	<20110527103334.GA4236@brick.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, kvm-ppc@vger.kernel.org,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 27.05.2011, at 12:33, Paul Mackerras wrote:

> On Tue, May 17, 2011 at 12:17:50PM +0200, Alexander Graf wrote:
>>=20
>> On 16.05.2011, at 07:58, Paul Mackerras wrote:
>>=20
>>> I do the check there because I was having problems where, if the =
HDEC
>>> goes negative before we do the partition switch, we would =
occasionally
>>> not get the HDEC interrupt at all until the next time HDEC went
>>> negative, ~ 8.4 seconds later.
>>=20
>> Yikes - so HDEC is edge and doesn't even keep the interrupt line up?
>> That sounds like a serious hardware limitation. What if you only use
>> HDEC and it triggers while interrupts are off in a critical section?
>> Is the hardware really that broken?
>=20
> If HDEC expires when interrupts are off, the HDEC interrupt stays
> pending until interrupts get re-enabled.  I'm not sure exactly what
> the conditions are that cause an HDEC interrupt to get lost, but they
> seem to involve at least a partition switch.

Please try to contact some of your hardware designers and figure out =
what exactly the conditions are. Maybe we don't need this hack.

Alex
