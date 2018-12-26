Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E10CC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 14:35:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE01B218AD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 14:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE01B218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43PwWC6TmXzDqM4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 01:35:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=decadent.org.uk
 (client-ip=88.96.1.126; helo=shadbolt.e.decadent.org.uk;
 envelope-from=ben@decadent.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=decadent.org.uk
X-Greylist: delayed 1122 seconds by postgrey-1.36 at bilbo;
 Thu, 27 Dec 2018 01:34:01 AEDT
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43PwT53P7NzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 01:34:01 +1100 (AEDT)
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
 (envelope-from <ben@decadent.org.uk>)
 id 1gc9xn-0001ml-O9; Wed, 26 Dec 2018 14:15:12 +0000
Date: Wed, 26 Dec 2018 14:15:11 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <20181226141511.3ag7uf6rvdgzlmxt@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h2w7hll4xji3uevo"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] powerpc: Fix -mcpu= options for SPE-only compiler
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
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
Cc: debian-kernel@lists.debian.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--h2w7hll4xji3uevo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

GCC for Debian's "powerpcspe" architecture only supports 32-bit
SPE targets, and using -mcpu=3Dpowerpc or -mcpu=3Dpowerpc64 is a fatal
error.

* Change the test for a biarch compiler to pass both the -m32 and -m64
  options, so that it doesn't catch 32-bit-only compilers
* Add an ifdef CONFIG_PPC64 around the 64-bit CPU option definitions

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 488c9edffa58..c2e815863500 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -12,7 +12,7 @@
 # Rewritten by Cort Dougan and Paul Mackerras
 #
=20
-HAS_BIARCH	:=3D $(call cc-option-yn, -m32)
+HAS_BIARCH	:=3D $(call cc-option-yn, -m32 -m64)
=20
 # Set default 32 bits cross compilers for vdso and boot wrapper
 CROSS32_COMPILE ?=3D
@@ -166,6 +166,7 @@ CFLAGS-$(CONFIG_PPC32)	+=3D $(call cc-option, $(MULTIPL=
EWORD))
=20
 CFLAGS-$(CONFIG_PPC32)	+=3D $(call cc-option,-mno-readonly-in-sdata)
=20
+ifdef CONFIG_PPC64
 ifdef CONFIG_PPC_BOOK3S_64
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 CFLAGS-$(CONFIG_GENERIC_CPU) +=3D -mcpu=3Dpower8
@@ -177,6 +178,7 @@ endif
 else
 CFLAGS-$(CONFIG_GENERIC_CPU) +=3D -mcpu=3Dpowerpc64
 endif
+endif
=20
 ifdef CONFIG_FUNCTION_TRACER
 CC_FLAGS_FTRACE :=3D -pg

--h2w7hll4xji3uevo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlwjjOcACgkQ57/I7JWG
EQldRhAAsVbR6UqeqLFI+gW9MIc6cKebdJ7L7V3YPKWqNg+eXmCaSEt5N3gP30Jh
ywAb0oYBWyk2CD1meiWZFb5jIzXVcwKlJCCXc/9Cvs4i9fDkIFU4UuG/L2EHT+4S
+e9+pWAujXtF5dT3w3z5RED2e3YCD7SpJo1sfDiyJpPF7oE8IZLVDo5cFiYfEf9P
MUqeSWuDlOLdP6NSRX3lYTh6cBWpY0zgzwozQvwSKJ40NPkvXMZZdCuSSwEdBcjX
4eYzMqed3YLaZj83EWrYoIVXeovSibhyFRZWgQD+uSwc56bqUw8KcntOCq/fDKa4
yWdxXhZKWJy8lvi6kwpFpIe9yTy2+Yhf18a0oZcEYjReszC9jrXxJWoHaa+4NurA
3EZBWGowLMYapvzufQUPnKEPvl50bfU+oZqvbc0lSFtdnIhuEE4Hfj3hpQwJQZ2B
5ejdJDXEBIBcj4YN8gNeigEI4z5A8CcNY7xRQzh6BhITyESr12erwaujqGlKlNsp
zOUT0R1v0uZFiJDrl3vANIPJSc8YMewZsm+9HxLrYo4Lyd1fscZxtgY7QDSpES1j
ji84gssXW7xP7j6aQRsQt3LZIGQgAh4tQ9FGQ8rqBfQoT/uKf6wKwgycavV+aj6P
0soZW1zG0KpOmf+ogPQvCOxFPSzCA2i63AIlSk/QMM8opO8Xkqo=
=k7+R
-----END PGP SIGNATURE-----

--h2w7hll4xji3uevo--
