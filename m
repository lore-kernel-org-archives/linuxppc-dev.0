Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH] CELL Oprofile SPU profiling updated patch
Date: Fri, 16 Feb 2007 18:14:26 +0100
References: <1171497138.23691.8.camel@dyn9047021078.beaverton.ibm.com>
	<200702151537.51202.arnd@arndb.de> <45D4FBB0.7090109@us.ibm.com>
In-Reply-To: <45D4FBB0.7090109@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702161814.26855.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Carl Love <cel@us.ibm.com>, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 16 February 2007 01:32, Maynard Johnson wrote:
> config OPROFILE_CELL
> =A0 =A0 =A0 =A0 bool "OProfile for Cell Broadband Engine"
> =A0 =A0 =A0 =A0 depends on OPROFILE && SPU_FS
> =A0 =A0 =A0 =A0 default y if ((SPU_FS =3D y && OPROFILE =3D y) || (SPU_FS=
 =3D m &&=20
> OPROFILE =3D m))
> =A0 =A0 =A0 =A0 help
> =A0 =A0 =A0 =A0 =A0 Profiling of Cell BE SPUs requires special support en=
abled
> =A0 =A0 =A0 =A0 =A0 by this option. =A0Both SPU_FS and OPROFILE options m=
ust be
> =A0 =A0 =A0 =A0 =A0 set 'y' or both be set 'm'.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Can anyone see a problem with any of this . . . or perhaps a suggestion=20
> of a better way?

The text suggests it doesn't allow SPU_FS=3Dy with OPROFILE=3Dm, which I th=
ink
should be allowed. I also don't see any place in the code where you actually
use CONFIG_OPROFILE_CELL.

Ideally, you should be able to have an oprofile_spu module that can be
loaded after spufs.ko and oprofile.ko. In that case you only need

config OPROFILE_SPU
	depends on OPROFILE && SPU_FS
	default y

and it will automatically build oprofile_spu as a module if one of the two
is a module and won't build it if one of them is disabled.

	Arnd <><
