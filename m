Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16F171007D3
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2012 20:27:13 +1100 (EST)
References: <20111220102142.GB5626@bloggs.ozlabs.ibm.com>
 <20111220102257.GC5626@bloggs.ozlabs.ibm.com>
 <1A57B98F-A4C7-457D-A52A-4F67D5902E32@suse.de> <20120117055654.GB9170@drongo>
In-Reply-To: <20120117055654.GB9170@drongo>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <6D049B19-8A91-445A-9FBB-E4851D4F586E@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 1/2] KVM: PPC: Book3S HV: Make virtual processor area
 registration more robust
Date: Tue, 17 Jan 2012 10:27:26 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 17.01.2012, at 06:56, Paul Mackerras <paulus@samba.org> wrote:

> On Mon, Jan 16, 2012 at 02:04:29PM +0100, Alexander Graf wrote:
>>=20
>> On 20.12.2011, at 11:22, Paul Mackerras wrote:
>=20
>>> @@ -152,6 +152,8 @@ static unsigned long do_h_register_vpa(struct kvm_vc=
pu *vcpu,
>>>    flags &=3D 7;
>>>    if (flags =3D=3D 0 || flags =3D=3D 4)
>>=20
>> This could probably use a new variable name. Also, what do 0 and 4 mean? C=
onstant defines would be nice here.
>=20
> Those constants are defined in PAPR as being a subfunction code
> indicating what sort of area and whether it is to be registered or
> unregistered.  I'll make up some names for them.
>=20
>> [pasted from real source]
>>>                va =3D kvmppc_pin_guest_page(kvm, vpa, &nb);
>>=20
>> Here you're pinning the page, setting va to that temporarily available ad=
dress.
>=20
> Well, it's not just temporarily available, it's available until we
> unpin it, since we increment the page count, which inhibits migration.
>=20
>>>            len =3D *(unsigned int *)(va + 4);
>>=20
>> va + 4 isn't really descriptive. Is this a defined struct? Why not actual=
ly define one which you can just read data from? Or at least make this a def=
ine too. Reading random numbers in code is barely readable.
>=20
> It's not really a struct, at least not one that is used for anything
> else.  PAPR defines that the length of the buffer has to be placed in
> the second 32-bit word at registration time.
>=20
>>=20
>>> +        free_va =3D va;
>>=20
>> Now free_va is the temporarily available address.
> ...
>>> +        free_va =3D tvcpu->arch.next_vpa;
>>> +        tvcpu->arch.next_vpa =3D va;
>>=20
>> Now you're setting next_vpa to this temporarily available address? But ne=
xt_vpa will be used after va is getting free'd, no? Or is that why you have f=
ree_va?
>=20
> Yes; here we are freeing any previously-set value of next_vpa.  The
> idea of free_va is that it is initially set to va so that we correctly
> unpin va if any error occurs.  But if there is no error, va gets put
> into next_vpa and we free anything that was previously in next_vpa
> instead.
>=20
>>=20
>> Wouldn't it be easier to just map it every time we actually use it and on=
ly shove the GPA around? We could basically save ourselves a lot of the logi=
c here.
>=20
> There are fields in the VPA that we really want to be able to access
> from real mode, for instance the fields that indicate whether we need
> to save the FPR and/or VR values.  As far as the DTL is concerned, we
> could in fact use copy_to_user to access it, so it doesn't strictly
> need to be pinned.  We don't currently use the slb_shadow buffer, but
> if we did we would need to access it from real mode, since we would be
> reading it in order to set up guest SLB entries.
>=20
> The other thing is that the VPA registration/unregistration is only
> done a few times in the life of the guest, whereas we use the VPAs
> constantly while the guest is running.  So it is more efficient to do
> more of the work at registration time to make it quicker to access the
> VPAs.

The thing I was getting at was not the map during the lifetime, but the map d=
uring registration. Currently we have:

1) Set VPA to x
2) Assign feature y to VPA
3) Use VPA

1 and 2 are the slow path, 3 occurs more frequently. So we want 3 to be fast=
. 1 and 2 don't matter that much wrt performance.

You are currently mapping the VPA at /, which gets you into this map/unmap m=
ess trying to free the previous mapping. If you moved the map to step 2 and o=
nly stored the GPA at step 1, all map+unmap operations except for final unma=
ps would be in one spot, so you wouldn't need to construct this big complex s=
tate machine.

I hope that makes it more clear :)

Alex

>=20
> I'll send revised patches.  There's a small change I want to make to
> patch 2 to avoid putting a very large stolen time value in the first
> entry that gets put in after the DTL is registered, which can happen
> currently if the DTL gets registered some time after the guest started
> running.
>=20
> Paul.
