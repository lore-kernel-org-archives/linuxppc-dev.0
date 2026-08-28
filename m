Return-Path: <linuxppc-dev+bounces-26168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B77C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 10:20:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWZC72t3kz2y8F;
	Fri, 28 Aug 2026 20:20:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.161 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787912419;
	cv=pass; b=JyxiEnjyafUsm43T8QjAYZZPvzxryXAM4tvUxvSDwyCE1z3/t1c36o/kUbeQ9ItkhDiQEQX2akkkGsY8EmQz2hc1YTYixfQZ8oV9SWK5nnv6eMRcQfeIsCIgTzQDDQtY+cGY4hEjoP7FpS9qcGSbndV9Jw1GtJwb1KvrqKGitHV9KKJgrJ6YjiPmKxqdFTqTfIwDMaK1Eyjh4lR0nvRtZIwBzbHyNLZME4hA5AkCbX/6uqaHfEz+9l8QJiLbP2hwQFJv1/QfAmgSkSq9BPeC9NL/pmh/JciWiWHg7GBHY2iZgo6xLTNKxL/4t3nqgbUja54jWo3zz0JQefVDhbfaKw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787912419; c=relaxed/relaxed;
	bh=ZxB6U0XXTHXgyCc+Yp2cGkNK7WsFxhTBc+IGXvVh2PE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=gduWjszBEVrcrXkkemYDoXLjrpOIAn73gB7Zw6Cm8Z3rINoA9q5E0hhB/J3MFXstRfJOZhxCZvo20R7o68KFpOuysFs1LoJ4VUitfcJ/MUOGMhgfUCf8KcdcKn0CcLQ1i5MoyRNQY4o4JO7WvKWPsp9jzh0+Z10KuI8Mvtmsph0T+sKOUUHll3FXeNYZIrarAul5dV+t9PFJb6uAS+3fhjWdeb2Q07TfvMUxmNHmspxu9NHUouQ6Aanitqm+yyaAEoeDAJxlJKX0rsV/vdnbWChOth7+vK/Rsj25JtkOv41BGlaJ8ovm+6HcU2TF0slSp5OQKopTLNV29zRzw737Bw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XWyVbVjG; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=0sGy2ckv; dkim-atps=neutral; spf=pass (client-ip=81.169.146.161; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p00-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XWyVbVjG;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=0sGy2ckv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=81.169.146.161; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWZC035Vhz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 20:20:08 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1787912401; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qyk32zvNIlVrgzrpDogP3QYRJVIseAnXE5F+R9V4/6gx6kiMfJ1xbVl/IKwk1DX3io
    oQRKHhf9KWVS+KQNaFFO0jdfQivop8itnFdkNvf/ZDOJjZ3QGEL8Ld6zGqmrae2B11/G
    O1By6+WJC1i2mnIEJqSGXHEbSV5NvD9GETv6KI6T6DUq2q7TuqsGSalCzaGC+Q1rF/q5
    /luF6gHyp62cwpY5fcMNUnCJOQdbPxKBFSCdv6/TUBCL1js3PECozU5NWAgFvQqiVXX6
    v0ELu0Sd/Qg8sTfD5WYWRCVAahxcz1zLmLkyPy4SusqeYE+K6Q1e7rGhu83bv2otJf80
    FKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787912401;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=ZxB6U0XXTHXgyCc+Yp2cGkNK7WsFxhTBc+IGXvVh2PE=;
    b=LHb97XOk2PSXzbAynczyTunnVbVKwj2D304U/nof9fhXfqyfkxsCFQFdkKgQ+CxHSa
    SjcliUKkw8rtn+Qf3YYeBkKYcUUB+qY5aya45yPYbodWKml7FyINYGOOddOQUV51acd3
    YzjBnpncLFZ6b+hIAaGZg1m5sA3hl7zCdNmHEh7DStM3GwzPlLFODF3AsYki5UDkNnwk
    Yt9SpLpkp4TgKf0EB56S4HFy+izr7SjIxmClyxLnmzW09B1YfGbyZTd3CK9b+OFN0uKu
    C67rg/ojHroCjQyuAnfLA6dR6yVNC9xbZ4r3qWCXYHlZ+0dqFH6Y2Hde+gfF89s1OGxA
    b5kw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787912401;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=ZxB6U0XXTHXgyCc+Yp2cGkNK7WsFxhTBc+IGXvVh2PE=;
    b=XWyVbVjGOym3PudvQb3XHiRqehfaVgzsLNeVnpiTCmQHNQZEkiZvS+L0dI/y9JKEA4
    82jSrZGqCLQAuXgYmMPVA2SnPzPK2TCebkpggGai8XecZAiKStdN9ZcuuwRMkoFs1k1u
    8TF7rdDeP7BY+H6pCSOiBgCSWsNB8I4/3SjEWJL9/MCHhBi/3dTUwdhj1SvWXPNkyOm0
    nBEZ6omy2sfdAEoFsn0wXrxrhv0F39c5KFSQpciAWyIQo5gTFZbqHnseAnPaewsZYqJR
    xw3oHRgDi9Z73Mmf4TYCAwVooAdk7KQlbfdEcga6CpZFbF2gl0Gf6gRmIZeJxs7qwj+0
    7liw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787912401;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=ZxB6U0XXTHXgyCc+Yp2cGkNK7WsFxhTBc+IGXvVh2PE=;
    b=0sGy2ckvAlCyb7PmkM3thgclULVyIzaZHJ8IzCpQdGz7TXhw0aH3yTCDAixlYnUq3u
    ki8DT8dv/lqgq5CSNjCA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5nns3mXCXQqT4+V1jaysTyQTG/6nIMF/dB9URk="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ee2bee27SAK0Z0z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 28 Aug 2026 12:20:00 +0200 (CEST)
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
Subject: Re: drm/mgag200: Fix big-endian support
Date: Fri, 28 Aug 2026 12:19:49 +0200
Message-Id: <1805E6A7-52E7-403F-8E57-7ED951DCB1CA@xenosoft.de>
References: <a2d102b6-033d-49c9-96a6-a9edda26b4bd@suse.de>
Cc: rene@exactco.de, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Trevor Dickinson <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <a2d102b6-033d-49c9-96a6-a9edda26b4bd@suse.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
X-Mailer: iPhone Mail (23G83)

On 28 August 2026 at 07:58 am, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:

=EF=BB=BFHi

Oh well. I assume it's a ROM for x86?   I guess the PPC firmware doesn't POS=
T the graphics card, so the driver has to.  The power-up logic is given in S=
ec 4.3.3 of the MGA200 spec.  But TBH I won't have the time to work on it.  A=
t best, I can help a bit if someone wants to address the problem.

Best regards
Thomas

- - -

Hi,

Are there any Matrox cards with PowerPC roms?

Have a nice weekend,

Christian=


