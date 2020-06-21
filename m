Return-Path: <SRS0=vJY5=AC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14BEC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2020 06:54:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE2E24829
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2020 06:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="DgmW9dC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE2E24829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49qNZg5VMMzDqjj
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2020 16:54:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=85.215.255.24;
 helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=DgmW9dC/; 
 dkim-atps=neutral
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49qNG649sNzDqg8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2020 16:40:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1592721621;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:Cc:Message-Id:Subject:Date:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=+Tvi0LDe0B9iwAHBPweCGmIXnyiXr/te6rYmedqq9AQ=;
 b=DgmW9dC/GWTGKBK8JI11F9K9DgPW7IEHEKiuMGlbCLdbY47YYub9dw1CWExzk5ZhhZ
 ZIkX+rBACJlSeCIcVcgN84LZvM7xNnEy7p/fXk82mQfdzeOgk+S29erhOiT+WoS+yaLd
 ujd1sOBsZG6EGhPUnz336BVxE/a8Hd/O0hDNjT0PJDH1dVj+a4qVkRZ2pHk8DZqP8DU1
 h9ewznp1f2ZPJaBnJX9Xl+HfUvF0WiKRpRlyx7g1UaNRikqftbNP5LNwfQf3+7y9pwLi
 mK/Yk8v1x+zIJc2JovjFG7fFb6y8DP1EvVEkcMpqaALVAuqFVge5qA/odMIPut1z04bR
 9DTg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7aWdxiboxknTzOqX0GiCmXNzTL0vPXE3f7PkieW51"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:d002:df2e:e143:9708:ccc1:31a0]
 by smtp.strato.de (RZmta 46.10.4 AUTH)
 with ESMTPSA id m08564w5L6eFSE8
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sun, 21 Jun 2020 08:40:15 +0200 (CEST)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-E3A8421F-B332-4EF5-8EF8-178DBCC3A721
Content-Transfer-Encoding: 7bit
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Date: Sun, 21 Jun 2020 08:40:14 +0200
Subject: FSL P5020/P5040: DPAA Ethernet issue with the latest Git kernel
Message-Id: <56DB95B8-5F42-4837-ABA0-7E580FE04B73@xenosoft.de>
To: agordeev@linux.ibm.com
X-Mailer: iPhone Mail (17E262)
X-Mailman-Approved-At: Sun, 21 Jun 2020 16:53:30 +1000
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
Cc: Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--Apple-Mail-E3A8421F-B332-4EF5-8EF8-178DBCC3A721
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Alexander,

The DPAA Ethernet doesn=E2=80=99t work anymore on our FSL P5020/P5040 boards=
 [1] since the RC1 of kernel 5.8 [2].
We bisected last days [3] and found the problematic commit [4]. I was able t=
o revert it [5]. After that the DPAA Ethernet works again. I created a patch=
 for reverting the commit [5]. This patch works and I will use it for the RC=
2.
Could you please check your commit? [4]

Thanks,
Christian

[1] http://wiki.amiga.org/index.php?title=3DX5000
[2] https://forum.hyperion-entertainment.com/viewtopic.php?p=3D50885#p50885
[3] https://forum.hyperion-entertainment.com/viewtopic.php?p=3D50892#p50892
[4] lib: fix bitmap_parse() on 64-bit big endian archs: https://git.kernel.o=
rg/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D81c4f4d924d5d009=
b5ed785a3e22b18d0f7b831f
[5] https://forum.hyperion-entertainment.com/viewtopic.php?p=3D50982#p50982



--Apple-Mail-E3A8421F-B332-4EF5-8EF8-178DBCC3A721
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto">Hello Alexander,<div><br></div><div>The DPA=
A Ethernet doesn=E2=80=99t work anymore on our FSL P5020/P5040 boards [1] si=
nce the RC1 of kernel 5.8 [2].</div><div>We bisected last days [3] and found=
 the problematic commit [4]. I was able to revert it [5]. After that the DPA=
A Ethernet works again. I created a patch for reverting the commit [5]. This=
 patch works and I will use it for the RC2.</div><div>Could you please check=
 your commit? [4]</div><div><br></div><div>Thanks,</div><div>Christian</div>=
<div><br></div><div>[1]&nbsp;<a href=3D"http://wiki.amiga.org/index.php?titl=
e=3DX5000">http://wiki.amiga.org/index.php?title=3DX5000</a></div><div>[2]&n=
bsp;<a href=3D"https://forum.hyperion-entertainment.com/viewtopic.php?p=3D50=
885#p50885">https://forum.hyperion-entertainment.com/viewtopic.php?p=3D50885=
#p50885</a></div><div>[3]&nbsp;<a href=3D"https://forum.hyperion-entertainme=
nt.com/viewtopic.php?p=3D50892#p50892">https://forum.hyperion-entertainment.=
com/viewtopic.php?p=3D50892#p50892</a></div><div>[4] lib: fix bitmap_parse()=
 on 64-bit big endian archs:&nbsp;<a href=3D"https://git.kernel.org/pub/scm/=
linux/kernel/git/torvalds/linux.git/commit/?id=3D81c4f4d924d5d009b5ed785a3e2=
2b18d0f7b831f">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D81c4f4d924d5d009b5ed785a3e22b18d0f7b831f</a></div><div>[5=
]&nbsp;<a href=3D"https://forum.hyperion-entertainment.com/viewtopic.php?p=3D=
50982#p50982">https://forum.hyperion-entertainment.com/viewtopic.php?p=3D509=
82#p50982</a></div><div><br><div dir=3D"ltr"><br></div></div></body></html>=

--Apple-Mail-E3A8421F-B332-4EF5-8EF8-178DBCC3A721--
