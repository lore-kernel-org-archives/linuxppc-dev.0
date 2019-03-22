Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7262DC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 04:26:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA361218FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 04:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA361218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QVwY38gvzDqTW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 15:26:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=decadent.org.uk
 (client-ip=88.96.1.126; helo=shadbolt.e.decadent.org.uk;
 envelope-from=ben@decadent.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=decadent.org.uk
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QVth13J0zDqRm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 15:25:00 +1100 (AEDT)
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
 (envelope-from <ben@decadent.org.uk>)
 id 1h7BjR-0004jM-99; Fri, 22 Mar 2019 04:24:43 +0000
Date: Fri, 22 Mar 2019 04:24:37 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20190322042436.nttfgsdpdshco27y@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3rsjgymvjrdefjkn"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] powerpc: vdso: Make vdso32 installation conditional in
 vdso_install
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
Cc: linuxppc-dev@lists.ozlabs.org, 785065@bugs.debian.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--3rsjgymvjrdefjkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The 32-bit vDSO is not needed and not normally built for 64-bit
little-endian configurations.  However, the vdso_install target still
builds and installs it.  Add the same config condition as is normally
used for the build.

Fixes: e0d005916994 ("powerpc/vdso: Disable building the 32-bit VDSO ...")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 488c9edffa58..3def265cf1cf 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -406,7 +406,9 @@ endef
 ifdef CONFIG_PPC64
 	$(Q)$(MAKE) $(build)=3Darch/$(ARCH)/kernel/vdso64 $@
 endif
+ifdef CONFIG_VDSO32
 	$(Q)$(MAKE) $(build)=3Darch/$(ARCH)/kernel/vdso32 $@
+endif
=20
 archclean:
 	$(Q)$(MAKE) $(clean)=3D$(boot)

--3rsjgymvjrdefjkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlyUY3QACgkQ57/I7JWG
EQnd3Q//eCE95/yRfbhIaZMRhEbY1SdMa8Lzqra/TOhK33Wcvw0D2qdc2yNNXFbx
9KqQ4KnKseEav51Oa6yYhwotviN6ZOJtrwJTUfn3E4ZdPXP7CbJzh6DA0e90IrU4
cjhbwR9U6iyhMSd0d+UDhk0aoAvRalCYKMQR7DbmLy57O/93Gjx1BmD7m2xhnjx3
io2F3mVCZ9bXzSjjwmQjuZFMoL5Fjjy4lksW8x4LgKpk4U+9MYZXAicraoh5s2Iv
Ypa1yrjChlzTvidx+mrRqpvC+kbkFpII6aG7hY5RwVu/Yt7NfON+JJW6lMOiCreN
SVSQTRgQ/2fyfJAFE9RJveVpNtHfmN6iCVlXLi/xyOPYfLDnobTBfoAqX2XjWwfj
/99/pImZh5XI1+phXEOXc1VQDkCns3FPHUb9kKtDRhDOKC2MjdS7LisM85ItHlhM
LCkby7d+z/foRJvWDQYaKzf0VgvM2g8/YsILr9Unv2u3grLbnMlINS0+sIGbrUrX
Q7p743+TERSzwgWM4bRULELqL0dTj61hHLXtR3uqY7jwPFr9vV58s5co0K7GZJqo
Pv24+JovhNczQg5bwswJil1rVvV7BRA/f+BTY3Wz8eeBqeV1cwM6LCCv/bqydmaS
92o2S4MeDWa5b7DOoZhsqkP21bfieJ6r81ww+9T91fWF4jmYVUM=
=UtPA
-----END PGP SIGNATURE-----

--3rsjgymvjrdefjkn--
