Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 303C42C012E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 16:29:39 +1100 (EST)
Subject: Re: Missing _restvr_20 and _savevr_20 subroutines for
 lib/raid6/altivec8.o
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1382221463.2794.87.camel@deadeye.wl.decadent.org.uk>
Date: Wed, 23 Oct 2013 00:28:32 -0500
Message-Id: <9A520C29-492E-4FFF-9A0C-190182428FBE@kernel.crashing.org>
References: <1382221463.2794.87.camel@deadeye.wl.decadent.org.uk>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: debian-powerpc@lists.debian.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>,
 Debian kernel maintainers <debian-kernel@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 19, 2013, at 5:24 PM, Ben Hutchings wrote:

> When building lib/raid6/altivec8.o with gcc 4.8 on Debian, the =
compiler
> is generating references to two new runtime subroutines which are
> apparently not included in the kernel:
>=20
> ERROR: "_restvr_20" [lib/raid6/raid6_pq.ko] undefined!
> ERROR: "_savevr_20" [lib/raid6/raid6_pq.ko] undefined!
>=20
> The save/restore subroutines are specified in
> =
http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.7.1.html#SAVE=
-RESTORE
> and we do have the _restgpr_* and _savegpr_* subroutines in
> arch/powerpc/boot/crtsavres.S.  I'm not sure whether these subroutines
> should be added or whether this indicates the compiler is doing
> something wrong.
>=20
> A configuration that triggers this is included below.
>=20
> Ben.

Try with CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dn.  A feature was added to gcc =
for -Os to "outline" the save/restore routines.  I'm surprised this =
hasn't shown up sooner.

Well need to add _restvr_* / _savevr_* to the version in =
lib/crtsaveres.S.

=
http://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dblob_plain;f=3Dlibgcc/config/rs600=
0/crtrestvr.S;hb=3DHEAD
=
http://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dblob_plain;f=3Dlibgcc/config/rs600=
0/crtsavevr.S;hb=3DHEAD

- k=
