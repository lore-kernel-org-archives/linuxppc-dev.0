Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E940C10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 07:56:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D0E20645
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 07:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ojwoD39c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D0E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pG400l0fzDqNW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 17:56:32 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pDVz18XtzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 16:46:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="ojwoD39c"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44pDVy25CWz9sBr; Tue, 23 Apr 2019 16:46:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1556001978;
 bh=w7AyAHTD5n08Qh20EwxLTm3C5JNfNlr+pwyvwtl4Yzg=;
 h=Date:From:To:Cc:Subject:From;
 b=ojwoD39cxuDLzHYlpLMDmZVi+VDMpVARlGiVxxHH+RdXCQa2RgCae8xcdN0ZOltO4
 ANM6eTBXViBiY0WsN1qPaHlXCgn7ScZKmXu8ANHC9BCJmE/o2hzHsd3U3D1TKyjr0Z
 qmxuxXsKBVv5tildwRFpBcn8T0o1Qaj9YhbzHRQE=
Date: Tue, 23 Apr 2019 15:41:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Hellwig <hch@lst.de>
Subject: powerpc hugepage leak caused by 576ed913 "block: use bio_add_page in
 bio_iov_iter_get_pages"
Message-ID: <20190423054131.GB31496@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 Nick Piggin <npiggin@gmail.com>, Michael Ellerman <michael@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

576ed913 "block: use bio_add_page in bio_iov_iter_get_pages", applied
late in the 4.19 cycle appears to introduce a regression causing a
huge page leak in a complicated set of circumstances I haven't fully
identified yet.

On a POWER8 machine with a kernel after the commit above, when I run a
KVM guest with RAM in hugetlbfs pages (and certain options, see below), a
handful of the hugepages used for RAM are not released after qemu and
the guest quit.  Usually 2 or 3 16MiB pages are leaked, though I've
seen anything from 0-8 occasionally.

There are a bunch of conditions on when it occurs, only some of which
I've pinned down:

 * It happens on a POWER8 8247-22L, but not a very similar 8247-21L,
   and I haven't been able to work out why, yet.

 * It only happens with certain combination of qemu block and caching
   options for the guest's root fs.  Specifically it appears to happen
   when the file used for the guest's root disk image is opened with
   O_DIRECT.

 * It depends somewhat on guest activity.
     - It doesn't occur if the guest is only booted to firmware
     - Booting only to initramfs without mounting the "real" root fs
       doesn't seem to trigger the problem
     - It appears to happen reliably with RHEL6 and RHEL7 guests, but
       only sometimes with RHEL8 guests, again, I don't know why at
       this stage


I pinned it down to this (host kernel) patch by bisection, and I've
double checked afterwards to confirm it really is this commit, not a
mistake during the bisection.

I've tried a bunch of instrumentation, but it hasn't been very
illuminating so far:

 * The leaked pages have non-zero count and are left in the
   hugepage_activelist
=20
 * The leaked pages *don't* appear to be blocking release of the KVM
   VM or the qemu process owning it

 * The leaked pages *do* appear to be blocking release of the
   associated address_space and (anonymous) inode, though I'm not 100%
   certain about this.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly+pYkACgkQbDjKyiDZ
s5LPsRAAk8A2Atuggdh5NkWqEE1kAUUgWAr3CALxHPnGD4Ny3bc//v+U1d99ZJMh
bIz1sq5NrsqTorb0gpJ26+wW4LDlpHq0ZG7ydWnSjmZuzvYA6UB0/2Mx2DyMloEe
x7jvbgJLN3rWVwA5JoDwoedG41kA+QR91oYy+1xcv9b0p1BBi2Ych1rqptT6HeIq
efRZZiCvozIT+6+e7JmFQYb1YE16ysF+x0NCxeLAWOzeW/WWDJp/YYmQcuZxmlz+
rvFmHss/1Maisi/gx8nKh0aohmvJPKr0rKXL9nvStkKn/i+4Tbcg4F8M31DKIq/F
3/N8okF/EHovor3eFuIoB6QOq8pukSA938V2PGL1yDjLsSUrgasG8QYCQPAGeQlZ
zjh/m/bqrzjzReQbLpo4khea+hV5vuutgpROmBej2wMXt8i4G41hHrSRgGvhnif6
/0mFC0r0yFfqK4DxR3OZPERHeGSAb2JTH3jpdjnM0mCyIRo8JKabMnFhN8B0hnAq
e2rafTJPieqSzau8ruIH3JSGrbg3k/9COfngUmETlxu7eOzOo2n4irnVaAoVCOTV
v4w6tDHMC/xAAy5qIH4rZCyMjVRUsZwV+g2W1+TZ68cZAduZJu78Z12HXLGXR6G6
8xMgPBnZih0mLt3ekD99usVFoKOSbdVYgNdsqPKMpDy/Csu7mBY=
=+jU2
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
