Return-Path: <arnd@arndb.de>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3BC5B67A78
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Feb 2005 23:59:04 +1100 (EST)
Received: from e3.ny.us.ibm.com ([192.168.1.103])
	by pokfb.esmtp.ibm.com (8.12.10/8.12.10) with ESMTP id j14CkxgB013516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Feb 2005 07:46:59 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Date: Fri, 4 Feb 2005 13:36:55 +0100
References: <20050204072254.GA17565@austin.ibm.com>
In-Reply-To: <20050204072254.GA17565@austin.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Boundary-02=_rx2ACsdQv5yQ5uj";
	charset="iso-8859-15"
Message-Id: <200502041336.59892.arnd@arndb.de>
Cc: akpm@osdl.org, trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, hpa@zytor.com
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Boundary-02=_rx2ACsdQv5yQ5uj
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freedag 04 Februar 2005 08:22, Olof Johansson wrote:
> It's getting pretty old to have see and type cur_cpu_spec->cpu_features
> & CPU_FTR_<feature>, when a shorter and less TLA-ridden macro is more
> readable.
>=20
> This also takes care of the differences between PPC and PPC64 cpu
> features for the common code; most places in PPC could be replaced with
> the macro as well.

I have a somewhat similar patch that does the same to the
systemcfg->platform checks. I'm not sure if we should use the same inline
function for both checks, but I do think that they should be used in a
similar way, e.g. CPU_HAS_FEATURE(x) and PLATFORM_HAS_FEATURE(x).

My implementation of the platform checks tries to be extra clever by turning
runtime checks into compile time checks if possible. This reduces code size
and in some cases execution speed. It can also be used to replace compile
time checks, i.e. it allows us to write

static inline unsigned int readl(const volatile void __iomem *addr)
{
	if (platform_is(PLATFORM_PPC_ISERIES))
		return iSeries_readl(addr);
	if (platform_possible(PLATFORM_PPC_PSERIES))
		return eeh_readl(addr);
	return in_le32();
}

which will always result in the shortest code for any combination of
CONFIG_PPC_ISERIES, CONFIG_PPC_PSERIES and the other platforms.

The required code for this is roughly

enum {
	PPC64_PLATFORM_POSSIBLE =3D
#ifdef CONFIG_PPC_ISERIES
		PLATFORM_ISERIES |
#endif
#ifdef CONFIG_PPC_PSERIES
		PLATFORM_PSERIES |
#endif
#ifdef CONFIG_PPC_PSERIES
		PLATFORM_PSERIES_LPAR |
#endif
#ifdef CONFIG_PPC_POWERMAC
		PLATFORM_POWERMAC |
#endif
#ifdef CONFIG_PPC_MAPLE
		PLATFORM_MAPLE |
#endif
		0,
	PPC64_PLATFORM_ONLY =3D
#ifdef CONFIG_PPC_ISERIES
		PLATFORM_ISERIES &
#endif
#ifdef CONFIG_PPC_PSERIES
		PLATFORM_PSERIES &
#endif
#ifdef CONFIG_PPC_POWERMAC
		PLATFORM_POWERMAC &
#endif
#ifdef CONFIG_PPC_MAPLE
		PLATFORM_MAPLE &
#endif
		-1ul,
};

static inline platform_is(unsigned long platform)
{
	return ((PPC64_PLATFORM_ONLY & platform)=20
	 || (PPC64_PLATFORM_POSSIBLE & platform & systemcfg->platform));
}

static inline platform_possible(unsigned long platform)
{
	reutrn !!(PPC64_PLATFORM_POSSIBLE & platform);
}

The same stuff is obviously possible for cur_cpu_spec->cpu_features as well.
Do you think that it will help there?

	Arnd <><

--Boundary-02=_rx2ACsdQv5yQ5uj
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCA2xr5t5GS2LDRf4RAmW/AKCS4KSLE8HSoEKKxV0OvPS9PygJygCfdNF7
SzqF3zkYQhZxZFuP2ZH0O5A=
=StYX
-----END PGP SIGNATURE-----

--Boundary-02=_rx2ACsdQv5yQ5uj--
