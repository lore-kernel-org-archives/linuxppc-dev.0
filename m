Return-Path: <SRS0=QKuW=3W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DEAC35249
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Feb 2020 00:12:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6911F20661
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Feb 2020 00:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="bzZqisX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6911F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 489BHQ0SXSzDqfq
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Feb 2020 11:12:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 489BFs11cdzDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Feb 2020 11:11:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=bzZqisX4; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 489BFr4dt0z8tPV
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Feb 2020 11:11:28 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 489BFr4PDyz9sRW; Sun,  2 Feb 2020 11:11:28 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo6-p01-ob.smtp.rzone.de (client-ip=2a01:238:20a:202:5301::5;
 helo=mo6-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=bzZqisX4; 
 dkim-atps=neutral
X-Greylist: delayed 157 seconds by postgrey-1.36 at bilbo;
 Sun, 02 Feb 2020 11:11:26 AEDT
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 489BFp4gkzz9s29
 for <linuxppc-dev@ozlabs.org>; Sun,  2 Feb 2020 11:11:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580602282;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:Subject:From:References:Cc:To:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=M2p6BlJKlzc7zwD9OCcddn1toLSZU/FWLhGgP48heGQ=;
 b=bzZqisX4TTdFe6F8iDg017ER9VXqXGVvqCrMOlFfFVPNGfYIT9WO/4EF3nyrvox6Sa
 E6NUuKhqGxrFx9z2T14iSIu9yoDMKeYWZHQRkuMID5QLSgRzibc4jlelMNhQvkVNejMl
 ZpDoL5UCnvCvnCp+KKML6wGRseWq4M6VQ6+o2mtpytF3DI1+tKlRsTfTP6U2ZsncJM4T
 F8qr2ZaH9iNf+Py0YThXmPDVBxMXcJPIh914MTKDXP3YqQnJ5XRySyG1qEz+fxMQPDH0
 gSnpJGonsbIhHFeIe0egeo49Dh96u5Aek/jrPpEn3rC8227f00OMVyx8XG/MZduJhulr
 QdVg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhSLlpvF7aofGh9KUohSyVOsmPy"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:188b:8a2:e727:e5f1]
 by smtp.strato.de (RZmta 46.1.12 AUTH)
 with ESMTPSA id 40bcf3w1208HBpI
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sun, 2 Feb 2020 01:08:17 +0100 (CET)
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20200126115247.13402-1-mpe@ellerman.id.au>
 <CAPDyKFrbYmV6_nV6psVLq6VRKMXf0PXpemBbj48yjOr3P130BA@mail.gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Latest Git kernel: avahi-daemon[2410]: ioctl(): Inappropriate ioctl
 for device
Message-ID: <58a6d45c-0712-18df-1b14-2f04cf12a1cb@xenosoft.de>
Date: Sun, 2 Feb 2020 01:08:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrbYmV6_nV6psVLq6VRKMXf0PXpemBbj48yjOr3P130BA@mail.gmail.com>
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
Cc: DTML <devicetree@vger.kernel.org>, Darren Stevens <darren@stevens-zone.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org, "contact@a-eon.com" <contact@a-eon.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

We regularly compile and test Linux kernels every day during the merge 
window. Since Thuesday we have very high CPU loads because of the avahi 
daemon on our desktop Linux systems (Ubuntu, Debian etc).

Error message: avahi-daemon[2410]: ioctl(): Inappropriate ioctl for device

Could you please test the latest Git kernel?

It is possible to deactivate the avahi daemon with the following lines 
in the file "/etc/avahi/avahi-daemon.conf":

use-ipv4=no
use-ipv6=no

But this is only a temporary solution.

Thanks,
Christian
