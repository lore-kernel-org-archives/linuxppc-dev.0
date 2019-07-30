Return-Path: <SRS0=hRxk=V3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC1CC76186
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 03:20:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA93C206B8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 03:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rU36D1G1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA93C206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45yMJP2ddnzDqS5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 13:20:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45yMGM0TlLzDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2019 13:18:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="rU36D1G1"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45yMGL31dsz9sBF;
 Tue, 30 Jul 2019 13:18:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1564456730;
 bh=aIWtuuU2oqEixpaxrfNoPqD/tQwT5Vsy+zMn9kQmMvo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rU36D1G12wN5iQVufrnRhumMN+oMDZAxsHKd5YOKONn5Wxf+8HUTfz8QSPw/tqZCG
 ZJQOntg4cpPwrXmMJOwHnbfVN5p8Gw3Xq+bnx/SsxvPyqKUI6DmLeGwSoNYoS6oao0
 Y2Oc/kejPJ5dEkh/Gnl/wcMGf7l8RmksaUiJGvvpdkFR3HmXfKg8rePOru1kT+nlKd
 J8BwITqp9IeDvKDTXNLUijb42+Fzn6gbjM7BHpHgV1vZBHsGlwC4b7d/KMmd52uirl
 eridoV6z5KL93Wj9O23Fy40mN0aNWJzhxQjYI3yDLvvkxtb+gMtufgDFkdH6drxmea
 DuLuC4bg8tW3A==
Date: Tue, 30 Jul 2019 13:18:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] powerpc/kvm: Fall through switch case explicitly
Message-ID: <20190730131849.4d704abe@canb.auug.org.au>
In-Reply-To: <30ecba4e-a232-ad28-4c1a-5a173a7ac7cc@embeddedor.com>
References: <20190729055536.25591-1-santosh@fossix.org>
 <20190729181651.4b9586a7@canb.auug.org.au>
 <30ecba4e-a232-ad28-4c1a-5a173a7ac7cc@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5x3.=yExsVuPkcZHWu9FDrC";
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
Cc: Santosh Sivaraj <santosh@fossix.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Kees Cook <keescook@chromium.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/5x3.=yExsVuPkcZHWu9FDrC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 29 Jul 2019 18:45:40 -0500 "Gustavo A. R. Silva" <gustavo@embeddedo=
r.com> wrote:
>
> On 7/29/19 3:16 AM, Stephen Rothwell wrote:
> >=20
> > On Mon, 29 Jul 2019 11:25:36 +0530 Santosh Sivaraj <santosh@fossix.org>=
 wrote: =20
> >>
> >> Implicit fallthrough warning was enabled globally which broke
> >> the build. Make it explicit with a `fall through` comment.
> >>
> >> Signed-off-by: Santosh Sivaraj <santosh@fossix.org> =20
>=20
> Reviewed-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>=20
> Thanks!
> --
> Gustavo
>=20
> >> ---
> >>  arch/powerpc/kvm/book3s_32_mmu.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3=
s_32_mmu.c
> >> index 653936177857..18f244aad7aa 100644
> >> --- a/arch/powerpc/kvm/book3s_32_mmu.c
> >> +++ b/arch/powerpc/kvm/book3s_32_mmu.c
> >> @@ -239,6 +239,7 @@ static int kvmppc_mmu_book3s_32_xlate_pte(struct k=
vm_vcpu *vcpu, gva_t eaddr,
> >>  				case 2:
> >>  				case 6:
> >>  					pte->may_write =3D true;
> >> +					/* fall through */
> >>  				case 3:
> >>  				case 5:
> >>  				case 7:
> >> --=20
> >> 2.20.1
> >> =20
> >=20
> > Thanks
> >=20
> > Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >=20
> > This only shows up as a warning in a powerpc allyesconfig build.
> >  =20

I will apply this to linux-next today (and keep it until it turns up in
some other tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/5x3.=yExsVuPkcZHWu9FDrC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0/txkACgkQAVBC80lX
0Gx4Vgf8C6LoCIynMEHnhq8lLhqV8aKs1aH1yySVy9BTS/Xwr/6hT18WEQfub7dm
LVybe4on81CCIUEGPYEaMn0p8zMObgloCdiE1wXXdCMBj5rSuWt+3rkErEVwpbmi
tpwaV++Vnzu4x+1yYLqJswGrKQuShpDJz3NN0COFJq+DVCZPclfyJ4a5OY76cD9o
WyG76reawillD5KvFCNeGbOQZw/le7P0eynJrpcv7wHV9K+clXn9QgvpJ9YyB2CW
zusp53FB0dRSTRpXckfzH8UdL1JGQ3WYmHdEDwdq3CAANn7ZsFrPYAr0dL0ByGmh
hv4gnKU2f+IMFCidJ/XaCLu4fZvnqw==
=Itor
-----END PGP SIGNATURE-----

--Sig_/5x3.=yExsVuPkcZHWu9FDrC--
