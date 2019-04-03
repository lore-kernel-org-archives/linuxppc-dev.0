Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A23C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 03:55:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7D7206C0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 03:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="LBY5FO5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7D7206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ysg306BQzDqQj
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 14:55:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::12; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="LBY5FO5N"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Ysbd6pB2zDqPy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 14:52:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554263542;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:Message-Id:Subject:Date:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=Vlj9OUElgpitjsheBprLtfbIAqfrRJ6GzllqsPszTzM=;
 b=LBY5FO5N4L4S1uC5YgXpSHBPLSrbEpfIzvEAfExAlHL7kH3NWsTIpMv+52zaslIVQG
 nBr20FO0TymmyyPnUFZhHeL4jeYOgCVvBIiZ+HSzAJXtm3kU6O1Hk2W952VLUmMHVWIc
 6jMNoCCgUyQ04kWxPhq3W6Aw+tmvG9U2aakIH6H0T0+Gav0L0q+Jwwh7UkV+y3V6MhUA
 5Z2C4/komDXWEorvwxFl3PVMr7CVl8Hbt6MYNIUKE/DvDA1EFsklouPygRNVkG2GAGAa
 uIosO1PjUUrouwbpLDdVbq7oGHKmp4NRMyrLeB+ePs77/Egl63GE5q+wIXslBCU8QvWU
 DaBA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7b2dxiro3l39avDTmSAZyJmitBxcYuMsHO0AVzHs="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:b001:bc9a:f0ed:f235:8d3b:8ba]
 by smtp.strato.de (RZmta 44.18 AUTH) with ESMTPSA id k00e1ev333qLt0a
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 3 Apr 2019 05:52:21 +0200 (CEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date: Wed, 3 Apr 2019 05:52:21 +0200
Subject: VLC doesn't play videos anymore since the PowerPC fixes 5.1-3 
Message-Id: <19FEC425-987D-4B95-AEFD-FF7C05990242@xenosoft.de>
To: linuxppc-dev@lists.ozlabs.org
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

Please test VLC with the RC3 of kernel 5.1.

The removing of the PowerPC fixes 5.1-3 has solved the VLC issue. Another us=
er has already confirmed that [1]. This isn=E2=80=99t an April Fool=E2=80=98=
s. ;-)

Thanks

[1] http://forum.hyperion-entertainment.com/viewtopic.php?f=3D58&t=3D4256&st=
art=3D20#p47561=
