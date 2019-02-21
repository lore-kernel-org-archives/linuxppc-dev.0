Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83601C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 13:53:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C603A2084F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 13:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C603A2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444wsP5LLwzDqRR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 00:52:57 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444wqG06qDzDqQ8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 00:51:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444wqD2k07z9rxp;
 Fri, 22 Feb 2019 00:51:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, j.neuschaefer@gmx.net
Subject: Re: [PATCH v4 04/16] powerpc/mm/32s: use generic mmu_mapin_ram() for
 all blocks.
In-Reply-To: <790cf44815f8c56b3c600560bad9139f63be9f68.1550692943.git.christophe.leroy@c-s.fr>
References: <cover.1550692943.git.christophe.leroy@c-s.fr>
 <790cf44815f8c56b3c600560bad9139f63be9f68.1550692943.git.christophe.leroy@c-s.fr>
Date: Fri, 22 Feb 2019 00:51:01 +1100
Message-ID: <87o9755jy2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Now that mmu_mapin_ram() is able to handle other blocks
> than the one starting at 0, the WII can use it for all
> its blocks.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/pgtable_32.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index b4858818523f..2bf9bf8867d4 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -254,26 +254,17 @@ static void __init __mapin_ram_chunk(unsigned long =
offset, unsigned long top)
>=20=20
>  void __init mapin_ram(void)
>  {
> -	unsigned long s, top;
> -
> -#ifndef CONFIG_WII
> -	top =3D total_lowmem;
> -	s =3D mmu_mapin_ram(0, top);
> -	__mapin_ram_chunk(s, top);
> -#else
> -	if (!wii_hole_size) {
> -		s =3D mmu_mapin_ram(0, total_lowmem);
> -		__mapin_ram_chunk(s, total_lowmem);
> -	} else {
> -		top =3D wii_hole_start;
> -		s =3D mmu_mapin_ram(0, top);
> -		__mapin_ram_chunk(s, top);
> +	struct memblock_region *reg;
> +
> +	for_each_memblock(memory, reg) {
> +		unsigned long base =3D reg->base;
> +		unsigned long top =3D min(base + reg->size, (unsigned long)total_lowme=
m);

This gives me:

In file included from ../arch/powerpc/mm/pgtable_32.c:22:
../arch/powerpc/mm/pgtable_32.c: In function =E2=80=98mapin_ram=E2=80=99:
../include/linux/kernel.h:846:29: error: comparison of distinct pointer typ=
es lacks a cast [-Werror]
   (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
                             ^~
../include/linux/kernel.h:860:4: note: in expansion of macro =E2=80=98__typ=
echeck=E2=80=99
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~
../include/linux/kernel.h:870:24: note: in expansion of macro =E2=80=98__sa=
fe_cmp=E2=80=99
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
../include/linux/kernel.h:879:19: note: in expansion of macro =E2=80=98__ca=
reful_cmp=E2=80=99
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
../arch/powerpc/mm/pgtable_32.c:261:23: note: in expansion of macro =E2=80=
=98min=E2=80=99
   unsigned long top =3D min(base + reg->size, (unsigned long)total_lowmem);
                       ^~~
cc1: all warnings being treated as errors
../scripts/Makefile.build:276: recipe for target 'arch/powerpc/mm/pgtable_3=
2.o' failed


For 44x/bamboo_defconfig.

cheers
