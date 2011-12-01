Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 1 Dec 2011 15:05:24 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/6] 44x/currituck: Add support for the new IBM currituck
 platform
Message-ID: <20111201040524.GF15560@thor.bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-7-git-send-email-tony@bakeyournoodle.com>
 <1322634022.21641.61.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
In-Reply-To: <1322634022.21641.61.camel@pasglop>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2011 at 05:20:22PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2011-11-30 at 16:24 +1100, Tony Breeds wrote:
> > +	plb {
> > +		compatible =3D "ibm,plb-4xx", "ibm,plb4"; /* Could be PLB6, doesn't =
matter */
>=20
> Then make it plb6 and add it to the probe list. Might have to whack it's
> configuration registers one day etc...

Done.

> > +			 * XXX: 1 TB address space, do we really care past
> > +			 * 4 GB and should we expand cell width?
> > +			 */
>=20
> For OPB probably not :-)

Fixed.

> That doesn't seem like a very useful pair of statements or useful debug
> message....

All the DBG cruft is gone.
=20
> > +	for(i =3D 0; i < MAX_RANKS; i++){
> > +		reg =3D mfdcrx(DDR3_MR0CF + i);
> > +		printf("%s: reg=3D0x%08x\r\n", __func__, reg);
>=20
> All that debug is pretty gross, keep it if you wish but make it a bit
> neater and/or wrap it in DBG

Yeah that was an oversight.
=20
> > +		if (reg & 0x01) {
>=20
> 	if (!(reg & 1))
> 		continue;
>=20
> avoids too much indent

Done.

> > +	dt_fixup_memory(0x0ULL,  ibm_currituck_memsize);
>=20
> Ok, I see why the global... I'd still prefer if the detect function just
> returned the value and the caller whacks the global.

Fixed.
=20
> > +	while ((devp =3D find_node_by_devtype(devp, "pci"))) {
> > +		if (getprop(devp, "dma-ranges", &dma_ranges[0], sizeof(dma_ranges)) =
< 0) {
>=20
> Can't you replace &dma_ranges[0] with just dma_ranges ?

Yes, Fixed.

> > +#define SPRN_PIR	0x11E	/* Processor Indentification Register */
>=20
> That should go elsewhere along with the other SPR definitions.

There isn't a std. place in the bootwrapper.
>=20
> > +void platform_init(void)
> > +{
> > +	/* Cap the zImage to 512MB */
>=20
> Any reason ? If yes, please document it a bit more.

XXX

> > +	node =3D fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
> > +	                                     "cpu", sizeof("cpu"));
> > +	if (!node)
> > +		fatal("Cannot find cpu node\n");
>=20
> The above will return -a- CPU node... you have several and you don't
> know which one. You should probably iterate accross all of them.

I'm just trying to get the timebase-frequency, this willbe the same on
all CPUs (at least I hope so ;P) so I don't really care which CPU node I
get.
=20
> > +	/* FIXME: Check this works */

Grr that comment shouldn't be there.  It does work :)

> > +#define PVR_476CURRITUCK	0x7ff50000
>=20
> My understanding is that the currituck was the platform, not the chip,
> and that the chip was called something like 476FPE, am I wrong ?

No you're correct, I was confused about the boundry between 476fpe and
currituck.

> > +	cmplwi	cr0,r3,PVR_476CURRITUCK@h
> > +	beq	head_start_47x
>=20
> So at some point, they gave us the magic foo to do with the PVR to
> identify any 476... I'll try to dig that out of my email archives.

Yeah I have that I'll work out the correct way to the the mask and
test.

> > +++ b/arch/powerpc/platforms/44x/ppc47x.c
>=20
> Call the file currituck.c

Sure.
=20
> > +static void __devinit quirk_ppc_currituck_usb_fixup(struct pci_dev *de=
v)
> > +{
> > +	pci_write_config_dword(dev, 0xe0, 0x0114231f);
> > +	pci_write_config_dword(dev, 0xe4, 0x00006c40);
> > +}
>=20
> Pleae document better what you are doing here and also test
> that you are indeed on the right platform so you don't end up
> whacking bits on USB controllers on other platforms that happen
> to be compiled in the same binary.

Sure, no problem.
=20
> Ok, I'll have to fixup that vs. Kyle patches but the good thing is that
> it will make things even simpler.

Thanks.
=20
> Now pretty much everything in this platform file is generic I believe.
> We could move it all to ppc44x_simple.c. The only things that are not
> are the USB quirk and the interrupt fixup.
>=20
> The USB quirk which should have a compatible test for the platform to
> make sure we don't run it on something else. For such a simple quirk, I
> think it's fine ot have it in ppc44x_simple.c or in drivers/pci/quirk.c
>=20
> For the interrupt fixup, we can probably address it entirely in the
> device-tree, though that means exposing a bunch of on-board bridges
> which is only midly annoying.
>=20
> Anyways, we can discuss that (or maybe an even better option)
> tomorrow :-)=20

Okay I look forward to it :)
=20
> Again, you are mixing the SoC with the board here. afaik, currituck is
> the board, not the SoC.

Fixed.

Yours Tony

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO1v0EAAoJEEsCiJRY75GKtBkP/RHQ1CVK9HQHcBf1C82jPNjz
+7SnIMRWcgIlK7JC7FuDNW8XpAl9+e8qeuAR0sJ67TqDl+jGxUBrcMeNZVQGY1Tf
bEhEQu2I30SdjGrnGiDhY0U89hlOw8fXK/l3ODGQGSTX9DF6CVR1bi9uq8C7Wf8h
QYN1jsv3L7yYfV0hPqEiX7048Qv0JHlZW1YjiWtiHIyf3TA3PUwjhT1AHffrs1yZ
pA5+pQGOjJhsCHhfh/Tl3FhJq481Qcu20I9B0EZwiGP+AHAeIV0D6eV2bSm75QG1
1ONpvNQQh2hvK9XoCjsE6jsOsPIQjT3f3PtKHlnm1BeeadAsEy/xOxTS4yP4VbyL
bnRggfBaGCcM4yQyEcB1HMZwl1z6d2Q8c6Zng2qqnnOo7JVbGfXttv6IynBEC1cy
9lX1XuwFClVesUfsCtZLN/HQJms/aj6wBDnwp+ETihzqFuuzRo0HWXQtq/MUSSBB
qXmwYjZkDOa2xsCrwUN0nHg1T9bCbODMK5MOVlnyVvCQwzMBoo0b87SUnPk6ranl
8lvNUc4s80f8FCJMZxy+NrpElHsTnueQDUPZm0ZHfYBugJtM0X3eR2aUxoAueXHl
WgZRp2f1sb+/Z1ay8xgcChv5fuB/1k9Sa6MraqQlG2AWWSeO2yheNGpudcqtNxFq
wv4yww5PKebcsditcTXv
=9MrH
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--
