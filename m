Return-Path: <linuxppc-dev+bounces-25620-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD71C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 19:23:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGvF506jhz3c7M;
	Sat, 08 Aug 2026 05:23:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.220 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786130584;
	cv=pass; b=DgioXfN+fwiroMyYf/C3h9Uf3uJVyyNQyQkNsQkSFLkwmtkr7W4dlZOPk/rmpi0GowbPdtYDCYknJWItP3KwJq/v2f2tn+9ntO44+MFcz4jS2duHQSMgvHeAslOjEv19y0ez0DIPMJx0/GvFt+buVPFsJ0avHZlhJ07V2zQtJ5BGDCe/2IAdiNUHqQ47jXBZ/WfmY7eoMdS268UPV92G42AxwfrLq9HB+4XLrlYArGMWGaBSEVhXKoQVSXJUOmOjn5K54oHcjMzq9k/49APmJdAKDePXlTzry3JXMqAf1pMs4MJtx0Svl9v8x81Fg2zHbylDnDRwaAon5clV696/QQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786130584; c=relaxed/relaxed;
	bh=PWRJovKFanbCN+BIuAmGj3LrZAetvoHJ84yMPG9CTXU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=cd8+0MrXpbsXOqQcpPx8E8ZJxGs0j07tbogDpnYWh1GcYzH6qT/hvfEGHb3q0EkEO94PusYAiysBSLTyppUne+FHA4DKw1tSPnIQSRIDX3+pPpbJ4ou2ltYtONxWaMdmIACgWdxGDM461q7P2kCo9B+Ze+QP0AGuQ7a2YWZL13IqvP1BOlwBOV6Wp0/lyYXowT1t/OcpH4GwQDPNZtb6GJOQUS7PxzCE4iuMQcDQuy6wplhexuscOltxV5OpGzesu1Z99nIf95u0J+WrsbKA9dhRVuco5xeTBU+LwGmA18ZcbL1dSnoqE5mfqA6fH+UQ25acwJmvbEdJxyWg5SDprw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=VmI/M1Ry; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=P0IE/VSp; dkim-atps=neutral; spf=pass (client-ip=81.169.146.220; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p00-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=VmI/M1Ry;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=P0IE/VSp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=81.169.146.220; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGvDx3vKRz3c75
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 05:22:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1786130555; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JMsS9NMlk79Z87ImiP4cG2QqpBipPWnsO+HxfhCN0q6+7gfw2FKw/9LiWPbH8THXO+
    CkbHut9m91/+k2ogfdpnWNzG9de1AeiWP/2eu0+BeXKtULqdfP/4bwocWgNc18mfYABo
    3kPqcFZu3cvBrKdN2BqqYNY4tlZubIrW6JXiUBO1bcDE2yMeIGuhFx3kgqUHZCOv3Hky
    bGZy+gAu24Kds1wmQFxAYdNu9R9QKv5c4SmYfPi3UXqdNbtIN81zzTIBqvdggrrpPStO
    4CFTKPBYfUsRxX4yuOUmIgUQ0RHhH2rFmB2FFcIMWSVIOuej84BV3P7Gisxu+jctbUI5
    EYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786130555;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=PWRJovKFanbCN+BIuAmGj3LrZAetvoHJ84yMPG9CTXU=;
    b=GrtYe1BPC60TPJTAHsJY1xqlITjznwemX/qj6Wvu+8U+crws0dapKpwL5QoIviswbW
    v2w/5QgYUkYozlf+adNOv5NkuC+8Ergn6yDIe1Rmg5BTHaRNjLpcH7w9MRoCmSMxZZ2f
    eTLC1l5ZShIvlG8hC8evmciyPlgSvhjAce2rf8xdQ/dcFcZM5TAZjkhAR9RrjPPhxMZ9
    c+867LR5aU3RcmQGBI2kn2g2yN3dm1eP5cqfgC60PdJ/79TOZs5xWmbPNerMmz/fZpJp
    syLVm5fuHLJLRxuNOq/PPn3y1H1HOhC6Vcnd9rGLi37ui8Cg4f6TL46uiuL7v48AeCzH
    v0zg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786130555;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=PWRJovKFanbCN+BIuAmGj3LrZAetvoHJ84yMPG9CTXU=;
    b=VmI/M1Ry81vZodYRjZX+cx/Zde+30y8wsGrJiBKEgpI73q1G4mIOWoRxyvwnmdNWdL
    c12RK4bgaN+TSTZNz++CBoNL3Jpb/rnFMq/sZfJLHI3rBHASEPVqh50/4LMj4g99kSTN
    ybEubmB2GiVdWaF7jeVgiS2jav+MvfqsbnWYdlDoNdEIsFz5P0y48m5qU8JzyPMa5keS
    fDnIRI1engsjpy/joTRxZCu7aPnXT8qDM/oTrkxyq0VllgYt8IvTII+fMvWva3DyMBJ0
    8i8GwuwC4AFfklLcvJkpYZzt+WnQ2VJqa1Bd3xNjFEWhZTrqiY9Fb55DjjAfaHeHotKi
    Qz5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786130555;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=PWRJovKFanbCN+BIuAmGj3LrZAetvoHJ84yMPG9CTXU=;
    b=P0IE/VSpV+qntI9jsNSwzX2c4IoEqR4lqeNzjNd157LSs3mohZhw0mGcCWp1OjI5QB
    11u0KQaYJqfMzaohc7BQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5nns3PECnTgF2nPNQ0B2f/CSNb7ke2GFZLjuTg="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id eed0ee277JMYODf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 7 Aug 2026 21:22:34 +0200 (CEST)
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
Subject: Re: [linuxppc-dev] Patch notification: 1 patch updated
Date: Fri, 7 Aug 2026 21:22:24 +0200
Message-Id: <EB51A7BA-7199-4921-BC04-3BB922B1DE92@xenosoft.de>
References: <35d19b6e-5d0f-4725-89ab-2f9aaf153f1d@kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Trevor Dickinson <rtd2@xtra.co.nz>, hypexed@yahoo.com.au
In-Reply-To: <35d19b6e-5d0f-4725-89ab-2f9aaf153f1d@kernel.org>
To: Christophe Leroy <chleroy@kernel.org>
X-Mailer: iPhone Mail (23F84)

Hi Christophe,

On 07 August 2026 at 03:52 pm, Christophe Leroy (CS GROUP) <chleroy@kernel.o=
rg> wrote:

> =EF=BB=BFHi Christian,

> Not sure what you mean, in patchwork we have:

> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260801043458.125=
00-1-chzigotzky@xenosoft.de/

I see.


> So I marked following ones as been superseded by it

Great!

Thank you for your help,

Christian=


