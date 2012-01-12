Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 685ECB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 18:11:03 +1100 (EST)
References: <20111221013443.GN8378@schlenkerla.am.freescale.net>
 <1A656B06-E290-4B75-8F98-F8FAB8B817F1@suse.de> <4F0B8B7D.4@freescale.com>
 <A1483A2E-FF86-4E25-93CC-9EA1BA4925D4@suse.de>
 <1326350666.23910.209.camel@pasglop>
In-Reply-To: <1326350666.23910.209.camel@pasglop>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <5A04869E-DC5E-4B67-88EC-978D858E12CE@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 14/16] KVM: PPC: booke: category E.HV (GS-mode) support
Date: Thu, 12 Jan 2012 08:11:11 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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



On 12.01.2012, at 07:44, Benjamin Herrenschmidt <benh@kernel.crashing.org> w=
rote:

> On Tue, 2012-01-10 at 04:11 +0100, Alexander Graf wrote:
>> This is what book3s does:
>>=20
>>                case EMULATE_FAIL:
>>                        printk(KERN_CRIT "%s: emulation at %lx failed
>> (%08x)\n",
>>                               __func__, kvmppc_get_pc(vcpu),
>> kvmppc_get_last_inst(vcpu));
>>                        kvmppc_core_queue_program(vcpu, flags);
>>                        r =3D RESUME_GUEST;
>>=20
>> which also doesn't throttle the printk, but I think injecting a
>> program fault into the guest is the most sensible thing to do if we
>> don't know what the instruction is supposed to do. Best case we get an
>> oops inside the guest telling us what broke :).
>=20
> You can also fallback to a slow path that reads the guest TLB,
> translates then reads the instruction. Of course you have to be careful
> as such a manual translate + read + execute needs to be somewhat
> synchronized with a possible TLB invalidation :-)

Well we do want to be fast on the default path though. So yes, what you're s=
aying is what book3s does, but as a fallback in case the fast path didn't wo=
rk.

The problem here however is that we don't know if the fast path failed; we o=
ops.


>=20
> (MMIO emulation is broken in this regard too btw)

Huh?

Alex

>=20
> Cheers,
> Ben.
>=20
>=20
