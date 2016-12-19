Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thtNf2vsxzDwCT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 18:49:38 +1100 (AEDT)
Subject: Re: [PATCH 06/11] powerpc/kvm: Allow KVM_PPC_ALLOCATE_HTAB ioctl() to
 change HPT size
To: David Gibson <david@gibson.dropbear.id.au>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-7-david@gibson.dropbear.id.au>
 <6c2566ea-cc80-4c02-27a2-258284d8f98b@redhat.com>
 <20161219004809.GL12146@umbus.fritz.box>
Cc: paulus@samba.org, michael@ellerman.id.au, benh@kernel.crashing.org,
 sjitindarsingh@gmail.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <51db41a4-f779-2c4a-5434-839c55025114@redhat.com>
Date: Mon, 19 Dec 2016 08:49:24 +0100
MIME-Version: 1.0
In-Reply-To: <20161219004809.GL12146@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vFtJE81DFcCJsoQadBIfTAI8LUwnFqdN7"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vFtJE81DFcCJsoQadBIfTAI8LUwnFqdN7
Content-Type: multipart/mixed; boundary="XsrrnpcPdf2SvKTVCqpvwD37wvDWWfQCo";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, michael@ellerman.id.au, benh@kernel.crashing.org,
 sjitindarsingh@gmail.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Message-ID: <51db41a4-f779-2c4a-5434-839c55025114@redhat.com>
Subject: Re: [PATCH 06/11] powerpc/kvm: Allow KVM_PPC_ALLOCATE_HTAB ioctl() to
 change HPT size
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-7-david@gibson.dropbear.id.au>
 <6c2566ea-cc80-4c02-27a2-258284d8f98b@redhat.com>
 <20161219004809.GL12146@umbus.fritz.box>
In-Reply-To: <20161219004809.GL12146@umbus.fritz.box>

--XsrrnpcPdf2SvKTVCqpvwD37wvDWWfQCo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.12.2016 01:48, David Gibson wrote:
> On Fri, Dec 16, 2016 at 01:44:57PM +0100, Thomas Huth wrote:
>> On 15.12.2016 06:53, David Gibson wrote:
>>> The KVM_PPC_ALLOCATE_HTAB ioctl() is used to set the size of hashed p=
age
>>> table (HPT) that userspace expects a guest VM to have, and is also us=
ed to
>>> clear that HPT when necessary (e.g. guest reboot).
>>>
>>> At present, once the ioctl() is called for the first time, the HPT si=
ze can
>>> never be changed thereafter - it will be cleared but always sized as =
from
>>> the first call.
>>>
>>> With upcoming HPT resize implementation, we're going to need to allow=

>>> userspace to resize the HPT at reset (to change it back to the defaul=
t size
>>> if the guest changed it).
>>>
>>> So, we need to allow this ioctl() to change the HPT size.
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
[...]
>>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/b=
ook3s_64_mmu_hv.c
>>> index 68bb228..8e5ac2f 100644
>>> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
>>> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>>> @@ -104,10 +104,22 @@ void kvmppc_set_hpt(struct kvm *kvm, struct kvm=
_hpt_info *info)
>>>  		info->virt, (long)info->order, kvm->arch.lpid);
>>>  }
>>> =20
>>> -long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
>>> +void kvmppc_free_hpt(struct kvm_hpt_info *info)
>>> +{
>>> +	vfree(info->rev);
>>> +	if (info->cma)
>>> +		kvm_free_hpt_cma(virt_to_page(info->virt),
>>> +				 1 << (info->order - PAGE_SHIFT));
>>> +	else
>>> +		free_pages(info->virt, info->order - PAGE_SHIFT);
>>> +	info->virt =3D 0;
>>> +	info->order =3D 0;
>>> +}
>>
>> Why do you need to move kvmppc_free_hpt() around? Seems like unecessar=
y
>> code churn to me?
>=20
> Previously, kvmppc_free_hpt() wasn't needed in
> kvmppc_alloc_reset_hpt(), now it is.  So we need to move it above that
> function.  I could move it in the previous patch, but that would
> obscure what the actual changes are to it, so it seemed better to do
> it here.

kvmppc_free_hpt() is not a static function, there is a prototype in a
header for this somewhere, so as far as I can see, it should also work
without moving this function?

