Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0C940B7091
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Aug 2011 18:07:47 +1000 (EST)
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
	<1312907508-14599-10-git-send-email-agraf@suse.de>
	<20110812033343.GR30552@yookeroo.fritz.box>
	<998B41E9-23CC-4FBD-BD35-11004D77B087@suse.de>
	<20110812074359.GW30552@yookeroo.fritz.box>
In-Reply-To: <20110812074359.GW30552@yookeroo.fritz.box>
Mime-Version: 1.0 (iPhone Mail 8G4)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <1CCF5D38-7104-432E-9DD7-A5100D611735@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 09/10] KVM: PPC: Support SC1 hypercalls for PAPR in PR mode
Date: Fri, 12 Aug 2011 10:07:33 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am 12.08.2011 um 09:43 schrieb David Gibson <david@gibson.dropbear.id.au>:

> On Fri, Aug 12, 2011 at 07:35:42AM +0200, Alexander Graf wrote:
>>=20
>> Am 12.08.2011 um 05:33 schrieb David Gibson <david@gibson.dropbear.id.au>=
:
>>=20
>>> On Tue, Aug 09, 2011 at 06:31:47PM +0200, Alexander Graf wrote:
>>>> PAPR defines hypercalls as SC1 instructions. Using these, the guest mod=
ifies
>>>> page tables and does other privileged operations that it wouldn't be al=
lowed
>>>> to do in supervisor mode.
>>>>=20
>>>> This patch adds support for PR KVM to trap these instructions and route=
 them
>>>> through the same PAPR hypercall interface that we already use for HV st=
yle
>>>> KVM.
>>>=20
>>> This will work on a powermac or bare metal host.  Unfortunately, it's
>>> not enough on a pSeries LPAR host - the sc 1 instruction from the
>>> guest problem state will go direct to the hypervisor, which will
>>> return an error rather than trapping to the guest kernel.
>>>=20
>>> The only way around this I can see is for qemu to search for and patch
>>> up sc 1 instructions to something else.  Obviously that would also
>>> need some kernel support, and probably a capability to let it know if
>>> it's necessary.
>>=20
>> Well I'd like to keep Qemu out of the patching business, so the
>> guest kernel would have to patch itself.
>=20
> Well sure, but guest patching itself means it can't run existing
> kernels.  I thought qemu already patched a few things, ugly though
> that approach is.

Nope, qemu doesn't patch guest code by itself. The only time the guest kerne=
l doesn't patch itself is the TPR acceleration for Windows - because we can'=
t modify the guest here.

I also don't think it's that important to support older Linux guests if it m=
eans we need to patch the guest from the outside :). If you really need to u=
se PHyP, just run a newer guest kernel or -M mac99.

One thing I agree with though is that we should fail the CAP enable if we ru=
n on broken hypervisors.

Alex

>=20
