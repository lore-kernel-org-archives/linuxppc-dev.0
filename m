Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369FAC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 05:18:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977662186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 05:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LSZa3j3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977662186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LcNt74cjzDr9B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 16:18:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LSZa3j3q";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LcL70SCgzDqsK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 16:16:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="LSZa3j3q"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43LcL640cjz9s9G;
 Fri, 21 Dec 2018 16:16:30 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1545369390;
 bh=ISWk+WOrKWvQEamQkmzmkrnfq+IfcK+e7YbtmGEyJWM=;
 h=Date:From:To:Cc:Subject:From;
 b=LSZa3j3qqJdwxb6UdHd91yU8tnLZJBi4Cx1N3kbo5X3nIOdRi0590U+tmmrgxnBAB
 M5oEIctTQZ9/Myblw9Ue6jZEnu1k8VxTbTpfEM8doVjoRFmg8eep/k9E0DqInMLBES
 HZDvX9SJ11X0/x6PSVfEUWmcu17QdOOKD/ou8mPBcpHJTy2/Z2nF6YVjwZiUE04gSf
 xxVH9ACAW9sA7Ff9S79N87bF7cJbdJjMsQNU7OWR/ZW/Ppbxi61GrIDkoDxOItr1EX
 04znqiUjKye5xPOuos8ZarfIbDJib7b30G6Gxll3VpnVV290dTuioZ+u5CVp1gH1pU
 j7575aDRdcSDw==
Date: Fri, 21 Dec 2018 16:16:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?=
 <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the kvm tree with the powerpc tree
Message-ID: <20181221161629.34429a4c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1Tu+T81aBrhnsG8kUuDRLI+"; protocol="application/pgp-signature"
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/1Tu+T81aBrhnsG8kUuDRLI+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/powerpc/mm/fault.c

between commit:

  49a502ea23bf ("powerpc/mm: Make NULL pointer deferences explicit on bad p=
age faults.")

from the powerpc tree and commit:

  d7b456152230 ("KVM: PPC: Book3S HV: Implement functions to access quadran=
ts 1 & 2")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/mm/fault.c
index c866d9a710fe,2e6fb1d758c3..000000000000
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@@ -650,9 -636,9 +650,10 @@@ void bad_page_fault(struct pt_regs *reg
  	switch (TRAP(regs)) {
  	case 0x300:
  	case 0x380:
+ 	case 0xe00:
 -		printk(KERN_ALERT "Unable to handle kernel paging request for "
 -			"data at address 0x%08lx\n", regs->dar);
 +		pr_alert("BUG: %s at 0x%08lx\n",
 +			 regs->dar < PAGE_SIZE ? "Kernel NULL pointer dereference" :
 +			 "Unable to handle kernel data access", regs->dar);
  		break;
  	case 0x400:
  	case 0x480:

--Sig_/1Tu+T81aBrhnsG8kUuDRLI+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwcdy0ACgkQAVBC80lX
0Gz55Af9Hb0oQbR+WvZr//StQJa+AP0WJs9+QGPFONEX7LjCCwESIjKRB4nXvD/Z
jy57wyBzJd4SyfkTnzmJfGgwYl55kP+ALq8eoWLjhuzt+qNqLdWssdCYu87R6KEl
Vy7JzK1Uld8m/fymRKLh9w/b8aev06qcuZ1GfLclvT+LJXk9xlLISzMAnpfdcp8V
TrVaqJHEGicH/Bsbmp6kVPXchgyAzaeLxQuG0uKExCofD8OUhSzvdoRJxwGbaQaC
NhPOobXXOpyGNVYcxWVyqOQLeKYNDdJf7ZApotpm2hbZVwkeYVgHyyuMehV6+JFt
0admZHYABDZz52XVC/EIZ167n270aQ==
=uXXL
-----END PGP SIGNATURE-----

--Sig_/1Tu+T81aBrhnsG8kUuDRLI+--
