Return-Path: <dgibson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C3821A037C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 13:29:28 +1100 (AEDT)
Date: Fri, 16 Oct 2015 13:29:43 +1100
From: David Gibson <dgibson@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, thuth@redhat.com
Subject: Re: [PATCH] powerpc: on crash, kexec'ed kernel needs all CPUs are
 online
Message-ID: <20151016132943.1386fda6@voom.fritz.box>
In-Reply-To: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
References: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZFLzQIDGcExEEyj7JTMAp.2"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/ZFLzQIDGcExEEyj7JTMAp.2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Oct 2015 21:00:58 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On kexec, all secondary offline CPUs are onlined before
> starting the new kernel, this is not done in the case of kdump.
>=20
> If kdump is configured and a kernel crash occurs whereas
> some secondaries CPUs are offline (SMT=3Doff),
> the new kernel is not able to start them and displays some
> "Processor X is stuck.".
>=20
> Starting with POWER8, subcore logic relies on all threads of
> core being booted. So, on startup kernel tries to start all
> threads, and asks OPAL (or RTAS) to start all CPUs (including
> threads). If a CPU has been offlined by the previous kernel,
> it has not been returned to OPAL, and thus OPAL cannot restart
> it: this CPU has been lost...
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Nice analysis of the problem.  But, I'm a bit uneasy about this approach
to fixing it: Onlining potentially hundreds of CPU threads seems like
a risky operation in a kernel that's already crashed.

I don't have a terribly clear idea of what is the best way to address
this.  Here's a few ideas in the right general direction:

  * I'm already looking into a kdump userspace fixes to stop it
    attempting to bring up secondary CPUs

  * A working kernel option to say "only allow this many online cpus
    ever" which we could pass to the kdump kernel would be nice

  * Paulus had an idea about offline threads returning themselves
    directly to OPAL by kicking a flag at kdump/kexec time.


BenH, Paulus,

OPAL <-> kernel cpu transitions don't seem to work quite how I thought
they would.  IIUC there's a register we can use to directly control
which threads on a core are active.  Given that I would have thought
cpu "ownership" OPAL vs. kernel would be on a per-core, rather than
per-thread basis.

Is there some way we can change the CPU onlining / offlining code so
that if threads aren't in OPAL, we directly enable them, rather than
just hoping they're in a nap loop somewhere?

--=20
David Gibson <dgibson@redhat.com>
Senior Software Engineer, Virtualization, Red Hat

--Sig_/ZFLzQIDGcExEEyj7JTMAp.2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWIGEXAAoJEGw4ysog2bOSpykP/3aDrYtlWE2Wvv/IPvsc+XWo
BvucRU1/FLKTUprxW5a4SqRfbzes15rYWBbqgg5OibPkdr0wgXRaqqK3pTa0fr1t
+wUczC8x8Gdyc+2OcFRKQ2SiW/UbECyPSPjxJTVUOG2etbsjX6wTCJe72Soh49JF
oaWC2yxAYCOXzizOW6S+lahN5fM+WOLd0FDt3gIz7f+qun/UKNPt0Ev7D50Fh2at
uoIGMUzqKg30HHLei4ZJrk+3aWQfvaO1Hi6574k0XhpHl/7e1gS3wvh4u7L7dyhT
pLdBuKArtHJfv2m7W56uqiN3CWf0blG05FM+VLH7cAmIljLUvKMIpXScQtfy0RcW
xCHIBFzN0hQBrMjat4PUHIGf8AX5Ia/cLlmEjBHNN8VgLK+hsdA2II8q34tZ0Y83
Rjz6mWZjyph0XO0Ik1RwjA7D7AXQntIxjeQcP9coSwxce4E7z49QrJLhOvchl5tE
lLZsZI95/R/CLJU+gXjIfMJSuivCBrfNRmUHZj8qWn5K7fIU2j8jyZR5HVEe2myo
Hk7pBXrgtWg/P7Ix/qE8bW4UHA/CvaN69EWy5geTVVto2fWR03Dx8cZNMxQ6pBqe
b9S/vum2gL/7A/EzEhkGLHrBS1Zymbc4QON//cKZEvfrKT/ckKKl7kwzYoT9A6bM
+lPQfUjiypkw7NrgYNjT
=VkJI
-----END PGP SIGNATURE-----

--Sig_/ZFLzQIDGcExEEyj7JTMAp.2--
