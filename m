Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zT7dh0CQhzDqsn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 19:06:31 +1100 (AEDT)
Date: Sat, 27 Jan 2018 09:00:34 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, devicetree@vger.kernel.org,
 Albert Herranz <albert_herranz@yahoo.es>,
 linux-gpio@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@suse.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/6] resource: Extend the PPC32 reserved memory hack
Message-ID: <20180127080034.byqfvrwyuibrc4ii@latitude>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net>
 <20180122050411.32460-2-j.neuschaefer@gmx.net>
 <871sigwx41.fsf@concordia.ellerman.id.au>
 <20180123163739.2sxhzavghzgbjw4c@latitude>
 <87po60uk1y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cvkbmej4xuklj5rx"
In-Reply-To: <87po60uk1y.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cvkbmej4xuklj5rx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 12:23:05PM +1100, Michael Ellerman wrote:
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:
[...]
> > Do you have any pointer on how to implement discontiguous memory
> > support? CONFIG_ARCH_SPARSEMEM_ENABLE seems relevant.
>=20
> I'm not really sure what the key impediment to it working is.
>=20
> You don't need to go all the way to SPARSEMEM, there is DISCONTIGMEM
> which IIUI is quite a bit simpler.
>=20
> I'd actually be interested to know what happens (ie. breaks) if you just
> add the two memblocks and leave the hole in between. Is it the generic
> code that breaks or is it something in the powerpc code? If it's the
> later maybe we can do a small fix/hack to work around that.

Ok, I did some experimentation.

First, I made wii_memory_fixups return early, before actually doing
anything[1].

[    0.000000] __ioremap(): phys addr 0xc003000 is RAM lr flipper_pic_init
[    0.000000] flipper-pic: controller at 0x0c003000 mapped to 0x  (null)
[    0.000000] Unable to handle kernel paging request for data at address 0=
x00000004

* __ioremap_caller detects overlap with RAM like this: p < virt_to_phys(hig=
h_memory)
* flipper_pic_init gets NULL from ioremap, but doesn't check for NULL


Then I hacked up __ioremap_caller to use memblock_is_map_memory[2],
because it considers memblocks correctly. The result was that the system
boots further, but then enters the sleep mode where the power LED shines
yellow. In this mode the ARM runs but the PPC doesn't. The same thing
would happen if GPIO 3 ("DC_DC"[3]) was pulled low. These are the last few
lines:

[    0.770324] io scheduler mq-deadline registered
[    0.772472] io scheduler kyber registered

I don't know what exactly is triggering this effect.


Thanks for your help,
Jonathan Neusch=C3=A4fer


[1]: diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/p=
latforms/embedded6xx/wii.c
index 6e6db1e16d71..cddd5606a63d 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -81,6 +81,9 @@ void __init wii_memory_fixups(void)
 	BUG_ON(memblock.memory.cnt !=3D 2);
 	BUG_ON(!page_aligned(p[0].base) || !page_aligned(p[1].base));
=20
+	/* don't fix the memory map */
+	return;
+
 	/* trim unaligned tail */
 	memblock_remove(ALIGN(p[1].base + p[1].size, PAGE_SIZE),
 			(phys_addr_t)ULLONG_MAX);
[2]: diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32=
=2Ec
index f6c7f54c0515..bff581003c50 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -154,8 +154,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, =
unsigned long flags,
 	 * Don't allow anybody to remap normal RAM that we're using.
 	 * mem_init() sets high_memory so only do the check after that.
 	 */
-	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
-	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
+	if (slab_is_available() && memblock_is_map_memory(p)) {
 		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
 		       (unsigned long long)p, __builtin_return_address(0));
 		return NULL;
[3]: http://wiibrew.org/wiki/Hardware/Hollywood_GPIOs

--cvkbmej4xuklj5rx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJabDGZAAoJEAgwRJqO81/bUDwP/0zSjBoJc6bov8ArZwTX4q0M
lcC7g3UkeHHknFDG6fn2KmoleDlgGA8IVNIQ57MZQLwTQJ2lE3MjmZm7GzmIjTWV
OWLLDujiky4eAJ6uoOSqlWZkdsbolOYZXFjKqhujDdRFSVaJjeS+v+/cjh3vl1d4
N7x7uX2DDtjb+hI6aM6xYup2d9nRh5sIkgExDM2vXpViTz1dGNpMphavT6qrb6D+
8H9cWvZLxPtl7tXnegPU+q/zVcnE1wPSg+Ze6xfbfqx26VvM/W5zXBoF6hn8aZUD
Z9xbqHUbGqqlktfp5yGFQ9XXH/Cd5FiorMeazzbWCoN+/ASb1xBjb31zYk5NTeTW
e5tt8UwvIFe+2FCdnjMNxFTytglH8bs3jrzGITd8J+jS/ytSt1QClIqSZpbkxzUB
1TgzEAD25p5+JbN/17Tq7W3lJq6LDMgqZ3QUrC6j5ezRAAvdmNa1+l4mC04roVmV
Scnyto/z8enWuIqoIdsim7kDIy4TfnxlRax25br3vs8Qtg/pm7yqal0guy8IHT1q
FwQGWcSE5veQbbVjeTIFpKY31n/cc6jZE2BlJfJYiQIW3/GzGQbWhgFNmcgXZFzW
fmwOFDXyDRSX+bFdppkixxtrQ/Rx7r391PVR3I3Jjb0xdJz4eHoZ4cGJ/3cFJf5u
dkakBfc17OLRfPE0aoiy
=2fto
-----END PGP SIGNATURE-----

--cvkbmej4xuklj5rx--
