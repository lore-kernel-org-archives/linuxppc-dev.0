Return-Path: <linuxppc-dev+bounces-24403-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1559FC4451B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jul 2026 07:36:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2JVV3xLlz3c89;
	Sat, 18 Jul 2026 17:36:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.53 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784360162;
	cv=pass; b=eHpnyMAYDi1hLHwsyEiOb8cCZLzYHsPavyh2BNKjEOPEmJgbcqfOuIikcBjt9UxHpf5neFk8fVObH4Jd7qEgtPD7oJOYeHSkA/iNJsVnFnI91xigcv4H2/5vjb99374Zx9PJOh3Es7r+7w72EetQe13NmczjDOIiBYZPr87CCVFtO5Yece2G5NiVajymP7RBr0A0oI9m99TMKN5PZ6r7U8RSZIeFP3Z7SrUldFHCwXpK+TRhjeiZg1pGEAiSnmC5ATkOPE2WdyawyS/jxVpszqeSxw64N9WG9VOq8fzo7NMzqkP1YLyBTtD44n2axsjYOiii74roUhx/1+UoOVkRcw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784360162; c=relaxed/relaxed;
	bh=0tbd9eIynpCcFNvu0tDpYKVIEEAcJWSMR8BWz+rY1cM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=CX+N1S7rpg0NL0R01gxmad3vPlGtuNtt63rlPuyrYRAparx4Yt7UVuu5xemoU1ayY/G6mN1zAwaWhwp81QlFcB/B9jNqmidKL48Orm4TbJpgh+qXTFvIxNojEl0uOpGPkR6dcGQ36oU8l/Kf/oCpZGRVCeBRcIRJ2jNwpR+QREUQADncgGUpBLL6Uu8b22uMFXEaC1PMUqZMLgVKIAsfFMhUzQlV2Hb0V7PnP3BX8wK6+H97kcV/TNRqdq2kIhQz+N/kAsCXJN0NrtnI5FuE1cwRObtgcaH+bTwfzO/jYzVjGf19p24ka+6gwFDwVImNO6xlqM7YezC4j4R+UQQbdg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Kz59Pf5f; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=eYhhsw1X; dkim-atps=neutral; spf=pass (client-ip=85.215.255.53; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Kz59Pf5f;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=eYhhsw1X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.53; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h2JVN50Ngz3c7R
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 17:35:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1784360145; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XnLp6kQafvvcrPtQSrUrPrJNApT6uBo2LHRnelxGeTA6JwujNWe02VI8DamIDk0ymO
    VS6GH+ZBOgpYi8J0RWzHxrIjwS7UwgtPXS6JcdH+SprdRersgKzSafpcN7ECaxXFBYqB
    ByxG/8/+N/LoSKYtYKYhpfwL4rs2an/yvXTe+jTPxjzWiJ8FGHLulhP+9h4L7jwMj1QX
    0tapS8MAfpAGEwTgpJLFBooV5UUWBcT06SyGahlN/A8PDu/hTpRWNgJfoE+hq0H8jDD/
    LXECvuTkmVSw3BMbWenxBj5oU75+C+JfrPyYfdVFuOGnmPhJxaddsk5ejuKtMFltsTdI
    mBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784360145;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=0tbd9eIynpCcFNvu0tDpYKVIEEAcJWSMR8BWz+rY1cM=;
    b=UQURTbKAQMo2aRbfC3Eb5apJJuLsX8UgEeIW8HKLNUU0CZnE41zmYQDY2fh/g96hUV
    IZYeqUtPZj9AIKeTKrOwP8v6zeM4P9B3AYR5TqwSrQQBT3PB/p8nuWI6k4VtDd542Zn/
    el2pQzwziv68KHPCEHuXBf75/wH0BV9Ujb8HCN1+YwokMyeiiigkQMop8UiA4OX1sNHl
    2aw4E9v0OL/bDqBjuiVrIuOT2DtjTZdndawgNWgshkHoGFGzHL4ZbtrwVBqpLE27oV/L
    yA4UPDfU2sPvcQnxCAfaEagJr8KXpvkPSmxdn67ZLSFbh/9SNjDJ2JQslnThLh8thpYA
    kLkA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784360145;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=0tbd9eIynpCcFNvu0tDpYKVIEEAcJWSMR8BWz+rY1cM=;
    b=Kz59Pf5fw17gMvs35TbI1Kb6Qt4Oe6B4yGC4tuqMXGSw8CHLh/H4fKotbSsTzHNijL
    4nipaigkOWoygx8IOpbPcUUf8Q/OwwqnE8bN7Rac/HSThTxTYxBU8d5zLIyv6u96O1Ys
    wrXQ2fTv+IUyBnByD+p2Lxf/hZ8o1VQZ3p3NjkHkDGdRePQleAOpzlllh6yXQjJARQTy
    qPgmnrN/od+gJWUQJ2bQY8HY7mhvRubTj5BVUoiyuzYzU0TPKZpgMCbAU5XTbblguKcG
    kCBghQKOHcoiI+wvb6UkCLJnD50hSXRw7YgUJHaI580njBCJX9KUN44RACVogfJmGW24
    8ocw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784360145;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=0tbd9eIynpCcFNvu0tDpYKVIEEAcJWSMR8BWz+rY1cM=;
    b=eYhhsw1XzSlIip4reBkH1uEggHyh2HahxZ5PBmQY73W+u054FVCJwFJ0BRAl+qpkBU
    idf05c0mWWramUvB9wAA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5jns36WDHmkHWjM34E2akzSGSaC3yEQATR5mHs="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id eed0ee26I7Zj18x
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 18 Jul 2026 09:35:45 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net v3] net: dpaa: fix mode setting
Date: Sat, 18 Jul 2026 09:35:34 +0200
Message-Id: <A0ED8202-B2F7-4EDC-8BC5-0E89018111F2@xenosoft.de>
References: <4f7497cf-83ed-47cd-2e7b-d06ebe319b61@linux.dev>
Cc: Michael Walle <mwalle@kernel.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David S Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Abeni Paolo <pabeni@redhat.com>,
 Christian Zigotzky <info@xenosoft.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Trevor Dickinson <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 hypexed@yahoo.com.au
