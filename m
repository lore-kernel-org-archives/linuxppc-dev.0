Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwbPp3jwVzDrWC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 16:17:01 +1000 (AEST)
Subject: Re: [PATCH] KVM: PPC: fix oops when checking KVM_CAP_PPC_HTM
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Sam Bobroff <sam.bobroff@au1.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
References: <150542618501.6859.11512107352972110416.stgit@bahia.lan>
 <20170915004839.GA5250@umbus.fritz.box> <20170915075249.0e9879a4@bahia.lan>
 <20170915085937.GO5250@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <29d31b9f-1b24-a2d4-5dff-756cd38025d6@redhat.com>
Date: Mon, 18 Sep 2017 08:16:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170915085937.GO5250@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="c2h3i5V78rXOhfMqcS1tIgiDPCOuLcGKC"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c2h3i5V78rXOhfMqcS1tIgiDPCOuLcGKC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.09.2017 10:59, David Gibson wrote:
> On Fri, Sep 15, 2017 at 07:52:49AM +0200, Greg Kurz wrote:
>> Dang! The mail relay at OVH has blacklisted Paul's address :-\
>>
>> <paulus@samba.org>: host smtp.samba.org[144.76.82.148] said: 550-black=
listed at
>>     zen.spamhaus.org 550 https://www.spamhaus.org/sbl/query/SBL370982 =
(in reply
>>     to RCPT TO command)
>>
>> Cc'ing Paul at ozlabs.org
>>
>> On Fri, 15 Sep 2017 10:48:39 +1000
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>
>>> On Thu, Sep 14, 2017 at 11:56:25PM +0200, Greg Kurz wrote:
>>>> The following program causes a kernel oops:
>>>>
>>>> #include <sys/types.h>
>>>> #include <sys/stat.h>
>>>> #include <fcntl.h>
>>>> #include <sys/ioctl.h>
>>>> #include <linux/kvm.h>
>>>>
>>>> main()
>>>> {
>>>>     int fd =3D open("/dev/kvm", O_RDWR);
>>>>     ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_PPC_HTM);
>>>> }
>>>>
>>>> This happens because when using the global KVM fd with
>>>> KVM_CHECK_EXTENSION, kvm_vm_ioctl_check_extension() gets
>>>> called with a NULL kvm argument, which gets dereferenced
>>>> in is_kvmppc_hv_enabled(). Spotted while reading the code.
>>>>
>>>> Let's use the hv_enabled fallback variable, like everywhere
>>>> else in this function.
>>>>
>>>> Fixes: 23528bb21ee2 ("KVM: PPC: Introduce KVM_CAP_PPC_HTM")
>>>> Cc: stable@vger.kernel.org # v4.7+
>>>> Signed-off-by: Greg Kurz <groug@kaod.org> =20
>>>
>>> I don't think this is right.  I'm pretty sure you want to fall back t=
o
>>> hv_enabled *only when* kvm is NULL.  Otherwise if you have a PR guest=

>>> on an HV capable machine, this will give the wrong answer, when calle=
d
>>> for that specific VM.
>>>
>>
>> Hmmm... this is what we get with this patch applied:
>>
>> open("/dev/kvm", O_RDWR)                =3D 3
>> ioctl(3, KVM_CHECK_EXTENSION, 0x84)     =3D 1 <=3D=3D if HV is present=

>> ioctl(3, KVM_CREATE_VM, 0x1)            =3D 4 <=3D=3D HV
>> ioctl(4, KVM_CHECK_EXTENSION, 0x84)     =3D 1
>> ioctl(3, KVM_CREATE_VM, 0x2)            =3D 5 <=3D=3D PR
>> ioctl(5, KVM_CHECK_EXTENSION, 0x84)     =3D 0
>>
>> The hv_enabled variable is set as follows:
>>
>> 	/* Assume we're using HV mode when the HV module is loaded */
>> 	int hv_enabled =3D kvmppc_hv_ops ? 1 : 0;
>>
>> 	if (kvm) {
>> 		/*
>> 		 * Hooray - we know which VM type we're running on. Depend on
>> 		 * that rather than the guess above.
>> 		 */
>> 		hv_enabled =3D is_kvmppc_hv_enabled(kvm);
>> 	}
>>
>> so we're good. :)
>=20
> Oh, sorry, missed that bit.  In that case.
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

LGTM, too:

Reviewed-by: Thomas Huth <thuth@redhat.com>


--c2h3i5V78rXOhfMqcS1tIgiDPCOuLcGKC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZv2TWAAoJEC7Z13T+cC21CLsP/1VlrgxYeklegTwvgI4oABls
Q9HOKQmFUpT7TwnIy6/zHnk1NhKXRaum9wux8tBiZy9OnRU551F+JLF5rMuOiuDz
ArGfCWRzfTuBSF1j2KpWe/w8VlNn6Rr72Sh+4eBlP0mhcbiwVo5ucn6+9vRYn15R
sAfUr5BrZZubso73ILNkrNCqKDiwJ37u//GaHWFTQXkgK0PP3hkOAXMQ45jOdje9
hM1P69adrB4elgbpxGteR9ce+w1BfgVOhiKMfW3Nuf2gEU3vbtk0y2dEmhMqrcxJ
riquRdapE1u2oIxh8x96HMvZvVaHHoUjYP984QEfAo8sN75anMbVNVMO+dtuN9U1
WTGD9wJ5TNM5VPxWyQHLdg6WzSJdy5WuU3bvLLqGpYuMq1nnO8UYYU7y2Rf1glFz
36xi6MNRVkumBwgB9PG1i9rGEKy5cribZBUgcRqcQo+xr5VY73hzeOcGVnjThGy/
/R31dRomEon6T4j28XktEJywaiyoK0kfYKH85BHMtRQO+N/Cl0Zs3q3mS9EEYpQk
wXC1r9bYhCNE9lheCHcA7UtzxI/wpHMwU/MjqnzZKYP9+olRjCzB8PXZHyUSDORs
PYjMOfZrMqKfrijad1AsqtMfBMgHmtZJMRhi9/Phwfz6APgWcXXYubO1dJ9LSHTh
tkWUdpAOHbx50qfTFakR
=ZSqF
-----END PGP SIGNATURE-----

--c2h3i5V78rXOhfMqcS1tIgiDPCOuLcGKC--
