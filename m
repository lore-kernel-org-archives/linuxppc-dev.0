Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id A77C82C030E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 22:50:10 +1000 (EST)
Subject: Re: [PATCH 8/8] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1373546233.19894.85.camel@pasglop>
Date: Thu, 11 Jul 2013 14:50:04 +0200
Message-Id: <B526C260-1ADB-4B9F-B80A-46E5A9E53FF6@suse.de>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-9-git-send-email-aik@ozlabs.ru> <51DC4923.5010501@suse.de>
 <51DE7377.1060503@ozlabs.ru> <902F79B9-BB81-40A0-865D-94E7108DAC5E@suse.de>
 <1373546233.19894.85.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.07.2013, at 14:37, Benjamin Herrenschmidt wrote:

> On Thu, 2013-07-11 at 11:52 +0200, Alexander Graf wrote:
>>> Where exactly (it is rather SPAPR_TCE_IOMMU but does not really
>> matter)?
>>> Select it on KVM_BOOK3S_64? CONFIG_KVM_BOOK3S_64_HV?
>>> CONFIG_KVM_BOOK3S_64_PR? PPC_BOOK3S_64?
>>=20
>> I'd say the most logical choice would be to check the Makefile and =
see
>> when it gets compiled. For those cases we want it enabled.
>=20
> What *what* gets compiled ? You know our Makefile, it's crap :-)
>=20
> We enable built-in things when CONFIG_KVM=3Dm (which means you cannot =
take
> a kernel build with CONFIG_KVM not set, enable CONFIG_KVM=3Dm, and =
just
> build the module, it won't work).
>=20
> We could use KVM_BOOK3S_64 maybe ?

If either a =3Dm or a =3Dy option selects a =3Dy option, it gets =
selected regardless, no? So it shouldn't really matter where we attach =
it FWIW.

>=20
>>> I am trying to imagine a configuration where we really do not want
>>> IOMMU_API. Ben mentioned PPC32 and embedded PPC64 and that's it so
>> any of
>>> BOOK3S (KVM_BOOK3S_64 is the best) should be fine, no?
>>=20
>> book3s_32 doesn't want this, but any book3s_64 implementation could
>> potentially use it, yes. That's pretty much what the Makefile tells
>> you too :).
>=20
> Not really no. But that would do. You could have give a more useful
> answer in the first place though rather than stringing him along.

Sorry, I figured it was obvious.


Alex
