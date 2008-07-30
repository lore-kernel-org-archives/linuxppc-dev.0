Return-Path: <emunson@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69C59DE2D7
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 01:04:26 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6UF4Mvi027031
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 11:04:22 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6UF4MEV230540
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 11:04:22 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6UF4MjX025333
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 11:04:22 -0400
Date: Wed, 30 Jul 2008 08:04:05 -0700
From: Eric B Munson <ebmunson@us.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] [PATCH 0/5 V2] Huge page backed user-space stacks
Message-ID: <20080730150405.GA20465@us.ibm.com>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
	<20080730014139.39b3edc5.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
In-Reply-To: <20080730014139.39b3edc5.akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jul 2008, Andrew Morton wrote:

> On Mon, 28 Jul 2008 12:17:10 -0700 Eric Munson <ebmunson@us.ibm.com> wrot=
e:
>=20
> > Certain workloads benefit if their data or text segments are backed by
> > huge pages. The stack is no exception to this rule but there is no
> > mechanism currently that allows the backing of a stack reliably with
> > huge pages.  Doing this from userspace is excessively messy and has some
> > awkward restrictions.  Particularly on POWER where 256MB of address spa=
ce
> > gets wasted if the stack is setup there.
> >=20
> > This patch stack introduces a personality flag that indicates the kernel
> > should setup the stack as a hugetlbfs-backed region. A userspace utility
> > may set this flag then exec a process whose stack is to be backed by
> > hugetlb pages.
> >=20
> > Eric Munson (5):
> >   Align stack boundaries based on personality
> >   Add shared and reservation control to hugetlb_file_setup
> >   Split boundary checking from body of do_munmap
> >   Build hugetlb backed process stacks
> >   [PPC] Setup stack memory segment for hugetlb pages
> >=20
> >  arch/powerpc/mm/hugetlbpage.c |    6 +
> >  arch/powerpc/mm/slice.c       |   11 ++
> >  fs/exec.c                     |  209 +++++++++++++++++++++++++++++++++=
+++++---
> >  fs/hugetlbfs/inode.c          |   52 +++++++----
> >  include/asm-powerpc/hugetlb.h |    3 +
> >  include/linux/hugetlb.h       |   22 ++++-
> >  include/linux/mm.h            |    1 +
> >  include/linux/personality.h   |    3 +
> >  ipc/shm.c                     |    2 +-
> >  mm/mmap.c                     |   11 ++-
> >  10 files changed, 284 insertions(+), 36 deletions(-)
>=20
> That all looks surprisingly straightforward.
>=20
> Might there exist an x86 port which people can play with?
>=20

I have tested these patches on x86, x86_64, and ppc64, but not yet on ia64.
There is a user space utility that I have been using to test which would be
included in libhugetlbfs if this is merged into the kernel.  I will send it
out as a reply to this thread, performance numbers are also on the way.

--=20
Eric B Munson
IBM Linux Technology Center
ebmunson@us.ibm.com


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIkILlsnv9E83jkzoRAnu+AJ43tJhIvKC/V/l/tvEzpOLo1AfDugCgky73
1/w9s6N+iJutNNsYfJdCkx0=
=nEy7
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
