Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C60C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:14:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68322089E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NmBqzlcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68322089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YzQB445nzDrPv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:14:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NmBqzlcx";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Yz8T5j7hzF3VM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:02:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="NmBqzlcx"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Yz8T24sqz9sC2;
 Tue, 16 Oct 2018 13:02:17 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1539655337;
 bh=uMu1Jps7YVEpDy66HAo/hOq3sNhIlG8my7PcMOdLt8I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=NmBqzlcx7C+miSBotqAh8KJ+FX+o5XCoHfM6uzUdzA8kr3ik83cVvwJMgJSc31fDf
 JEZ4+6lHVHvVR2sexqJ5AFVu5cMcrZf6HuH7PH+qCKHxUym6LRRwcS0uccw2HKqbTI
 OgdtSRVjle92wNJqr6eb+u/9BWV4V4DyTOQf2vPTrAC61U4ccUZjX41BVgcpEZ+moF
 FfLx2/r4GLfqYImXKaZDVjp1CmVJfE46CjA40BxdVseoA3hyJLGTBHA+BZJyf0pl0C
 fVu38ZiJOCzcHIt5IjAgKtmf9ywICpNylleRVFM1aqM2yIGUJhYVorM4OrVgNav6AZ
 jR4mGMIHKE9Lg==
Date: Tue, 16 Oct 2018 13:02:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181016130216.3a417381@canb.auug.org.au>
In-Reply-To: <20181015222213.GA31415@roeck-us.net>
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015193914.GA9881@roeck-us.net>
 <20181016073359.3fa7bb32@canb.auug.org.au>
 <20181015222213.GA31415@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Yr/J__N5BmtrbhvJJbwUGSe"; protocol="application/pgp-signature"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/Yr/J__N5BmtrbhvJJbwUGSe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 15 Oct 2018 15:22:13 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Oct 16, 2018 at 07:33:59AM +1100, Stephen Rothwell wrote:
> >=20
> > On Mon, 15 Oct 2018 12:39:14 -0700 Guenter Roeck <linux@roeck-us.net> w=
rote: =20
> > >
> > > On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote: =20
> > > > Hi all,
> > > >=20
> > > > Changes since 20181012:
> > > >=20
> > > > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> > > >    =20
> > >=20
> > > Bisect log:
> > >  =20
>=20
> Trying again. Not very useful since some of the steps fail with compile e=
rrors.
> The problem does seem to be related to the bootmem changes, though.

OK, I managed to do the bisect:

fe3d2a45e8079fdd7d4da1ff07f4b40bc3cb499f is the first bad commit
commit fe3d2a45e8079fdd7d4da1ff07f4b40bc3cb499f
Author: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date:   Sat Oct 13 14:05:51 2018 +1100

    memblock: stop using implicit alignment to SMP_CACHE_BYTES
   =20
    When a memblock allocation APIs are called with align =3D 0, the alignm=
ent
    is implicitly set to SMP_CACHE_BYTES.
   =20
    Implicit alignment is done deep in the memblock allocator and it can
    come as a surprise.  Not that such an alignment would be wrong even
    when used incorrectly but it is better to be explicit for the sake of
    clarity and the prinicple of the least surprise.
   =20
    Replace all such uses of memblock APIs with the 'align' parameter
    explicitly set to SMP_CACHE_BYTES and stop implicit alignment assignment
    in the memblock internal allocation functions.
   =20
    For the case when memblock APIs are used via helper functions, e.g.  li=
ke
    iommu_arena_new_node() in Alpha, the helper functions were detected with
    Coccinelle's help and then manually examined and updated where
    appropriate.
   =20
    The direct memblock APIs users were updated using the semantic patch be=
