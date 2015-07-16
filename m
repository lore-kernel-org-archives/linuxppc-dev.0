Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A3A21A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:23:58 +1000 (AEST)
Message-ID: <55A74DF9.2010100@redhat.com>
Date: Thu, 16 Jul 2015 08:23:53 +0200
From: Thomas Huth <thuth@redhat.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org, anton@samba.org, kvm-ppc@vger.kernel.org
Subject: Re: BUG: sleeping function called from ras_epow_interrupt context
References: <55A55846.5080904@redhat.com>
 <1436908977.3948.266.camel@kernel.crashing.org> <55A66F96.6030808@redhat.com>
 <55A6BB73.7050402@linux.vnet.ibm.com>
In-Reply-To: <55A6BB73.7050402@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UV9n390OnScAQCHBNF16drbgKFg3kF6Qu"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UV9n390OnScAQCHBNF16drbgKFg3kF6Qu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/15/2015 09:58 PM, Nathan Fontenot wrote:
> On 07/15/2015 09:35 AM, Thomas Huth wrote:
>> On 07/14/2015 11:22 PM, Benjamin Herrenschmidt wrote:
>>> On Tue, 2015-07-14 at 20:43 +0200, Thomas Huth wrote:
>>>> Any suggestions how to fix this? Simply revert 587f83e8dd50d? Use
>>>> mdelay() instead of msleep() in rtas_busy_delay()? Something more
>>>> fancy?
>>>
>>> A proper fix would be more fancy, the get_sensor should happen in a
>>> kernel thread instead.
>>
>> I'm not very familiar with this stuff, but isn't the EPOW interrupt
>> something that is very time-critical? Moving parts of the handler into=
 a
>> kernel thread then does not sound like a very good idea to me...
>>
>> Another question: Can it happen at all that this get-sensor call resul=
ts
>> in a sleep condition? Looking at commit ID
>> 81b73dd92b97423b8f5324a59044da478c04f4c4 ("Fix might-sleep warning on
>> removing cpus"), which apparently fixed a similar issue for CPU
>> hot-plugging, indicates that at least some of the rtas calls are never=

>> returning the busy code? In that case we could fix this by introducing=
 a
>> similar rtas_get_sensor_fast() function? (or simply revert 587f83e8dd5=
0d
>> which would be quite similar, I think)
>>
>=20
> Looking at the PAPR, the get-sensor-state rtas call for the EPOW sensor=

> is listed as a fast call and should not return a busy indication.

Great, good to know, thanks for looking that up! So IMHO we should
either introduce a rtas_get_sensor_fast() function or revert
587f83e8dd50d ... any preferences? Shall I come up with a patch?

> I'm curious as to why we're getting a busy return indication when
> making this call.

Looking at the code again, rtas_busy_delay() likely never slept ... it's
likely just the "might_sleep()" annotation in that function that causes
the BUG.

 Thomas



--UV9n390OnScAQCHBNF16drbgKFg3kF6Qu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVp035AAoJEC7Z13T+cC21tvQQALIGXTQPJHZd/QCZfGCrwZYD
Bm6D+5ILsjzu4wONZibi/Snt+i6NJPp5UMXYQIG1EseuEQGiEvP83aSr6MoJHTPd
JV0hdx2RHQRySsBg5RrhzYdkoUA5J0/IRfmGhTjz0wlcxHK7gzo39lNlcUF3saPJ
SpEBK7dP4TM4qWZcIIr8fsoFsf3N00dfvIwxwW72UZSQh1EORx3okNt6v3LCfr4J
hBq8wFUMIFdvSt9bqWWcO4N6hxFnFnZBrh0sJD5tAYZeAz9e6t53dnHOG9ODW2AW
YwcAaTmjpuUXmsUW40V+znIwiAZvLJ0lWPkXePymVJEp3JVoGuebIlKYZK8gd8cl
58OHja+grrN2w5lQFNpE/Bf8RHO2mrsMdNS+CYrOy+k9o2Nnx30VYO0dt9+kLxLs
OaEYWiyODsspFS5/NPAlKvHlg4gF3HKSeouLGWb/OZ4BOAfMNpK6MVleIpHFeZ7S
fLOq80eBVxz9JuNpq2lYKFFattoNPGn6i98FhtBXhRTbDW3qyyxgUbpEm1UoBfVu
p1Wnr15sjQXxzgeodvSBFdLzZv7fdkxfyuepITZPFUdheW+t3xF7beq4j1L7/dmC
veSuSiEoPLn//3kUc1h4rVGFVoBis80np/QGHfC0h9WzRTr9v6uVS66Cw8O4TYJC
2TXdJ6s0rxP0ghtzdkaZ
=o3Gn
-----END PGP SIGNATURE-----

--UV9n390OnScAQCHBNF16drbgKFg3kF6Qu--
