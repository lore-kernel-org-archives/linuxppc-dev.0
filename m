Return-Path: <dgibson@ozlabs.org>
Date: Mon, 16 Oct 2017 20:05:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
 Balbir Singh <bsingharora@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, slof@lists.ozlabs.org
Subject: Re: [PATCH kernel] RFC: prom_init: Fetch flatten device tree from
 the system firmware
Message-ID: <20171016090549.GG2776@umbus.fritz.box>
References: <20171016054917.21577-1-aik@ozlabs.ru>
 <20171016061125.GD2776@umbus.fritz.box>
 <00ec0e99-45dd-dbe0-d75f-4413253e8093@ozlabs.ru>
 <20171016064633.GE2776@umbus.fritz.box>
 <f849afda-4384-f72e-c8cf-15ba5d170f2c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OpLPJvDmhXTZE4Lg"
In-Reply-To: <f849afda-4384-f72e-c8cf-15ba5d170f2c@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OpLPJvDmhXTZE4Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 06:07:06PM +1100, Alexey Kardashevskiy wrote:
> On 16/10/17 17:46, David Gibson wrote:
> > On Mon, Oct 16, 2017 at 05:22:55PM +1100, Alexey Kardashevskiy wrote:
> >> On 16/10/17 17:11, David Gibson wrote:
> >>> On Mon, Oct 16, 2017 at 04:49:17PM +1100, Alexey Kardashevskiy wrote:
> >>>> At the moment, on 256CPU + 256 PCI devices guest, it takes the guest
> >>>> about 8.5sec to read the entire device tree. Some explanation can be
> >>>> found here: https://patchwork.ozlabs.org/patch/826124/ but mostly it=
 is
> >>>> because the kernel traverses the tree twice and it calls "getprop" f=
or
> >>>> each properly which is really SLOF as it searches from the linked li=
st
> >>>> beginning every time.
> >>>>
> >>>> Since SLOF has just learned to build FDT and this takes less than 0.=
5sec
> >>>> for such a big guest, this makes use of the proposed client interface
> >>>> method - "fdt-fetch".
> >>>>
> >>>> If "fdt-fetch" is not available, the old method is used.
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>
> >>> I like the concept, few details though..
> >>>
> >>>> ---
> >>>>  arch/powerpc/kernel/prom_init.c | 26 ++++++++++++++++++++++++++
> >>>>  1 file changed, 26 insertions(+)
> >>>>
> >>>> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/p=
rom_init.c
> >>>> index 02190e90c7ae..daa50a153737 100644
> >>>> --- a/arch/powerpc/kernel/prom_init.c
> >>>> +++ b/arch/powerpc/kernel/prom_init.c
> >>>> @@ -2498,6 +2498,31 @@ static void __init flatten_device_tree(void)
> >>>>  		prom_panic("Can't allocate initial device-tree chunk\n");
> >>>>  	mem_end =3D mem_start + room;
> >>>> =20
> >>>> +	if (!call_prom_ret("fdt-fetch", 2, 1, NULL, mem_start,
> >>>> +			   room - sizeof(mem_reserve_map))) {
> >>>> +		u32 size;
> >>>> +
> >>>> +		hdr =3D (void *) mem_start;
> >>>> +
> >>>> +		/* Fixup the boot cpuid */
> >>>> +		hdr->boot_cpuid_phys =3D cpu_to_be32(prom.cpu);
> >>>
> >>> If SLOF is generating a tree it really should get this header field
> >>> right as well.
> >>
> >>
> >> Ah, I did not realize it is just a phandle from /chosen/cpu. Will
> >> fix.
> >=20
> > It's not a phandle.  It's just the "address" (i.e. reg value) of the
> > boot cpu.
>=20
>=20
> Well, it is "reg" of a CPU with phandle=3D=3D/chosen/cpu so my fdt code n=
eeds
> to look there to pick the right "reg" rather than just plain 0.

Ah, right, I see what you mean.

> I'll fix
> this but in general can it possibly be not a zero in QEMU/SLOF?

Erm.. probably not, but I'm not totally certain what could happen if
you tried creating all your cpu cores explicitly with -device instead
of just using -smp.

I think it's safer to look it up in SLOF, so that it won't break if we
change how cpu addresses are assigned in qemu.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OpLPJvDmhXTZE4Lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnkdmoACgkQbDjKyiDZ
s5IjdQ//TlnZVYBwu3KecHRLoZsZfqOWrPAtRnqEHIr2Pp1Tb5Nvw2SjEJLycIl7
+pdyIDPPFZDhS3teXQleW8AbBfnWKjK4H+F3JuroHrwT3hu0/aGXzRWAaqu8RceP
cfZwNZFt3re1NWkZ3xsl7lG8r/zZRwLNSCsgR0ZqpQHScIjKshm31hIUClICwKRb
vP/VlCMH4XWd5AVFOLTIMEoM0WMZ+hxWk5ZHEicFydcBczQOCCrC1Ah7Q01N88Tl
FlZUqwVU19IJz4U9+1osjxNMQRs9kxrXGns0TS4Ph043Ct8FwCMD9SeHzUmqbrKc
6NaBVBmgGjP+OaN0xS99eSUWcC92WQlsCx5sLDFv7EYZRP+hX+HYGEObgvwhLEZE
ZQVF8806fTns1oPz9oV27mnunBbQhGM5vit6bD56FtcLfWGXeNofYQ7xZIqr8+2X
+MPTx0hiTGQ2TKmoBtX/wMNI5TjjV05OUrzr796+CkToeE7+B7vDNd9CD0WZhCbN
Xu8826zx4JFN8eNITgBC2DqgFHLrmV7b35GtJkdMOxcyMcsf1xdkYX5gmds7uM39
uiYapRM2AbydQarQPa9/DqWJvbd8XWp6YL0ffjqJi1vw3pM1hB198rltv64OxcFC
r6qZAmMlDFtKOHWRnH6rdYKkwCGaM52SWYTiRUk4ls5pDfp9NKw=
=kSqi
-----END PGP SIGNATURE-----

--OpLPJvDmhXTZE4Lg--
