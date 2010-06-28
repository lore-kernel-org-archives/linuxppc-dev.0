Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 1B37FB7086
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 18:23:13 +1000 (EST)
Subject: Re: [PATCH 18/26] KVM: PPC: KVM PV guest stubs
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4C285A13.8070208@redhat.com>
Date: Mon, 28 Jun 2010 10:23:09 +0200
Message-Id: <AD79CD04-74CF-49B9-BACC-4C190DF5214A@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-19-git-send-email-agraf@suse.de>
	<4C282794.1040209@ozlabs.org>
	<168E1B5F-44F7-4FF5-80A5-64B0E2E94D68@suse.de>
	<4C285A13.8070208@redhat.com>
To: Avi Kivity <avi@redhat.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org,
	Matt Evans <matt@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.06.2010, at 10:15, Avi Kivity wrote:

> On 06/28/2010 09:33 AM, Alexander Graf wrote:
>>=20
>>> Could you do something similar in module_finalize() to patch loaded =
modules' .text sections?
>>>    =20
>> I could, but do we need it? I objdump -d | grep'ed all my modules and =
didn't find any need to do so.
>>  =20
>=20
> You mean even kvm.ko doesn't use privileged instructions?

It does, but I don't think it's worth speeding those up. There are only =
a couple. Most of the privileged instructions in PPC KVM are statically =
compiled into the kernel because we need to guarantee they're in the RMO =
(first 8MB for the PS3).

Even with the magic page in use, trapping instructions still works =
exactly as before, so we're only talking about a speed difference.


Alex
