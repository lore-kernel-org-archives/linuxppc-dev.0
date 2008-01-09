Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080109042911.GT14201@localdomain>
References: <4782B985.2090508@austin.ibm.com>
	<4782C026.8080302@austin.ibm.com> <20080109042911.GT14201@localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-bdVHOcf8Z09F4Kak6IZk"
Date: Wed, 09 Jan 2008 15:58:35 +1100
Message-Id: <1199854715.14578.1.camel@concordia>
Mime-Version: 1.0
Cc: lkessler@us.ibm.com, linuxppc-dev@ozlabs.org, mahuja@us.ibm.com,
	linasvepstas@gmail.com, strosake@us.ibm.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-bdVHOcf8Z09F4Kak6IZk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-01-08 at 22:29 -0600, Nathan Lynch wrote:
> Manish Ahuja wrote:
> > +
> > +                   Hypervisor-Assisted Dump
> > +                   ------------------------
> > +                       November 2007
>=20
> Date is unneeded (and, uhm, dated :)
>=20
>=20
> > +The goal of hypervisor-assisted dump is to enable the dump of
> > +a crashed system, and to do so from a fully-reset system, and
> > +to minimize the total elapsed time until the system is back
> > +in production use.
>=20
> Is it actually faster than kdump?
>=20
>=20
> > +As compared to kdump or other strategies, hypervisor-assisted
> > +dump offers several strong, practical advantages:
> > +
> > +-- Unlike kdump, the system has been reset, and loaded
> > +   with a fresh copy of the kernel.  In particular,
> > +   PCI and I/O devices have been reinitialized and are
> > +   in a clean, consistent state.
> > +-- As the dump is performed, the dumped memory becomes
> > +   immediately available to the system for normal use.
> > +-- After the dump is completed, no further reboots are
> > +   required; the system will be fully usable, and running
> > +   in it's normal, production mode on it normal kernel.
> > +
> > +The above can only be accomplished by coordination with,
> > +and assistance from the hypervisor. The procedure is
> > +as follows:
> > +
> > +-- When a system crashes, the hypervisor will save
> > +   the low 256MB of RAM to a previously registered
> > +   save region. It will also save system state, system
> > +   registers, and hardware PTE's.
> > +
> > +-- After the low 256MB area has been saved, the
> > +   hypervisor will reset PCI and other hardware state.
> > +   It will *not* clear RAM. It will then launch the
> > +   bootloader, as normal.
> > +
> > +-- The freshly booted kernel will notice that there
> > +   is a new node (ibm,dump-kernel) in the device tree,
> > +   indicating that there is crash data available from
> > +   a previous boot. It will boot into only 256MB of RAM,
> > +   reserving the rest of system memory.
> > +
> > +-- Userspace tools will parse /sys/kernel/release_region
> > +   and read /proc/vmcore to obtain the contents of memory,
> > +   which holds the previous crashed kernel. The userspace
> > +   tools may copy this info to disk, or network, nas, san,
> > +   iscsi, etc. as desired.
> > +
> > +   For Example: the values in /sys/kernel/release-region
> > +   would look something like this (address-range pairs).
> > +   CPU:0x177fee000-0x10000: HPTE:0x177ffe020-0x1000: /
> > +   DUMP:0x177fff020-0x10000000, 0x10000000-0x16F1D370A
> > +
> > +-- As the userspace tools complete saving a portion of
> > +   dump, they echo an offset and size to
> > +   /sys/kernel/release_region to release the reserved
> > +   memory back to general use.
> > +
> > +   An example of this is:
> > +     "echo 0x40000000 0x10000000 > /sys/kernel/release_region"
> > +   which will release 256MB at the 1GB boundary.
>=20
> This violates the "one file, one value" rule of sysfs, but nobody
> really takes that seriously, I guess.  In any case, consider
> documenting this in Documentation/ABI.
>=20
>=20
> > +
> > +Please note that the hypervisor-assisted dump feature
> > +is only available on Power6-based systems with recent
> > +firmware versions.
>=20
> This statement will of course become dated/incorrect so I recommend
> removing it.
>=20
>=20
> > +
> > +Implementation details:
> > +----------------------
> > +In order for this scheme to work, memory needs to be reserved
> > +quite early in the boot cycle. However, access to the device
> > +tree this early in the boot cycle is difficult, and device-tree
> > +access is needed to determine if there is a crash data waiting.
>=20
> I don't think this bit about early device tree access is correct.  By
> the time your code is reserving memory (from early_init_devtree(), I
> think), RTAS has been instantiated and you are able to test for the
> existence of /rtas/ibm,dump-kernel.

Yep it's early_init_devtree(), and yes it's fairly easy to access the
(flattened) device tree at that point.

> > +To work around this problem, all but 256MB of RAM is reserved
> > +during early boot. A short while later in boot, a check is made
> > +to determine if there is dump data waiting. If there isn't,
> > +then the reserved memory is released to general kernel use.
>=20
> So I think these gymnastics are unneeded -- unless I'm
> misunderstanding something, you should be able to determine very early
> whether to reserve that memory.

I agree.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-bdVHOcf8Z09F4Kak6IZk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHhFR7dSjSd0sB4dIRAr4VAJ0eY/H0g1EP6lub2s5GAWkuen3LDwCgtX8o
e5vfMi3IAzjC2CPyVKGcjvA=
=nlfl
-----END PGP SIGNATURE-----

--=-bdVHOcf8Z09F4Kak6IZk--
