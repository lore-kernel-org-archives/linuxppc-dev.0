Return-Path: <SRS0=npwJ=RU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB05CC43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 02:03:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19142184C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 02:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19142184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44MMzl5fc0zDqQP
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Mar 2019 13:03:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=decadent.org.uk
 (client-ip=88.96.1.126; helo=shadbolt.e.decadent.org.uk;
 envelope-from=ben@decadent.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=decadent.org.uk
X-Greylist: delayed 2634 seconds by postgrey-1.36 at bilbo;
 Sun, 17 Mar 2019 13:02:05 AEDT
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44MMy52scwzDqD1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2019 13:02:05 +1100 (AEDT)
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
 (envelope-from <ben@decadent.org.uk>)
 id 1h5KR2-0003J6-Ss; Sun, 17 Mar 2019 01:17:57 +0000
Date: Sun, 17 Mar 2019 01:17:56 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20190317011756.abjylw3nzfnc6gnh@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6t5kletm6yrjkgna"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM
 configurations
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--6t5kletm6yrjkgna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

MAX_PHYSMEM_BITS only needs to be defined if CONFIG_SPARSEMEM is
enabled, and that was the case before commit 4ffe713b7587
("powerpc/mm: Increase the max addressable memory to 2PB").

On 32-bit systems, where CONFIG_SPARSEMEM is not enabled, we now
define it as 46.  That is larger than the real number of physical
address bits, and breaks calculations in zsmalloc:

    mm/zsmalloc.c:130:49: warning: right shift count is negative [-Wshift-c=
ount-negative]
      MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
                                                     ^~
    ...
    mm/zsmalloc.c:253:21: error: variably modified 'size_class' at file sco=
pe
      struct size_class *size_class[ZS_SIZE_CLASSES];
                         ^~~~~~~~~~

Fixes: 4ffe713b7587 ("powerpc/mm: Increase the max addressable memory to 2P=
B")
Cc: stable@vger.kernel.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/include/asm/mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 25607604a7a5..2bc8c3f04f8a 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -341,7 +341,7 @@ static inline u16 get_mm_addr_key(struct mm_struct *mm,=
 unsigned long address)
 #if defined(CONFIG_SPARSEMEM_VMEMMAP) && defined(CONFIG_SPARSEMEM_EXTREME)=
 &&	\
 	defined (CONFIG_PPC_64K_PAGES)
 #define MAX_PHYSMEM_BITS        51
-#else
+#elif defined(CONFIG_SPARSEMEM)
 #define MAX_PHYSMEM_BITS        46
 #endif
=20

--6t5kletm6yrjkgna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlyNoD8ACgkQ57/I7JWG
EQmaYBAAt9g6bvxoz3CmRc9fMbx9E+mfVO9UNS7lyl4K2s0CjL5qitof3KtWSUwL
E+NbMFCsVZJ84AkjpJ+y7Wu/IqWdQcLXXkvgUHcJjPLhlwZ+reW7AmyuDpRObubq
kDmCL1IncfvrqchjEo4HZ534ul/sDln6Sf0ojQg/HD6gymzP9F9Vg+x4fAOv4JXc
fg8s/jeV8FFcGzgMjUvd9f2caeU+EIAVcp3eAM+tO11f+3tc4vGlPPiPcb7q5NxX
X1z5Y3/nQTq3yHRNVg0meJJwbYztn49wQ0ZR6/fH5fieVHcVSlyFmtjKvRoFnaw9
x2gQuDcFnzd807Z3McaA3KSaQV8U2hiO4MboM9tYHWMCo4gIrTqSeYG5kZZTsHZ/
vnXgnELX4ybx8xz4Y4BNQUo3NPdakcZXjmhtftOcg4mbexOiK1Bl3MjZ5k9FAmes
/7FKPD02NgfLub7Ou647zLnC5g4WO2gb7LgcEW3YbioXCd4bAF8yGzCdGZDu+PYy
tk0OQy7ZRMU14to8IrxCzx/oBl/BOOFsy5mbTY2c3tkGxf9EBkm9YM+hETXQvxsr
geg9g55KfZMb1vpYE3YQAHkbJQ3TZUO0BqdlLUkimnOY8Bt3Bb2OoVpKb3M1B+ns
eSLTuOKX5WzNmthIgde3jp+ax81sQqszb6sR0GH1ckrcAFdm56E=
=zim7
-----END PGP SIGNATURE-----

--6t5kletm6yrjkgna--
