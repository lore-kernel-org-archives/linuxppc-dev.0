Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS39b72mjzDvQb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 21:40:35 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 144so6302407pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 02:40:35 -0800 (PST)
Subject: Re: [PATCH kernel v6 5/7] vfio/spapr: Postpone default window creation
To: David Gibson <david@gibson.dropbear.id.au>
References: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
 <1479966490-8739-6-git-send-email-aik@ozlabs.ru>
 <20161125043904.GE12287@umbus.fritz.box>
 <2ef5c5f2-fbc7-6d25-93c9-fe225e10669c@ozlabs.ru>
 <20161125113713.GN12287@umbus.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ca95105a-1f86-b83d-eacf-05f6a757390a@ozlabs.ru>
Date: Mon, 28 Nov 2016 21:40:26 +1100
MIME-Version: 1.0
In-Reply-To: <20161125113713.GN12287@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FEKhTDAORuUq6K2bnHt6SA701r3fF8qnv"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FEKhTDAORuUq6K2bnHt6SA701r3fF8qnv
Content-Type: multipart/mixed; boundary="uHRM5s3Wm0vtaXJCIf4JsoF8mMdhGudF5";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org
Message-ID: <ca95105a-1f86-b83d-eacf-05f6a757390a@ozlabs.ru>
Subject: Re: [PATCH kernel v6 5/7] vfio/spapr: Postpone default window
 creation
References: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
 <1479966490-8739-6-git-send-email-aik@ozlabs.ru>
 <20161125043904.GE12287@umbus.fritz.box>
 <2ef5c5f2-fbc7-6d25-93c9-fe225e10669c@ozlabs.ru>
 <20161125113713.GN12287@umbus.fritz.box>
In-Reply-To: <20161125113713.GN12287@umbus.fritz.box>

--uHRM5s3Wm0vtaXJCIf4JsoF8mMdhGudF5
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 25/11/16 22:37, David Gibson wrote:
> On Fri, Nov 25, 2016 at 05:38:26PM +1100, Alexey Kardashevskiy wrote:
>> On 25/11/16 15:39, David Gibson wrote:
>>> On Thu, Nov 24, 2016 at 04:48:08PM +1100, Alexey Kardashevskiy wrote:=

>>>> We are going to allow the userspace to configure container in
>>>> one memory context and pass container fd to another so
>>>> we are postponing memory allocations accounted against
>>>> the locked memory limit. One of previous patches took care of
>>>> it_userspace.
>>>>
>>>> At the moment we create the default DMA window when the first group =
is
>>>> attached to a container; this is done for the userspace which is not=

>>>> DDW-aware but familiar with the SPAPR TCE IOMMU v2 in the part of me=
mory
>>>> pre-registration - such client expects the default DMA window to exi=
st.
>>>>
>>>> This postpones the default DMA window allocation till one of
>>>> the folliwing happens:
>>>> 1. first map/unmap request arrives;
>>>> 2. new window is requested;
>>>> This adds noop for the case when the userspace requested removal
>>>> of the default window which has not been created yet.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>
>>> Hmm.. it just occurred to me: why do you even need to delay creation
>>> of the default window?
>>
>>
>> Because I want to account the memory it uses in locked_vm of the mm wh=
ich
>> will later be used for map/unmap.
>=20
> Ah, good point.  How is the locked vm accounted for the non ddw case.


When ioctl(ENABLE) is processed, the SPAPR TCE driver increments it. The
DDW case does not use ENABLE, the memory preregistration is used instead.=




--=20
Alexey


--uHRM5s3Wm0vtaXJCIf4JsoF8mMdhGudF5--

--FEKhTDAORuUq6K2bnHt6SA701r3fF8qnv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYPAmaDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5Q1UQAL0A
7o/0IRPOAi8aqgZOjbZagevdLU7JR7GtkRl7SY7EvWT13AgbOw3ZM7DjDdD/dPNG
4wUCIGNdos2SXDk7TUH/LUx8bBD5sww4glOX5iBufFFlPoMvP1Wmpwl2XSHAf3Ix
HIvz+TF5vCSV3y0ghbH0vOsOSKmusrUYPzviHgfLTgyvB/qgR3WBygYRl/sX1R0t
lKC+I5G9gsvbHkD02KjzgvPZB2eFjQZxepEx5CLP5THWtFRImxVJW303C3Hqelu9
uLfSbiupY4xqpEEc6juYXKk2mFVwrJ6CnuPlQvDafpVbzwoxc6RDtoyXtBPX0rus
/S/lkk2BrWCuM2l+/Q5COCx6kjfd1oqwqaQZRpOUc5eegzW3cxgbSR8E3e5YIZAI
mE8a4rwLFaemdvR09NvR02V1rf9AeZ8wpcJZd28ky0wvi87rMjAJSPjh3MBBryvj
JlHcvmRzL0S+hGrFAZnd6nL48JN0SPZSv9jnwx5+0pngwZ75xWV8eAMGwFmMWhiQ
Oj94E4lIC4Z3wStVs284BMl3mYkTuguAKSzc9NisQMxTwg6XAPcF61HguanzmGsc
cb3Mh2qYdZOD4HABGtwtuiGkmH8xZhI2gilSg9s+CyqjFiC0doFXjuzGs2GaE93H
1qf2oOWEFkZyzpH0O6PXvuVUYdwU/DDUulZDMAuA
=V34p
-----END PGP SIGNATURE-----

--FEKhTDAORuUq6K2bnHt6SA701r3fF8qnv--
