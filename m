Return-Path: <SRS0=BFlh=LR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06352C4743C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 06:05:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBBC60FD8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 06:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBBC60FD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8t673CqRz3c0P
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 16:05:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=CqDCbHJz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=canb.auug.org.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=sfr@canb.auug.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=CqDCbHJz; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8t5X5GZbz2xZK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2021 16:04:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4G8t5T6kYdz9sVm;
 Wed, 23 Jun 2021 16:04:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1624428286;
 bh=zGFQryYP618aKWsIAzWK267Cz0lCeMlvKnIsCfwMrKA=;
 h=Date:From:To:Cc:Subject:From;
 b=CqDCbHJzlzQ8Gh+HmoHkHgwxMKl8Wy91jEk3Gl2Kx0tHS6lJ9OBlFuJjOZVVSlGoQ
 pChq8YWyZl8ayjFJNuCGGBSGxo65UBikQwKEjUmI+/JVgVAteGaEWcxvPv9Ohhk1uV
 76WLr5UyEZgAkHx5NlfAKIjYX23GUgXBkpeXhzBccffQuIrQ6cNFVKbKt502YlWqIg
 X9DR05RXH/pAYl9vMir3/oWss+K9z83N0WVj+wAtY5aqYsNaRttehyeyXHvMLVEZRv
 Gdn7EpkOUmhmQKVlBHBQlPIr2SxdWtNYReP4moX+Yv34lEPpIlTypBKrCPTJIkf8Dg
 2AjmR3TTo0U6g==
Date: Wed, 23 Jun 2021 16:04:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoffer Dall <cdall@cs.columbia.edu>, Marc Zyngier <maz@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Paolo Bonzini <pbonzini@redhat.com>, KVM
 <kvm@vger.kernel.org>
Subject: linux-next: manual merge of the kvm-arm tree with the powerpc and
 kvm trees
Message-ID: <20210623160444.413791ec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_S5Z7DmvPJ.DCnyaey19BjI";
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
Cc: Ashish Kalra <ashish.kalra@amd.com>, Brijesh Singh <brijesh.singh@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bharata B Rao <bharata@linux.ibm.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Steven Price <steven.price@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/_S5Z7DmvPJ.DCnyaey19BjI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  include/uapi/linux/kvm.h

between commits:

  b87cc116c7e1 ("KVM: PPC: Book3S HV: Add KVM_CAP_PPC_RPT_INVALIDATE capabi=
lity")
  644f706719f0 ("KVM: x86: hyper-v: Introduce KVM_CAP_HYPERV_ENFORCE_CPUID")
  0dbb11230437 ("KVM: X86: Introduce KVM_HC_MAP_GPA_RANGE hypercall")

from the powerpc and kvm trees and commit:

  ea7fc1bb1cd1 ("KVM: arm64: Introduce MTE VM feature")

from the kvm-arm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/uapi/linux/kvm.h
index 330835f1005b,da1edd2b4046..000000000000
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@@ -1083,10 -1083,7 +1083,11 @@@ struct kvm_ppc_resize_hpt=20
  #define KVM_CAP_SGX_ATTRIBUTE 196
  #define KVM_CAP_VM_COPY_ENC_CONTEXT_FROM 197
  #define KVM_CAP_PTP_KVM 198
 -#define KVM_CAP_ARM_MTE 199
 +#define KVM_CAP_HYPERV_ENFORCE_CPUID 199
 +#define KVM_CAP_SREGS2 200
 +#define KVM_CAP_EXIT_HYPERCALL 201
 +#define KVM_CAP_PPC_RPT_INVALIDATE 202
++#define KVM_CAP_ARM_MTE 203
 =20
  #ifdef KVM_CAP_IRQ_ROUTING
 =20

--Sig_/_S5Z7DmvPJ.DCnyaey19BjI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmDSzvwACgkQAVBC80lX
0Gy43wf/WucH04KA5/4fIZG1aO2Pglwt2RKuNbBPCxq8Gii9/cBVWr7hXoPm9wls
CYeLOqv7Je7PPKaRgtJKBfRoJmbxrK2Zl+VkaZRFgS5SydFCfRzLImeuSv66I4EX
u3jmv0MWEOLQgXlKDMblEZvznuPuIhvjR4rM1wlhfFv9ii32uUn+EwIlDNGz+bPv
C+jSuq7/gu9TlHtsP8zyAHmDfMqDv+1Kqko9ZTrk82URydhKpoOZlRm3gyhviUWw
t+P0CjEypszRwnoVPHD5yWwxOLkjy/dnx6QeQxsCIKp0QASyPq+K6PZXg3gfChq3
M9aPKADLiNI6w7DpYV7jn526s6ynew==
=QDit
-----END PGP SIGNATURE-----

--Sig_/_S5Z7DmvPJ.DCnyaey19BjI--