[...]
>>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_h=
v.c
>>> index 71c5adb..957e473 100644
>>> --- a/arch/powerpc/kvm/book3s_hv.c
>>> +++ b/arch/powerpc/kvm/book3s_hv.c
>>> @@ -3600,12 +3600,9 @@ static long kvm_arch_vm_ioctl_hv(struct file *=
filp,
>>>  		r =3D -EFAULT;
>>>  		if (get_user(htab_order, (u32 __user *)argp))
>>>  			break;
>>> -		r =3D kvmppc_alloc_reset_hpt(kvm, &htab_order);
>>> +		r =3D kvmppc_alloc_reset_hpt(kvm, htab_order);
>>>  		if (r)
>>>  			break;
>>> -		r =3D -EFAULT;
>>> -		if (put_user(htab_order, (u32 __user *)argp))
>>> -			break;
>>
>> Now that htab_order is not changed anymore by the kernel, I'm pretty
>> sure you need some checks on the value here before calling
>> kvmppc_alloc_reset_hpt(), e.g. return an error code if htab_order <
>> PPC_MIN_HPT_ORDER.
>=20
> Right.  I've done that by putting the checks into
> kvmppc_allocate_hpt() in the earlier patch.
>=20
>> And, I'm not sure if I got that right, but in former times, the
>> htab_order from the userspace application was just a suggestion, and n=
ow
>> it's mandatory, right? So if an old userspace used a very high value
>> here (or even something smaller than PPC_MIN_HPT_ORDER like 0), the
>> kernel fixed this up and the userspace could run happily with the fixe=
d
>> value afterwards. But since this value from userspace if mandatory now=
,
>> such an userspace application is broken now. So maybe it's better to
>> introduce a new ioctl for this new behavior instead, to avoid breaking=

>> old userspace applications?
>=20
> A long time ago it was just a hint.  However, that behaviour was
> already changed in 572abd5 "KVM: PPC: Book3S HV: Don't fall back to
> smaller HPT size in allocation ioctl".  This is important: without
> that we could get a different HPT size on the two ends of a migration,
> which broke things nastily.

OK, makes sense, especially if the userspace provided an order. But if I
get that patch right, it was still possible to call with order =3D=3D 0 t=
o
get the automatic sizing? Do we need to preserve that behavior for some
very old userspace applications?

 Thomas



--XsrrnpcPdf2SvKTVCqpvwD37wvDWWfQCo--

--vFtJE81DFcCJsoQadBIfTAI8LUwnFqdN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYV5EKAAoJEC7Z13T+cC21V/sQAI11IovHUWMLgEm4zhWZWrqR
fv6eLU5hIvCd6Z/ok8CeLcnt3Soz9mz6CHoP3YfxxBJYh84FkWJBuwXgn6W39Gis
0I8Kn2nrpdzETqy3TNcL2BX5DOGzT3/zAX+hmXa7zMhPEtuVSX7jW4hwwiGK85S7
svuhgGS3TKoMPXl/ADK+eDfTgsjyH7mRoB7L4QKMGWA74oJMzKBOFMoVScHRiL++
09XWF4oBXt5r5BtSVKfZDyB+f2WRYcvu8mk+ibpAq8fIg5IR9ZD5nrvyZre3vskw
N8wwXPbMytoFQJN8TLg3si7m8uGqfjQo8rezKH7jHZlPSLx7i8Xfu+bLAyiH0yOS
rMY1Vle8msCzpV4mtzjlB2kNkTs6VYvWokIqUAhl7n6t1U9CsMxOK4BkGco592lG
qfeioGA568GwEurk/B4i0c2y4PTUyokBgKQhDGuew8rMime8rAkFnTSyaoLll+/4
O77+RCre1TNNpzH02CwBBHong8HLrfa62olnwyRsBldLnJlcam7bL/FVglSX2f0Z
bZAUlPHaL7shY7cETr+W8g7oTrHkxN1UAdc6FrFAw4LHDJ+9P/vkO3wRn/NHxm9t
z+CSYZdspLhuV/uUPlbs49K6G3iWB0mjtpn2tNwzB4D+QubBmkkf8FaRBIdB9HDN
zOOLmXu3pKz97Z//VQK9
=AP5s
-----END PGP SIGNATURE-----

--vFtJE81DFcCJsoQadBIfTAI8LUwnFqdN7--
