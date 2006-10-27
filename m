Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7626867F16
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 10:28:50 +1000 (EST)
Date: Fri, 27 Oct 2006 10:28:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 2/3] Create compat_sys_migrate_pages
Message-Id: <20061027102834.5db261af.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0610261158130.2802@schroedinger.engr.sgi.com>
References: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
	<20061026133305.b0db54e6.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0610261158130.2802@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__27_Oct_2006_10_28_34_+1000_=/0fdBc0o0p1Ku9J"
Cc: linux-mm@kvack.org, ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>, ak@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__27_Oct_2006_10_28_34_+1000_=/0fdBc0o0p1Ku9J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2006 12:00:30 -0700 (PDT) Christoph Lameter <clameter@sgi.com> wrote:
>
> On Thu, 26 Oct 2006, Stephen Rothwell wrote:
>
> > This is needed on bigendian 64bit architectures. The obvious way to do
> > this (taking the other compat_ routines in this file as examples) is to
> > use compat_alloc_user_space and copy the bitmasks back there, however you
> > cannot call compat_alloc_user_space twice for a single system call and
> > this method saves two copies of the bitmasks.
>
> Well this means also that sys_mbind and sys_set_mempolicy are also
> broken because these functions also use get_nodes().

No they aren't because they have compat routines that convert the bitmaps
before calling the "normal" syscall.  They, importantly, only use
compat_alloc_user_space once each.

> Fixing get_nodes() to do the proper thing would fix all of these
> without having to touch sys_migrate_pages or creating a compat_ function
> (which usually is placed in kernel/compat.c)

You need the compat_ version of the syscalls to know if you were called
from a 32bit application in order to know if you may need to fixup the
bitmaps that are passed from/to user mode.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Oct_2006_10_28_34_+1000_=/0fdBc0o0p1Ku9J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFQVK3FdBgD/zoJvwRApyiAJ9bErnB/elH+cfVrgRfzDqE8JqcsQCfbE3K
kO4zt/MP8zf3yO2rBQ/L1Eg=
=gkUC
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Oct_2006_10_28_34_+1000_=/0fdBc0o0p1Ku9J--
