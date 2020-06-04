Return-Path: <SRS0=7wTx=7R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01C4C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 14:22:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E592206E6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 14:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="hgYPaeRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E592206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49d7K52RTZzDqk9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 00:22:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=85.215.255.20;
 helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=hgYPaeRw; 
 dkim-atps=neutral
X-Greylist: delayed 183 seconds by postgrey-1.36 at bilbo;
 Fri, 05 Jun 2020 00:19:43 AEST
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49d7Fq28dlzDqnp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2020 00:19:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1591280378;
 s=strato-dkim-0002; d=xenosoft.de;
 h=Date:Message-ID:Cc:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=ygKPnpamEYxLU/fdFnOJBQ0eN2fmW8pC+HVfPpHCQWc=;
 b=hgYPaeRwbGVaQPRgJRIdpM/yVDe+AB7wzmFrm7xQBUUgU/o75cOKX9hKdcuPv1nf/B
 Z10/dGabuWTGM2K1AzayNVnduOuLHk2x5PA6KR6Q5qZX2YfAFazX7jqDdLwrtS9PDuTL
 2vdV8Q7tCGsr/vrR9J6lIiqsZaknctOlczOGVDYXx7dwiNaIttntmjg+f1iBQ9MyXgye
 xKvW2zbWiq11UAj3ODvesEWnLIxalEvwtfvCKqLqUx9n9sgo8VvnK3HVahvQqKDTJeVG
 tyM5fw71qohe+3POqeqDOQxPOEfo1H8RXKW4bwP4wLS0zkQ56wc4bAfRZaOqcBwcTSZk
 2TZg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhWJo850fbCHQg2MY0iSsESPq17hQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:50e8:a711:3515:222f]
 by smtp.strato.de (RZmta 46.9.1 AUTH) with ESMTPSA id w06ffew54EGV8hj
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 4 Jun 2020 16:16:31 +0200 (CEST)
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>, Darren Stevens <darren@stevens-zone.net>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Boot issue with the latest Git kernel
Message-ID: <cca69c35-899b-38d8-73ee-2d62997484e5@xenosoft.de>
Date: Thu, 4 Jun 2020 16:16:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
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
Cc: "R.T.Dickinson" <rtd2@xtra.co.nz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi All,

I tested the latest Git kernel today. [1]. Unfortunately it doesn't boot 
on my PowerPC machines.

Could you please test the latest Git kernel with your PowerPC machine?

BTW, it doesn't boot in a virtual QEMU PowerPC machine either.

Thanks,
Christian

[1] 
https://forum.hyperion-entertainment.com/viewtopic.php?f=58&p=50758&sid=3f816f078869510dea9fe4baca3605db#p50758
