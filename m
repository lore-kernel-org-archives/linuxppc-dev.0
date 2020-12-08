Return-Path: <SRS0=iKYh=FM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161BFC4361B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 12:08:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B9922C7D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 12:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B9922C7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqzTZ3DRczDqQY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Dec 2020 23:08:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqzLn0xK0zDqMM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2020 23:02:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=o4J2J2b4; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CqzLb6bnhz9sVn;
 Tue,  8 Dec 2020 23:01:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1607428921;
 bh=JEri3CU8kWrV81KglUKUp+7iowgZEiWf9+9m9XNHnMc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=o4J2J2b40/3bQfI+Auy2gC8waE4x0NCrBR/jCkCWWGBr/Tl5GsMQCJrXeuGqioy4q
 gxskM6vJDXpNQZ1ZfwHQsiUxBKWsIW8Bu+ToxNDNAKY7PC9uI03kW5JpiV0PsvrEUP
 bNMOjG3/ew2r3pBL5Oh0xSibhLFio3aBK9vlra1/U8Zh+tMMPGTeWDAI5Dk9U3d5fc
 xTuUd2VwNw4d2c5FKGnRKgIKTCtz9ZJ4fJxIQWntU1cBlFkkt9IXjlXa0u1vZqAp+N
 50u1qFmz3uIjNCftsyPdiI9V+G5oMyxh9r+8zhc6yy67apUiBj3XQRWpvc2Nz7JuMf
 4NQfP0qygF1DA==
Date: Tue, 8 Dec 2020 23:01:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: build warning after merge of the akpm tree
Message-ID: <20201208230157.42c42789@canb.auug.org.au>
In-Reply-To: <20201204210000.660293c6@canb.auug.org.au>
References: <20201204210000.660293c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FcK_nGNcdk4IZE8gzaZ87Qo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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
Cc: Kees Cook <keescook@chromium.org>, Mathieu Malaterre <malat@debian.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/FcK_nGNcdk4IZE8gzaZ87Qo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Fri, 4 Dec 2020 21:00:00 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi all,
>=20
> After merging the akpm tree, today's linux-next build (powerpc
> allyesconfig) produced warnings like this:
>=20
> ld: warning: orphan section `.data..Lubsan_data177' from `arch/powerpc/op=
rofile/op_model_pa6t.o' being placed in section `.data..Lubsan_data177'
>=20
> (lots of these latter ones)

781584 of them today!

> I don't know what produced these, but it is in the akpm-current or
> akpm trees.

Presumably the result of commit

  186c3e18dba3 ("ubsan: enable for all*config builds")

from the akpm-current tree.

arch/powerpc/kernel/vmlinux.lds.S has:

#ifdef CONFIG_PPC32
        .data : AT(ADDR(.data) - LOAD_OFFSET) {
                DATA_DATA
#ifdef CONFIG_UBSAN
                *(.data..Lubsan_data*)
                *(.data..Lubsan_type*)
#endif
                *(.data.rel*)
                *(SDATA_MAIN)

added by commit

  beba24ac5913 ("powerpc/32: Add .data..Lubsan_data*/.data..Lubsan_type* se=
ctions explicitly")

in 2018, but no equivalent for 64 bit.

I will try the following patch tomorrow:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 8 Dec 2020 22:58:24 +1100
Subject: [PATCH] powerpc: Add .data..Lubsan_data*/.data..Lubsan_type* secti=
ons explicitly

Similarly to commit

  beba24ac5913 ("powerpc/32: Add .data..Lubsan_data*/.data..Lubsan_type* se=
ctions explicitly")

since CONFIG_UBSAN bits can now be enabled for all*config.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinu=
x.lds.S
index 3b4c26e94328..0318ba436f34 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -296,6 +296,10 @@ SECTIONS
 #else
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
+#ifdef CONFIG_UBSAN
+		*(.data..Lubsan_data*)
+		*(.data..Lubsan_type*)
+#endif
 		*(.data.rel*)
 		*(.toc1)
 		*(.branch_lt)
--=20
2.29.2

--=20
Cheers,
Stephen Rothwell

--Sig_/FcK_nGNcdk4IZE8gzaZ87Qo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl/PazUACgkQAVBC80lX
0Gz11wgAhzi/cE1n0K51pPVWQ2WdxspNEl2+9Nst5oZsnWYPae6UeDHxSaLegFHX
RW9X1VpB5SqcwNspo0aBBl1fGGU+XleJt6mi17r1xNE6G8fCbsYTAXYbb0s5z0wh
W++Qf/MoepUOmnM25LJvAM9jZ7XUj3z1Nys2CQnLXxKR1YyvO911RmNwMUXpTMiu
D+sukC0NY0B6VDy1ffuH7UlRY1cTOE6EwiV5YW7xF0UFtzbXWtIBt49eh7rFdkMV
rU7MirxnECHFENWa2II0I+EfGPLrbmPI0V6MIEF46NuxpERh1WaIhO9UeOZ+ADGc
aDx/c97p0/QQaq5T4QNeoemt9tYzLA==
=O0Y/
-----END PGP SIGNATURE-----

--Sig_/FcK_nGNcdk4IZE8gzaZ87Qo--