low:
   =20
    @@
    expression size, min_addr, max_addr, nid;
    @@
    (
    |
    - memblock_alloc_try_nid_raw(size, 0, min_addr, max_addr, nid)
    + memblock_alloc_try_nid_raw(size, SMP_CACHE_BYTES, min_addr, max_addr,
    nid)
    |
    - memblock_alloc_try_nid_nopanic(size, 0, min_addr, max_addr, nid)
    + memblock_alloc_try_nid_nopanic(size, SMP_CACHE_BYTES, min_addr, max_a=
ddr,
    nid)
    |
    - memblock_alloc_try_nid(size, 0, min_addr, max_addr, nid)
    + memblock_alloc_try_nid(size, SMP_CACHE_BYTES, min_addr, max_addr, nid)
    |
    - memblock_alloc(size, 0)
    + memblock_alloc(size, SMP_CACHE_BYTES)
    |
    - memblock_alloc_raw(size, 0)
    + memblock_alloc_raw(size, SMP_CACHE_BYTES)
    |
    - memblock_alloc_from(size, 0, min_addr)
    + memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr)
    |
    - memblock_alloc_nopanic(size, 0)
    + memblock_alloc_nopanic(size, SMP_CACHE_BYTES)
    |
    - memblock_alloc_low(size, 0)
    + memblock_alloc_low(size, SMP_CACHE_BYTES)
    |
    - memblock_alloc_low_nopanic(size, 0)
    + memblock_alloc_low_nopanic(size, SMP_CACHE_BYTES)
    |
    - memblock_alloc_from_nopanic(size, 0, min_addr)
    + memblock_alloc_from_nopanic(size, SMP_CACHE_BYTES, min_addr)
    |
    - memblock_alloc_node(size, 0, nid)
    + memblock_alloc_node(size, SMP_CACHE_BYTES, nid)
    )
   =20
    [mhocko@suse.com: changelog update]
    Link: http://lkml.kernel.org/r/1538687224-17535-1-git-send-email-rppt@l=
inux.vnet.ibm.com
    Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
    Suggested-by: Michal Hocko <mhocko@suse.com>
    Acked-by: Paul Burton <paul.burton@mips.com>    [MIPS]
    Acked-by: Michael Ellerman <mpe@ellerman.id.au> [powerpc]
    Acked-by: Michal Hocko <mhocko@suse.com>
    Cc: Catalin Marinas <catalin.marinas@arm.com>
    Cc: Chris Zankel <chris@zankel.net>
    Cc: Geert Uytterhoeven <geert@linux-m68k.org>
    Cc: Guan Xuetao <gxt@pku.edu.cn>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Matt Turner <mattst88@gmail.com>
    Cc: Michal Simek <monstr@monstr.eu>
    Cc: Richard Weinberger <richard@nod.at>
    Cc: Russell King <linux@armlinux.org.uk>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Tony Luck <tony.luck@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

:040000 040000 9fdad987cc69ffad8de2d0d621facc66b096aac1 c9959a9199e01f282d1=
d291a6280b203a8561e7a M	arch
:040000 040000 de303e4a0ad2b500de3fca2f65c8943c12c0b077 1581aed934cfb96b270=
6df9bfa7746edfadffea6 M	drivers
:040000 040000 f9179d8189f08e3575031a76181a64eedd148db5 293bc953dcfc2b718f5=
c7cdd58722284f4393dec M	include
:040000 040000 3019b5f917a20420537ac5cf4dc90b3c7f1aa56f 1b88f0791341d17abd2=
59d7a8d2e0cc55147d8f6 M	init
:040000 040000 8819d52ce4e6463fc95a2e841baeeddbc9fb8c52 dc167f38bd8c4a80e0a=
c84ecc981e95b98703393 M	kernel
:040000 040000 30c64583e66fc20181d7ce2b6ced9d7e060e1042 4e57b31864cef4e921b=
bd73150f63637a819e3c4 M	lib
:040000 040000 1b341ab0dd034f0fef37c234a771419924e0ecc9 9c489ba60978950733b=
f678191833fdb9689bdab M	mm

