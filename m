Return-Path: <SRS0=+bYb=OD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F21C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 09:17:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E713D20865
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 09:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="mau90dxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E713D20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4326y45cV4zDqVf
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 20:17:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="mau90dxG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::7; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="mau90dxG"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4326vG2hB8zDqVh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2018 20:14:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1543050867;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=3n/TtzjGoQrGXHflw0tnMyPSBEQoLAM/2BS54S5TrSs=;
 b=mau90dxGIabrbbgufxYuLUNc91dl9AXc5f6JLHFy/u7gFcQSu+7h2+e7stZAP4ai3r
 tBCWP0sJi1fSUesy2IptnClG65ITAmNNVT4KsCo0+PWqyPt5QXDM7yr+N74FtSTkfELN
 P6W/joDpl9CJxrrH6MgM9P114q6G3C+cKM5wsTpNY+7pokVufPnvidvj1H6l1ICeHkkF
 6RQr2g8U1kzSndzbHaQDdiw6beDS0WlYNVkFZKD6N3/FlRYC6Gf8IkbPcmFMu7WTVjcr
 +QqsYYU7/lTmvABukXP2YzrzzoZT0F+5WpJpYgb/7T/Ax1tU5fQOnkllsdDszVaLMvK3
 3EjA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4Ql+BpvNtdS8exnpinP0JAbBX8S5TJng6d4MbmVgn"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:b95b:477:b06f:4eba]
 by smtp.strato.de (RZmta 44.4 AUTH) with ESMTPSA id L01e52uAO9EGABH
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Sat, 24 Nov 2018 10:14:16 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Spectre+Meltdown
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20181123195955.1bdcdd80@kitsune.suse.cz>
Date: Sat, 24 Nov 2018 10:14:14 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D1BF717-CF1C-45CC-89B3-01D6590C6A31@xenosoft.de>
References: <36E75811-C758-49B1-8E5C-3A2C44FD5DE9@xenosoft.de>
 <874lnzz5y3.fsf@concordia.ellerman.id.au>
 <86eade29-a56d-2aab-050e-366f4d43ab2f@xenosoft.de>
 <CAOesGMhGt6arTt9p9rxT8Qreaucae0i=fmQoqkBvUGJOxobhiQ@mail.gmail.com>
 <CAOMqctS0d9i5F1si3mDq_M1ZZM1MncXRBFKGeZ4y30J4H_1RDg@mail.gmail.com>
 <32e12e24-750d-eb98-0753-f5feca309082@xenosoft.de>
 <CADRPPNRtexannDrv8WtD2f3sQr9nwkN2PPgvh6m2r4d6BvqitQ@mail.gmail.com>
 <20181123195955.1bdcdd80@kitsune.suse.cz>
To: =?utf-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
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
Cc: Olof Johansson <olof@lixom.net>, Michal Suchanek <hramrach@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Li Yang <leoyang.li@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 23. Nov 2018, at 19:59, Michal Such=C3=A1nek <msuchanek@suse.de> wrote:

With this summary paper https://arxiv.org/abs/1811.05441 it should be
possible to take the manual for your favourite CPU and see which
exploitable optimizations it does have, and how are these exploits
mitigated.

Thanks

Michal


Hi Michal,

Thanks for the hint. Here is the status of our machines:

FYI:

X1000, CPU: PWRficient PA6T-1682M, kernel 4.20-rc3: grep . /sys/devices/syst=
em/cpu/vulnerabilities/*

/sys/devices/system/cpu/vulnerabilities/l1tf:Not affected
/sys/devices/system/cpu/vulnerabilities/meltdown:Vulnerable
/sys/devices/system/cpu/vulnerabilities/spec_store_bypass:Vulnerable
/sys/devices/system/cpu/vulnerabilities/spectre_v1:Mitigation: __user pointe=
r sanitization
/sys/devices/system/cpu/vulnerabilities/spectre_v2:Mitigation: Software coun=
t cache flush

--------

X5000/020, CPU: P5020 (e5500), kernel 4.20-rc3: grep . /sys/devices/system/c=
pu/vulnerabilities/*

/sys/devices/system/cpu/vulnerabilities/l1tf:Not affected
/sys/devices/system/cpu/vulnerabilities/meltdown:Not affected
/sys/devices/system/cpu/vulnerabilities/spec_store_bypass:Not affected
/sys/devices/system/cpu/vulnerabilities/spectre_v1:Mitigation: __user pointe=
r sanitization
/sys/devices/system/cpu/vulnerabilities/spectre_v2:Mitigation: Software coun=
t cache flush

The PA6T is still vulnerable.

Cheers,
Christian=
