Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C59C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 14:26:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178D220833
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 14:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="m2u0Rvcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178D220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dqNC3Mc0zDqLD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 00:26:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::2; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="m2u0Rvcr"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dqKn6rHFzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 00:24:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554819838;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:Message-Id:Subject:Date:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=NOXQ5M1ic1IjwTD2JyU40JUNS9yOtBDtdVPGBHC+uJ8=;
 b=m2u0Rvcr5UByja28D/tGJLuOQNkVh7vJbP9AYigO1pRGdsWNOnY5PrTtmcvhFnBzbn
 OhDh1fy5F1R+keC81biRHBS9vc/41j3AkWU9XJGs0fXFW7NAS4yTfolvw00nN2esEf1a
 D2SvKDGJ8yWxh4sNqS+edS9yZW+MGs1MNV0MijwnnZWKM34ZmvEX8j6r+HjSca0VUTfT
 x3RO6DQG7/Y0YPpl00US9Q9RFcb4e5GU21iIfXVUTOX/H115Uh169oMzwvkDxK9RkhbZ
 Vnpf11oao3n4vhh/g1zy/ZfXuCQAxsRd1rte62JN49FFbOLeQOTb/Rus9ej21g6T6AL6
 lMIA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7b25xg7pjlXFypl5u00F6tPf1m6/uargugGfuv++8"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:b908:6a73:5c62:1e9f:902a:d801]
 by smtp.strato.de (RZmta 44.18 AUTH) with ESMTPSA id v09a9cv39ENu2dk
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Tue, 9 Apr 2019 16:23:56 +0200 (CEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date: Tue, 9 Apr 2019 16:23:55 +0200
Subject: [PATCH] powerpc/mm: Define MAX_PHYSMEM_BITS for all 64-bit configs
Message-Id: <28474076-EA16-42B7-928E-747972306146@xenosoft.de>
To: linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net, olof@lixom.net
X-Mailer: iPhone Mail (16D57)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi All,

Shall I activate FLATMEM or SPARSEMEM for the Nemo board with the PA6T-1682M=
 SoC?

Thanks,
Christian=
