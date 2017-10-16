Return-Path: <aik@ozlabs.ru>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFpCs1sxSzDrFw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 17:23:04 +1100 (AEDT)
Received: by mail-io0-x244.google.com with SMTP id m81so14830316ioi.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 23:23:04 -0700 (PDT)
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
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <00ec0e99-45dd-dbe0-d75f-4413253e8093@ozlabs.ru>
Date: Mon, 16 Oct 2017 17:22:55 +1100
MIME-Version: 1.0
In-Reply-To: <20171016061125.GD2776@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7xfUOBV8MnEH8aQJGqqwQX7WXMtoMNOOr"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7xfUOBV8MnEH8aQJGqqwQX7WXMtoMNOOr
Content-Type: multipart/mixed; boundary="CsOttoL4H6hJBi5qAabkxP3Vfga7SHFsP";
 protected-headers="v1"
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
 Balbir Singh <bsingharora@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, slof@lists.ozlabs.org
Message-ID: <00ec0e99-45dd-dbe0-d75f-4413253e8093@ozlabs.ru>
Subject: Re: [PATCH kernel] RFC: prom_init: Fetch flatten device tree from the
 system firmware
References: <20171016054917.21577-1-aik@ozlabs.ru>
 <20171016061125.GD2776@umbus.fritz.box>
In-Reply-To: <20171016061125.GD2776@umbus.fritz.box>

--CsOttoL4H6hJBi5qAabkxP3Vfga7SHFsP
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: quoted-printable

On 16/10/17 17:11, David Gibson wrote:
> On Mon, Oct 16, 2017 at 04:49:17PM +1100, Alexey Kardashevskiy wrote:
>> At the moment, on 256CPU + 256 PCI devices guest, it takes the guest
>> about 8.5sec to read the entire device tree. Some explanation can be
>> found here: https://patchwork.ozlabs.org/patch/826124/ but mostly it i=
s
>> because the kernel traverses the tree twice and it calls "getprop" for=

>> each properly which is really SLOF as it searches from the linked list=

>> beginning every time.
>>
>> Since SLOF has just learned to build FDT and this takes less than 0.5s=
ec
>> for such a big guest, this makes use of the proposed client interface
>> method - "fdt-fetch".
>>
>> If "fdt-fetch" is not available, the old method is used.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> I like the concept, few details though..
>=20
>> ---
>>  arch/powerpc/kernel/prom_init.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/pro=
m_init.c
>> index 02190e90c7ae..daa50a153737 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -2498,6 +2498,31 @@ static void __init flatten_device_tree(void)
>>  		prom_panic("Can't allocate initial device-tree chunk\n");
>>  	mem_end =3D mem_start + room;
>> =20
>> +	if (!call_prom_ret("fdt-fetch", 2, 1, NULL, mem_start,
>> +			   room - sizeof(mem_reserve_map))) {
>> +		u32 size;
>> +
>> +		hdr =3D (void *) mem_start;
>> +
>> +		/* Fixup the boot cpuid */
>> +		hdr->boot_cpuid_phys =3D cpu_to_be32(prom.cpu);
>=20
> If SLOF is generating a tree it really should get this header field
> right as well.


Ah, I did not realize it is just a phandle from /chosen/cpu. Will fix.


>=20
>> +		/* Append the reserved map to the end of the blob */
>> +		hdr->off_mem_rsvmap =3D hdr->totalsize;
>> +		size =3D be32_to_cpu(hdr->totalsize);
>> +		rsvmap =3D (void *) hdr + size;
>> +		hdr->totalsize =3D cpu_to_be32(size + sizeof(mem_reserve_map));
>> +		memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));
>=20
> .. and the reserve map for that matter.  I don't really understand
> what you're doing here.=20

? Get the blob, increase the FDT size by sizeof(mem_reserve_map), fix up
totalsize and off_mem_rsvmap, copy mem_reserve_map to the end of the blob=

(the actual order is slightly different, may be a bit confusing).

Asking SLOF to reserve the space seems to be unnecessary complication of
the interface - SLOF does not provide any reserved memory records.

> Note also that the reserve map is required to
> be 8-byte aligned, which totalsize might not be.

Ah, good point.


>=20
>> +		/* Store the DT address */
>> +		dt_header_start =3D mem_start;
>> +
>> +#ifdef DEBUG_PROM
>> +		prom_printf("Fetched DTB: %d bytes to @%x\n", size, mem_start);
>> +#endif
>> +		goto print_exit;
>> +	}
>> +
>>  	/* Get root of tree */
>>  	root =3D call_prom("peer", 1, 1, (phandle)0);
>>  	if (root =3D=3D (phandle)0)
>> @@ -2548,6 +2573,7 @@ static void __init flatten_device_tree(void)
>>  	/* Copy the reserve map in */
>>  	memcpy(rsvmap, mem_reserve_map, sizeof(mem_reserve_map));
>> =20
>> +print_exit:
>>  #ifdef DEBUG_PROM
>>  	{
>>  		int i;
>=20


--=20
Alexey


--CsOttoL4H6hJBi5qAabkxP3Vfga7SHFsP--

--7xfUOBV8MnEH8aQJGqqwQX7WXMtoMNOOr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZ5FA/DhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC53bwP/01p
CNCpkahZ7d2zxpyxlLQpR7/5MlzlNEINuCKvanL6U0yqI7i1GYUDh7VGdZtZAgPR
3HGzICOJkZ9N66El2SsGcJGghKcgdYMhFuHZoiG8kcRTqMbRaicT5NUXv6w6opA4
UghJnWink70RYJVtAG44ZzWCDs0sPooWt05lvJKzZOwR47kkXpAxmY6EBJFodUR7
N8qwITURNadL0kMqIliBLTAULhD3BOAqZqljcm2WuSLLyN27SmA80OunuSVXusRV
LwC4U83rv8BbKz4wgbnew2p+fWgJdk2dNVxECX+0K0o9OpSOnTlLCMG2AWcX8uDk
E1ePujiT07TmLS0dmT6vDeIxa1mR8ATMh42Et4kryTc/WvMFltN6ge/CM7if+muA
09FugWDhYggCVHZ7AcExCydHRkiMaS7g0HgHwTXKol9RKc/9ed4E7QULbU/UY5nR
VaarWLIYOFAFKA4O+HJ58ZoFBr6ZHpzyg/jtztH+4bH626ZiCqs/m/FbSx3OoArL
hBoQCHj1r6VWhMEXOVosPTdXkr1VWkzLhAUFjG6lID8P46u7mu4nT3yhLaJQMKcw
YZPeYBd2QPZ1930yVEq2zKnkj0DcCRvhNKhyg+/KdS8AFMY+MaEn6llmqZsXesS+
1Gl5iAvaMhSnfN2PZgAccxVRcQn4qxo/h9dKItuY
=f6y0
-----END PGP SIGNATURE-----

--7xfUOBV8MnEH8aQJGqqwQX7WXMtoMNOOr--
