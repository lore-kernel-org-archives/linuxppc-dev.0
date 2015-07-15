Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFD6B1A08CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 00:35:08 +1000 (AEST)
Message-ID: <55A66F96.6030808@redhat.com>
Date: Wed, 15 Jul 2015 16:35:02 +0200
From: Thomas Huth <thuth@redhat.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org, anton@samba.org, kvm-ppc@vger.kernel.org
Subject: Re: BUG: sleeping function called from ras_epow_interrupt context
References: <55A55846.5080904@redhat.com>
 <1436908977.3948.266.camel@kernel.crashing.org>
In-Reply-To: <1436908977.3948.266.camel@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QgT3AUnutxkP2RoRrRkhIOA7M41kGoGt2"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QgT3AUnutxkP2RoRrRkhIOA7M41kGoGt2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2015 11:22 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2015-07-14 at 20:43 +0200, Thomas Huth wrote:
>> Any suggestions how to fix this? Simply revert 587f83e8dd50d? Use
>> mdelay() instead of msleep() in rtas_busy_delay()? Something more
>> fancy?
>=20
> A proper fix would be more fancy, the get_sensor should happen in a
> kernel thread instead.

I'm not very familiar with this stuff, but isn't the EPOW interrupt
something that is very time-critical? Moving parts of the handler into a
kernel thread then does not sound like a very good idea to me...

Another question: Can it happen at all that this get-sensor call results
in a sleep condition? Looking at commit ID
81b73dd92b97423b8f5324a59044da478c04f4c4 ("Fix might-sleep warning on
removing cpus"), which apparently fixed a similar issue for CPU
hot-plugging, indicates that at least some of the rtas calls are never
returning the busy code? In that case we could fix this by introducing a
similar rtas_get_sensor_fast() function? (or simply revert 587f83e8dd50d
which would be quite similar, I think)

 Thomas



--QgT3AUnutxkP2RoRrRkhIOA7M41kGoGt2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVpm+WAAoJEC7Z13T+cC21s0sP/igHyXofqISs9s5OiDtyn1t/
b3C2LYLLqkVW4l5ljiRdEcLmXSuIJV3VbKqCNqBU5wIroKRQXOxuqRHC8bH3yn0m
OXdKV9/mLHWGQ3xiGaXpJvxJnUcyRkKDRzaLJGXmSXEMchri7yXnLeExQEc75fFA
cJHYRN5D5Zq5yyjtSb3Ei0A2F0mYtEt7pWOfMpf05aO1zErP14cKFV3NuK4nUkEb
53Cmodxlj1rdGqbMQdDUz2qDa8PjDo/qPIr6OoyAo0Ia+VwuTW5i3/IQ+QNMiZHq
fKEOpJtWQ0XQzthZjevtN2MYe+oeNei3tk5ZneVJu3wIrdNXo4uP4NEg2UbdHqHk
a46p4iEMoE0kLNJOnP4lmCups99R0j4KXlVaNt6isa4O354iEE0br6TzOle8pcCF
8LrYaYSUkeV+3Xq1MzVlgqbBAYw4E3w6cH35q2CubErcN8ub2E589GAeb4PTqYN9
hD0vsFcZ0lvzfaTEauFkjdN5Dj4yLmPNgptnjddvwbOyhabp1S4Hc59FA39KaQcI
9g+qWPkaq5VJ+G2M/Qn6e6Hyu728mriHdhTLY+EbA6Sr8gcPMCwtZrkQ72b90sFl
xdG0Xe7JeNlAihTRUgBtu22y+KElvtgCaRGXuRRjbKHeCXb/AcDZyr+OEzmwHm6n
0mDosXKNHEqD1pxnZdsX
=rSDi
-----END PGP SIGNATURE-----

--QgT3AUnutxkP2RoRrRkhIOA7M41kGoGt2--
