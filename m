Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF1FC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 11:00:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CAA20825
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 11:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="posa2GH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CAA20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wdg72tZfzF3dB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 22:00:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=yadro.com header.i=@yadro.com header.b="posa2GH/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=a.fomichev@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="posa2GH/"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wcRz0R8ZzDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 21:05:19 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 4D33B4190F;
 Thu, 15 Nov 2018 10:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 mime-version:content-transfer-encoding:content-id:content-type
 :content-type:content-language:accept-language:message-id:date
 :date:subject:subject:from:from:received:received:received
 :received; s=mta-01; t=1542276315; x=1544090716; bh=6Dx6RBEtohpi
 0k02hiuz5w6zjk0vNuLZZGvU970+3Zg=; b=posa2GH/I7Ye8RPaF95eWNJysRQ4
 qbZliEutyvTPmfO4tC4uTbiWXMTWUFl8E9T56nL9Xw/hy1ENhvbfZiD8ABxpLDHL
 qw3UQldzTMY2qH0NliGr2DH+C0tLFpLqX/QD9tGXF4lMLfJMUP2VPci05CJ31yHY
 8CpHihFr2HUlUSA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PV-RukrAeiH3; Thu, 15 Nov 2018 13:05:15 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com
 [172.17.10.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 8997C404D1;
 Thu, 15 Nov 2018 13:05:15 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (172.17.10.102) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 15 Nov 2018 13:05:15 +0300
Received: from T-EXCH-02.corp.yadro.com ([fe80::45c7:9467:6da:3de3]) by
 T-EXCH-02.corp.yadro.com ([fe80::45c7:9467:6da:3de3%14]) with mapi id
 15.01.0669.032; Thu, 15 Nov 2018 13:05:15 +0300
From: Alexander Fomichev <a.fomichev@yadro.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Unexpectedly dma_ops is NULL in struct device
Thread-Topic: Unexpectedly dma_ops is NULL in struct device
Thread-Index: AQHUfMq0STcNxU9fSEyVDNoSD3/6fQ==
Date: Thu, 15 Nov 2018 10:05:15 +0000
Message-ID: <01D3121E-A92B-4200-9777-5D416B7D0EED@yadro.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.14.111]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5629163B5D23947AE3D1F21DD2D2D0B@yadro.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 15 Nov 2018 21:57:53 +1100
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
Cc: Logan Gunthorpe <logang@deltatee.com>, "linux@yadro.com" <linux@yadro.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

I tried to use Switchtec NTB on PowerPC platform and faced a strange behavi=
our. In ntb_hw_switchtec module's initialization section the "struct device=
" has uninitialized field dma_ops (NULL). Meanwhile the same NTB hardware o=
n x86 platform get correct dma_ops in this driver. It looks like on lower l=
ayer "struct device" init differs between x86 and powerpc.
This issue makes functions dma_set_mask() and dma_set_coherent_mask() and d=
ma_alloc_coherent() fail in ntb_hw_switchtec. And the driver can't start on=
 powerpc.

Can anybody help to trace this issue?=20
Thanks in advance.

Best regards,=20
Alexander=
