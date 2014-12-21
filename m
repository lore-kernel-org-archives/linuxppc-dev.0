Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B2C3D1A09A6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Dec 2014 20:56:23 +1100 (AEDT)
Date: Sun, 21 Dec 2014 20:56:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pranith Kumar <bobby.prani@gmail.com>
Subject: Re: [PATCH] powerpc: Wire up sys_execveat() syscall
Message-ID: <20141221205604.5a280c9d@canb.auug.org.au>
In-Reply-To: <1419094041-14536-1-git-send-email-bobby.prani@gmail.com>
References: <1419094041-14536-1-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6GMvFXob7SyJ1tcrOEXdWMs"; protocol="application/pgp-signature"
Cc: linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Herrmann <dh.herrmann@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/6GMvFXob7SyJ1tcrOEXdWMs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Pranith,

On Sat, 20 Dec 2014 11:47:18 -0500 Pranith Kumar <bobby.prani@gmail.com> wr=
ote:
>
> Wire up sys_execveat(). This passes the selftests for the system call.

Thanks for this, but ...

> diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm=
/systbl.h
> index ce9577d..778844a 100644
> --- a/arch/powerpc/include/asm/systbl.h
> +++ b/arch/powerpc/include/asm/systbl.h
> @@ -366,3 +366,4 @@ SYSCALL_SPU(seccomp)
>  SYSCALL_SPU(getrandom)
>  SYSCALL_SPU(memfd_create)
>  SYSCALL_SPU(bpf)
> +SYSCALL_SPU(execveat)

Given that it passes pointers into the kernel and looking at the execve
system call, I assume that it should be COMPAT_SYS().

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/6GMvFXob7SyJ1tcrOEXdWMs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUlplFAAoJEMDTa8Ir7ZwVz8gP/iT/GPPlhuxFK+B6J0B0P34g
tkMQPKkeLEO+nXa2FVaspRGvPtkH3fuxdOaagj5VBQce8ildFpf9eaPOCKnxmcRh
J1eWpjk2/PIfEcyKuc1Qh2UMG2l61dokO3qVAzkEW3dYUqXWiORbC6JoIz+LaG5M
ujtl76YBar564TqhUVfQO+an0eBpJe6Qx5si7xDIK3ID+Am6xt5SSipqmsWWCP3k
h4jBi9FSzND7SyXmTfi5kWtfYMtyn2JOyzftX0k9k42rS/c52FeBdmZk3m9CGzh5
M28HT2+Op1LDIdh+Ut8mh+dK70HyaUDc/Pl9HkhmCdB/xeb3WAX20noXi6l5T9HE
VSKfK4BOPtib79SbZAizHG+YuHPre9IJJ6+tBP3JfmIdiuvvE16R9vuaeRFpmVRK
hl8Q4+7eaQI0TC8mk9HeKs3pHflJKRntYnpIk8SDxRyEkHjbA56i3qjTEx2rBllo
iv5MV+X+3awEI8nAfk7C+95dbGnGOYTUEWF8jd3VjpQfiPZj27/TQk4HFz3LKUBb
ugtOr8vucMVfhdaP4PkLOSKmwwRtP/qjLazq9Ql8z3n68nbMZe6iPZF9cfPy71wr
0YmODt9ePrp1Xlt5FGf+6qZp2QU2M+GwIeEB0fk8j4Hbvpbjd5ewJqR0KDrahY4D
ToGGEBVIFswdreYud8bf
=59QZ
-----END PGP SIGNATURE-----

--Sig_/6GMvFXob7SyJ1tcrOEXdWMs--