In-Reply-To: <4f7497cf-83ed-47cd-2e7b-d06ebe319b61@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
X-Mailer: iPhone Mail (23F84)

On  17 July 2026 at 11:11 am, Sean Anderson <sean.anderson@linux.dev> wrote:=


=EF=BB=BFOn 7/17/26 09:20, Michael Walle wrote:

---
I didn't grab Sean's Rb tag as this is somewhat different.
Changes in v3:
 - keep the mode setting also in .adjust_link().
 - reword the commit message, to be (hopefully) more precise
 - Link to v2: https://lore.kernel.org/r/20260710143430.2276141-1-mwalle@ker=
nel.org/
Changes in v2:
 - the setting is/was based on the maximum speed, not the current
   speed. thus, move the setting into mac_config().
 - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@ker=
nel.org/
 .../net/ethernet/freescale/fman/fman_dtsec.c    | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)
diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/=
ethernet/freescale/fman/fman_dtsec.c
index fe35703c509e..b8d70c0ecb6c 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_config *co=
nfig, unsigned int mode,
 {
     struct mac_device *mac_dev =3D fman_config_to_mac(config);
     struct dtsec_regs __iomem *regs =3D mac_dev->fman_mac->regs;
-    u32 tmp;
+    u32 ecntrl, maccfg2;
+
+    maccfg2 =3D ioread32be(&regs->maccfg2);
+    maccfg2 &=3D ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
       switch (state->interface) {
     case PHY_INTERFACE_MODE_RMII:
-        tmp =3D DTSEC_ECNTRL_RMM;
+        ecntrl =3D DTSEC_ECNTRL_RMM;
+        maccfg2 |=3D MACCFG2_NIBBLE_MODE;
         break;
     case PHY_INTERFACE_MODE_RGMII:
     case PHY_INTERFACE_MODE_RGMII_ID:
     case PHY_INTERFACE_MODE_RGMII_RXID:
     case PHY_INTERFACE_MODE_RGMII_TXID:
-        tmp =3D DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
+        ecntrl =3D DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
+        maccfg2 |=3D MACCFG2_BYTE_MODE;
         break;
     case PHY_INTERFACE_MODE_SGMII:
     case PHY_INTERFACE_MODE_1000BASEX:
     case PHY_INTERFACE_MODE_2500BASEX:
-        tmp =3D DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
+        ecntrl =3D DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
+        maccfg2 |=3D MACCFG2_BYTE_MODE;
         break;
     default:
         dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
@@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config *conf=
ig, unsigned int mode,
         return;
     }
 -    iowrite32be(tmp, &regs->ecntrl);
+    iowrite32be(ecntrl, &regs->ecntrl);
+    iowrite32be(maccfg2, &regs->maccfg2);
 }
   static void dtsec_link_up(struct phylink_config *config, struct phy_devic=
e *phy,

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

Christian, can you test this patch with ethernet at 100/1G speed if you stil=
l have
access to those P5020/P5040 boards?

- - -

Yes, I will test it as soon as possible.

- Christian=


