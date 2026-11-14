Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F812606A323
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBSI6JF1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRlcp4GxHz2ypY;
	Sun, 15 Nov 2026 07:11:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794687066;
	cv=none; b=i54u0JLifc6BB72P4VKFZKKCei42llPgdAgQd/KZmfmXWXjpStS0zdbAk1u9jlaPcxD5jwFNx/820r4/acev+lQiTPuth00YkuKh0elwhpC73TitPErRU3MVkes/T2PaevfP95J9KGECLjv8a0SMEBpoiJhGBZUPCWbvUyC69IpDc0fVZsO+vru76Yh+WspINFG95iM6DOpV06qGkg+B3rJcmBtS8yV2vPrNRYG+1Y0Z4LqpSXGzXLySQNvmcqH3Y4NUeAx6D1Je6yMj2OWejFYrPZGTtSgENJr1tbxc4MF3HZvTmlKCnt/2vCPwk6qpinZ3hwzlUflTTQVIp/2lKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794687066; c=relaxed/relaxed;
	bh=8l+12b6m4tjoQkXqXgXCvA2lEKsZmoFOuBWiDGcCyxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GfEEVInF3rzxp0mEQnfJBDCoieRP9nZFUc40DguvR6CylkgfsaTvUvM0ViozSDaN1G/iZGgwPTIAN1/Ezn8XRtVQg+BblqtjdCBVX8hGCedRcGHVb0QRIQhwCCdwukbq5IpDzwE8C/prtTocO0wglQuLhlhx+adyrUMwk0ymmZ534QngYVmOk5j4SVRxiAAIeiDqx7lUKfCDbb/kyVR7G620mxZR9sbFJuIW/qWtpM4kBivNOJKfAeQ4mgu6aWbqX3Abu1Zf6qy8Xzzc5EnCBUjeP2hZT+yRvXfuY+pEjTedVCvB4LQqR5JBFAFhdxAyw1SkGHR5tr1+Ktqnhh8eJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBSI6JF1; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=alx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBSI6JF1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=alx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRlcn2SYrz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 07:11:05 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7933E618BD;
	Sat, 14 Nov 2026 20:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136DB1F000C5;
	Sat, 14 Nov 2026 20:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794687062;
	bh=8l+12b6m4tjoQkXqXgXCvA2lEKsZmoFOuBWiDGcCyxw=;
	h=Date:From:To:Cc:Subject;
	b=eBSI6JF1lDfzpJJDi7TK0oMXlsKjtQ7UNRLafCsJuvHgULdsOyvFqLf/kJpzwcSMw
	 r3v2KldMc24FCma3IuwM0nBwF8Hi/lEtrLfbGQ4rAGA/nfjzfzx8alb2h19HlOXlVR
	 8j3nRTRQlRwiBovwHGFQ2Rg4AEJ5dwGHqJdryE1NGQ/oqmiXy08KSYSxVbSXVa89Oj
	 K41c0pi32TJK04JoBA3tuDkISSW2zOUjzekpP22FDBGocyPXl97x47lTeGlcN5D8DH
	 PO+BZuIWTPO3bGkzyer1h0De6DB/HZohW65dP52xPkSpPGOenRWBybGswNuOyuMYUN
	 YmQDxwICtDocg==
Date: Sat, 14 Nov 2026 21:10:58 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	alx+linux-hardening@kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v1] powerpc: Fix off-by-one bug
Message-ID: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ys7an7pdgy32so6a"
Content-Disposition: inline
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--ys7an7pdgy32so6a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	alx+linux-hardening@kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v1] powerpc: Fix off-by-one bug
Message-ID: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
MIME-Version: 1.0

=46rom the surrounding similar calls, the intention seems obvious: this
seems intended to check for a prefix.

However, I do not understand this code, so take my reading with a grain
of salt.

Fixes: a048a07d7f453 ("powerpc/64s: Add support for a store forwarding barr=
ier at kernel entry/exit")
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

I found this while looking into replacing this code with calls to
strprefix().

 arch/powerpc/kernel/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 600596cb4ffb..37999555bfe6 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -273,7 +273,7 @@ enum stf_barrier_type stf_barrier_type_get(void)
 /* This is the generic flag used by other architectures */
 static int __init handle_ssbd(char *p)
 {
-	if (!p || strncmp(p, "auto", 5) =3D=3D 0 || strncmp(p, "on", 2) =3D=3D 0 =
) {
+	if (!p || strncmp(p, "auto", 4) =3D=3D 0 || strncmp(p, "on", 2) =3D=3D 0 =
) {
 		/* Until firmware tells us, we have the barrier with auto */
 		return 0;
 	} else if (strncmp(p, "off", 3) =3D=3D 0) {
--=20
2.55.0


--ys7an7pdgy32so6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr4wFIACgkQ64mZXMKQ
wqkSTQ/9Hl6YBCGT4ghLfidjZfi5Br8fuavBYgESR82RDZB/BJGlXWUoj9wcdnWN
JzQPQgDQPE0oWF1jm54rUZgrntBNDMzvuBT5l9QRJa7gf6PDw44DKeNDv1d1P6J0
TzSHek5YKoAkNWI6K9nRabXWGqwGnwwP0ICcfZSoTvV6u2KunSGVQCm6y+rN2s8I
xsZKBxq2oc204UiddF14m8WA5WrUBO4v8+Fn1fT7W43qztLwz/olTUmg9dg7qqI4
eqQLqIRMKT80H303iyeR06LrcMMvOnUUlSEI6HbK+czzGidLi6eDZxq/rRWEQuls
PAK5X563XyDWupHl8wOkFZKOqtEXRyWBkDwGUxmQIb2KY3Ac9cmq4VY+4h/AkZSS
qAo9stRufUbZGI7ysmWpkao+PoeT2mD5vkU+Mdt5EAS91J0bQGl9GW+TS/eZNgO5
GELjmQ1m4+gEDpuanoOiml/h00w85L58kpyupHF1hP4tcpyE1dJHjBtvgAmMtLaO
a3Ej4DMXZi2/IEnw4f8ppjM6Ec72qaOVIbXoiyFtChLTfYuAkwAn09Slo4Q4mKs+
Per3v/Q0HEGE13hR7E/InaXVP75qNNUIxt671RIxc+K73dus/XjFEt8PltUCjxl0
q2FN3zdKmOLUurBDxFZB+XZyJn6USwIRo0H1TlAy3XoO3/VVXZ4=
=VL6+
-----END PGP SIGNATURE-----

--ys7an7pdgy32so6a--

