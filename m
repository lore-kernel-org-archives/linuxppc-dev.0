Return-Path: <SRS0=Nfv6=VJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08775C742A8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 08:43:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A042084B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 08:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WuNZwoFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A042084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45lRKl482bzDqtG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 18:43:55 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45lRHR28fqzDqtd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2019 18:41:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="WuNZwoFg"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45lRHM60K8z9s00;
 Fri, 12 Jul 2019 18:41:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1562920914;
 bh=XMy057h7tEqUdteK4IfiKdKfqoRVIuXrEgiej/z+E30=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WuNZwoFgEMQjylkarzZqrwhJHJfSfAndylVc8H1asf7TwExA9LFB1MP3+Srbny6Ng
 WSOf0n3AGT7y5G3JbpPC5b/mZ1C+DUsSqZu8IRGsEcnmyrsyAKBnQEKj4bgiElRZJ7
 FoBTUDC/NS1IYvTwzIJ9nJtfCb1GFOG1F2t+x70/3PAABZxkHw5+Gr1JNHW9Ux6FuE
 6pubM+Y4ILGevkpkgO+O3xxhqCWmEFgSZGWQnJhEF+G0ywFrnmk65nKWC5h+HNMV4f
 zPAiyDMVfCPFVcfNcYKaAYG1IvEWh2eax1FXdUMu87XijfMykOVdQPEgxtc/b03FFc
 eef1WUOMABWmg==
Date: Fri, 12 Jul 2019 18:40:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V2] mm/ioremap: Probe platform for p4d huge map support
Message-ID: <20190712184055.47a7a54b@canb.auug.org.au>
In-Reply-To: <87tvbrennf.fsf@concordia.ellerman.id.au>
References: <1561699231-20991-1-git-send-email-anshuman.khandual@arm.com>
 <20190702160630.25de5558e9fe2d7d845f3472@linux-foundation.org>
 <fbc147c7-bec2-daed-b828-c4ae170010a9@arm.com>
 <87tvbrennf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gEMDf8pJbcBsPcmqhs4eMy2"; protocol="application/pgp-signature"
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
Cc: x86@kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/gEMDf8pJbcBsPcmqhs4eMy2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 12 Jul 2019 17:07:48 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> The return value of arch_ioremap_p4d_supported() is stored in the
> variable ioremap_p4d_capable which is then returned by
> ioremap_p4d_enabled().
>=20
> That is used by ioremap_try_huge_p4d() called from ioremap_p4d_range()
> from ioremap_page_range().

When I first saw this, I wondered if we expect
arch_ioremap_p4d_supported() to ever return something that is not
computable at compile time.  If not, why do we have this level of
redirection?  Why not just make it a static inline functions defined in
an arch specific include file (or even just a CONFIG_ option)?

In particular, ioremap_p4d_enabled() either returns ioremap_p4d_capable
or 0 and is static to one file and has one call site ...  The same is
true of ioremap_pud_enabled() and ioremap_pmd_enabled().
--=20
Cheers,
Stephen Rothwell

--Sig_/gEMDf8pJbcBsPcmqhs4eMy2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0oR5cACgkQAVBC80lX
0Gzspwf/VrAAnMW4h6ldvfqp7zGCa4zwIPADkPvWSNBoahsOMNPdBxKy/NjSosk4
9HSdh6ediokUaf9wY3ZTNacC8wlg5LRk8g9FZlcT4de4qSx5Fk7sIy4rXY7HrhBZ
uTyxqI19f8AlG3JCzfxBuA+/xgKl7/KctQC70jAWFGItK0DM0V08dkWVJ1MUBAra
QwXtOIFA2TNMFleSAM19/lvZiKG8mkWjrv1wBZtDPbVPg87UfSPLcS9XplOVd1in
FnI2Zz/xDu5853kJFQl1ERorfRDMqnUXGRHNl3L+6+KZoeVp8pHBoS5pYC/6B/Er
APSpYNV5gTnvKd8cpVJEw/3uUmEJgw==
=5AC8
-----END PGP SIGNATURE-----

--Sig_/gEMDf8pJbcBsPcmqhs4eMy2--
