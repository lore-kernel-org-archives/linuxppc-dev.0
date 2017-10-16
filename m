Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFqBs0x53zDrFw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 18:07:16 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id n195so17960898itg.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 00:07:15 -0700 (PDT)
Subject: Re: [PATCH kernel] RFC: prom_init: Fetch flatten device tree from the
 system firmware
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
 Balbir Singh <bsingharora@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, slof@lists.ozlabs.org
References: <20171016054917.21577-1-aik@ozlabs.ru>
 <20171016061125.GD2776@umbus.fritz.box>
 <00ec0e99-45dd-dbe0-d75f-4413253e8093@ozlabs.ru>
 <20171016064633.GE2776@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f849afda-4384-f72e-c8cf-15ba5d170f2c@ozlabs.ru>
Date: Mon, 16 Oct 2017 18:07:06 +1100
MIME-Version: 1.0
In-Reply-To: <20171016064633.GE2776@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GGcrg1xI9Lemg1BMBrjxCBxcE3SH3t1DQ"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GGcrg1xI9Lemg1BMBrjxCBxcE3SH3t1DQ
Content-Type: multipart/mixed; boundary="7d5OK4cuMaH5RrDnJJA7Uh66R5TtdJIiV";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
 Balbir Singh <bsingharora@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, slof@lists.ozlabs.org
Message-ID: <f849afda-4384-f72e-c8cf-15ba5d170f2c@ozlabs.ru>
Subject: Re: [PATCH kernel] RFC: prom_init: Fetch flatten device tree from the
 system firmware
References: <20171016054917.21577-1-aik@ozlabs.ru>
 <20171016061125.GD2776@umbus.fritz.box>
 <00ec0e99-45dd-dbe0-d75f-4413253e8093@ozlabs.ru>
 <20171016064633.GE2776@umbus.fritz.box>
In-Reply-To: <20171016064633.GE2776@umbus.fritz.box>

--7d5OK4cuMaH5RrDnJJA7Uh66R5TtdJIiV
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: quoted-printable

On 16/10/17 17:46, David Gibson wrote:
> On Mon, Oct 16, 2017 at 05:22:55PM +1100, Alexey Kardashevskiy wrote:
>> On 16/10/17 17:11, David Gibson wrote:
>>> On Mon, Oct 16, 2017 at 04:49:17PM +1100, Alexey Kardashevskiy wrote:=

>>>> At the moment, on 256CPU + 256 PCI devices guest, it takes the guest=

>>>> about 8.5sec to read the entire device tree. Some explanation can be=

>>>> found here: https://patchwork.ozlabs.org/patch/826124/ but mostly it=
 is
>>>> because the kernel traverses the tree twice and it calls "getprop" f=
or
>>>> each properly which is really SLOF as it searches from the linked li=
st
>>>> beginning every time.
>>>>
>>>> Since SLOF has just learned to build FDT and this takes less than 0.=
5sec
>>>> for such a big guest, this makes use of the proposed client interfac=
e
>>>> method - "fdt-fetch".
>>>>
>>>> If "fdt-fetch" is not available, the old method is used.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>
>>> I like the concept, few details though..
>>>
>>>> ---
>>>>  arch/powerpc/kernel/prom_init.c | 26 ++++++++++++++++++++++++++
>>>>  1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/p=
rom_init.c
>>>> index 02190e90c7ae..daa50a153737 100644
>>>> --- a/arch/powerpc/kernel/prom_init.c
>>>> +++ b/arch/powerpc/kernel/prom_init.c
>>>> @@ -2498,6 +2498,31 @@ static void __init flatten_device_tree(void)
>>>>  		prom_panic("Can't allocate initial device-tree chunk\n");
>>>>  	mem_end =3D mem_start + room;
>>>> =20
>>>> +	if (!call_prom_ret("fdt-fetch", 2, 1, NULL, mem_start,
>>>> +			   room - sizeof(mem_reserve_map))) {
>>>> +		u32 size;
>>>> +
>>>> +		hdr =3D (void *) mem_start;
>>>> +
>>>> +		/* Fixup the boot cpuid */
>>>> +		hdr->boot_cpuid_phys =3D cpu_to_be32(prom.cpu);
>>>
>>> If SLOF is generating a tree it really should get this header field
>>> right as well.
>>
>>
>> Ah, I did not realize it is just a phandle from /chosen/cpu. Will
>> fix.
>=20
> It's not a phandle.  It's just the "address" (i.e. reg value) of the
> boot cpu.


Well, it is "reg" of a CPU with phandle=3D=3D/chosen/cpu so my fdt code n=
eeds
to look there to pick the right "reg" rather than just plain 0. I'll fix
this but in general can it possibly be not a zero in QEMU/SLOF?


>=20
>>>> +		/* Append the reserved map to the end of the blob */
>>>> +		hdr->off_mem_rsvmap =3D hdr->totalsize;
>>>> +		size =3D be32_to_cpu(hdr->totalsize);
>>>> +		rsvmap =3D (void *) hdr + size;
>>>> +		hdr->totalsize =3D cpu_to_be32(size + sizeof(mem_reserve_map));
>>>> +		memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));
>>>
>>> .. and the reserve map for that matter.  I don't really understand
>>> what you're doing here.=20
>>
>> ? Get the blob, increase the FDT size by sizeof(mem_reserve_map), fix =
up
>> totalsize and off_mem_rsvmap, copy mem_reserve_map to the end of the b=
lob
>> (the actual order is slightly different, may be a bit confusing).
>=20
> Right.. but where is mem_reserve_map coming from, if it hasn't come
> from an FDT?
>=20
>> Asking SLOF to reserve the space seems to be unnecessary complication =
of
>> the interface - SLOF does not provide any reserved memory records.
>=20
> Ah.. right, the reservations are coming from the pre-prom kernel, not
> from the firmware itself.  Yeah, that makes sense.  Ok, this makes
> sense then...


