Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2622AC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 07:23:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9241320844
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 07:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="f5lQEI2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9241320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ych74gs1zDqNl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 18:23:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p02-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5302::6; helo=mo6-p02-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="f5lQEI2F"; 
 dkim-atps=neutral
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ycfJ5zG1zDqN5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 18:21:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549869684;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=2+Wj7m7ySIuMfGlN7asIXsR+ghoPH8tIEa6cdB4icBU=;
 b=f5lQEI2FHVRNI3aGn0FgwtxjkMukssMgEFNfe/Ax/F6bMbtpx5v/pEyKqs5DnkyObt
 CVkC2+rQzvLR+VLiGxz5l6HsXxifv9D8mMu5EKdUEtXjhnHnph5msDoJYSh8rZwrEgLq
 +nEHnXuHEvVBEe7K30uLR43EuDnMJEj5AsnqRizigULjzJacqCW0Kdde0s3Gj43Ko1Pt
 eKP12oy2J4pWNpvXIVQ6jTh6tty8yGMVv9bnclGdswXlf09bcn2KVEzgF6nxILy/jvht
 SINli9i1zzb1GBv4fZvYY5BFMaLOkVfn/6r2cdKlO3P1EGKZWGNqHnvsKxmKkhYteqIu
 w3UQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7NWZ5grpnxnRrZcnSnXxCNGtcwUruZsoM1Hh3rrCw"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:8189:222c:8934:2abd:8ff5:5de2]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv1B7LBGUZ
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Mon, 11 Feb 2019 08:21:11 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <0042290A-2939-4EBA-A638-D404FA2055ED@xenosoft.de>
Date: Mon, 11 Feb 2019 08:21:11 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <0807B9CE-69E6-45A6-A029-1AAE5615CC8E@xenosoft.de>
References: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
 <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
 <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
 <20190208091818.GA23491@lst.de>
 <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de>
 <0042290A-2939-4EBA-A638-D404FA2055ED@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

Mario successfully tested a kernel from your Git [1] on his T2080rdb today.

Link to the log:=20
https://gitlab.com/oshw-powerpc-notebook/T2080customizations/blob/master/ker=
nel/dma_fix/kernel_dma_fix_log.txt

He wrote:

Please, note that all of the above kernel runs just fine with the T2080rdb, h=
owever did not had the time to test extensively (tested: login into MATE gra=
phical desktop environment, used ArctiFox for opening couple of websites, th=
en played Neverball).

=E2=80=94=E2=80=94

Cheers,
Christian

[1] http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-=
dma.6=