# bad: [ca0591d03a2d373e0019ad357fbbee69c8272381] Add linux-next specific f=
iles for 20181015
# good: [3a27203102ebfa67bd0bced05b1def499bb59db2] Merge tag 'libnvdimm-fix=
es-4.19-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect start 'HEAD' 'remotes/origin/stable'
# good: [5a09f4fbf98e45de8341bc8176e62afaac8405f6] Merge remote-tracking br=
anch 'crypto/master'
git bisect good 5a09f4fbf98e45de8341bc8176e62afaac8405f6
# good: [a54eefdf4d208f6904da9e836ff32d7dde0c9516] Merge remote-tracking br=
anch 'tip/auto-latest'
git bisect good a54eefdf4d208f6904da9e836ff32d7dde0c9516
# good: [d71e0d25be750d02a3d04500aeb151bb94465811] Merge remote-tracking br=
anch 'staging/staging-next'
git bisect good d71e0d25be750d02a3d04500aeb151bb94465811
# good: [7961c8ea9d81f927a78e30bb7c194310ed6b7c1d] Merge remote-tracking br=
anch 'pinctrl/for-next'
git bisect good 7961c8ea9d81f927a78e30bb7c194310ed6b7c1d
# good: [c3d392e6aae57d54fdc683f7432c3e248602bebb] Merge remote-tracking br=
anch 'xarray/xarray'
git bisect good c3d392e6aae57d54fdc683f7432c3e248602bebb
# good: [880c1034475c873963d6250eb95ebbbf5604a281] userfaultfd: selftest: c=
leanup help messages
git bisect good 880c1034475c873963d6250eb95ebbbf5604a281
# good: [9f1fa0ab60f7b09d335bbaf33db9116241059708] reiserfs: propagate erro=
rs from fill_with_dentries() properly
git bisect good 9f1fa0ab60f7b09d335bbaf33db9116241059708
# good: [596046ffd571f32fa3d3e7ffdf7861b71a258552] memblock: replace alloc_=
bootmem_low with memblock_alloc_low (2)
git bisect good 596046ffd571f32fa3d3e7ffdf7861b71a258552
# good: [979961b3058df1a6d24ab423dd6fa6f20982f591] memblock: replace BOOTME=
M_ALLOC_* with MEMBLOCK variants
git bisect good 979961b3058df1a6d24ab423dd6fa6f20982f591
# bad: [8fab7180e6cd3126f7be81e8e33c8152b99f046b] mm/memory_hotplug: make a=
dd_memory() take the device_hotplug_lock
git bisect bad 8fab7180e6cd3126f7be81e8e33c8152b99f046b
# bad: [fe3d2a45e8079fdd7d4da1ff07f4b40bc3cb499f] memblock: stop using impl=
icit alignment to SMP_CACHE_BYTES
git bisect bad fe3d2a45e8079fdd7d4da1ff07f4b40bc3cb499f
# good: [2b130e2ae5fdc482305c6d23b05a532addda7c40] powerpc: fix up for remo=
val of linux/bootmem.h
git bisect good 2b130e2ae5fdc482305c6d23b05a532addda7c40
# good: [699f0940861c958f2397c727d80fe324b6d88b06] docs/boot-time-mm: remov=
e bootmem documentation
git bisect good 699f0940861c958f2397c727d80fe324b6d88b06
# first bad commit: [fe3d2a45e8079fdd7d4da1ff07f4b40bc3cb499f] memblock: st=
op using implicit alignment to SMP_CACHE_BYTES

Reverting fe3d2a45e8079fdd7d4da1ff07f4b40bc3cb499f (and the following 2
commits) produces a kernel that boots.
--=20
Cheers,
Stephen Rothwell

--Sig_/Yr/J__N5BmtrbhvJJbwUGSe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvFRqgACgkQAVBC80lX
0GycSAf/bBQrI8BaM4XJ9Ao9pik26B2YnXrF4u3VOfl+J8+qd12N/Ap9cr51FoaG
SS7zyC6+dtRedoCqnMfZ6lHT2ypcQb9yOdgvj+oD9gRMhtiV6mX2kdChedXHXLn7
rtUfqH7hMuv3HVrdQHUCao+xPuT2qvJyZC7aMNqSbeLqmr/En7b7lqqlrF3qOsfY
uaXGymu1VmMG9dRlUGEzerCuZWIyXhgLoPEzNdLqjKrB3YoJFVdVOjWCyQaGoeQT
rQe59W2IQJa2sj6/AI2QMTj8DuBfVCAUHDesvtvDwAXS8acKm36x/IvEk4jvB7FY
CoyaSWlqrCYwxEbMI8Y78vsLvFzuRQ==
=snrg
-----END PGP SIGNATURE-----

--Sig_/Yr/J__N5BmtrbhvJJbwUGSe--