Right, the reservations are added via reserve_mem() in
arch/powerpc/kernel/prom_init.c

>=20
>>> Note also that the reserve map is required to
>>> be 8-byte aligned, which totalsize might not be.
>>
>> Ah, good point.
>=20
> ..at least with that fixed and maybe some comments to make what's
> gonig on clearer.

>>
>>
>>>
>>>> +		/* Store the DT address */
>>>> +		dt_header_start =3D mem_start;
>>>> +
>>>> +#ifdef DEBUG_PROM
>>>> +		prom_printf("Fetched DTB: %d bytes to @%x\n", size, mem_start);
>>>> +#endif
>>>> +		goto print_exit;
>>>> +	}
>>>> +
>>>>  	/* Get root of tree */
>>>>  	root =3D call_prom("peer", 1, 1, (phandle)0);
>>>>  	if (root =3D=3D (phandle)0)
>>>> @@ -2548,6 +2573,7 @@ static void __init flatten_device_tree(void)
>>>>  	/* Copy the reserve map in */
>>>>  	memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));
>>>> =20
>>>> +print_exit:
>>>>  #ifdef DEBUG_PROM
>>>>  	{
>>>>  		int i;
>>>
>>
>>
>=20
>=20
>=20
>=20


--=20
Alexey


--7d5OK4cuMaH5RrDnJJA7Uh66R5TtdJIiV--

--GGcrg1xI9Lemg1BMBrjxCBxcE3SH3t1DQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZ5FqbDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5lGMP/j0Y
CVFK5B7MK6XZgTb2Z3OR2Q/bReth9lDWEMcdoYT65IKs4vbQjuf6CbQwnxymHGQw
r99EgSyHWR4rOU61VsaVpcM55FaANJG9RKEEgyxmG488tn0J3bpa8uWmanccXfHk
rrC45OnGhVLIowNkHeXowOdkNTjLPes84agyAkc+rCDE+MH+ga9XnLCNIMuEw1Br
GplncA9pU5E1OIJAfb0jVjB16C0rMMXyB5tZrO0DZgByQLY/ECS9pN53JJAopktG
U3oa9IW4phhqEJ+BJbaTUBqJA/eb+YHgYf0dfqS/RWo+nZg6pfjwX88ccEqdDEJV
mEzQvawvJ2iQGA8oe1BivGUZIoUwuOThbj66qBjv9LRvvpBuVW0ZSB7o/vW3u6/j
mc+09ypTVuvRYEqonIC0CfYt8fXQqQKEqXidS8+B+oo6dJkPlaeDmqYBTSmeg76D
kvIt/+sym5VVVlob058uFNa9EeC7Qm8L22gAxBh2pj8tR/OWqV58HxDlLSj8zAJ2
Sqhnc9oTaQoUG1Ny6ntf5jvngB8u8I3TVVUjSnU3ySm4cRVeEk6ry++HzPaCSnzf
cRM8AH/2F1ewe+XKbaDJ3HGOy8uhgzQ1xcLbTPuHSVG2YEkHqQqj439AcPYmxFyO
7OU3dIPcUC2+5NAcFliT3Ck82/35KTTgjoElzcH8
=AzMQ
-----END PGP SIGNATURE-----

--GGcrg1xI9Lemg1BMBrjxCBxcE3SH3t1DQ--
