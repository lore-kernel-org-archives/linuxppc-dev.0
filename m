Return-Path: <linuxppc-dev+bounces-26124-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3461BC61DBD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 17:31:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVWsY0PLjz2y32;
	Thu, 27 Aug 2026 03:31:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.22 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787765488;
	cv=pass; b=HukXuMe8/geUNwDVttresfHZr7ZOvvxzA09fSIAaBD3+OTO0ynv+cp/Tx1EYsZ0ldF0iX1lMQk89FTeCFMPtbWTTjOPuqRcY/PfvpxppjyHHwup+wKicer1xo9H4i6HtDz2s1XxB7mHFjUBuhE/O1/49Yhzz13ZWZSfLg4WIqqOJJEzXmA1yK8NThtuqIahrR1A3MoV6FSRRcNGdbZDBNxRx7Ea1BL4pOByfqZEJIJmlO4KVDzNZKcefEhyF/9+O3G9YBDSbGMwTnOYy1aOQWRfURXB4n6Ehqry84Hp1PJEr6Cqwlvp2n6Tnfa2TlTNaFSsIVgOyQpQsLIcyB27HFg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787765488; c=relaxed/relaxed;
	bh=dHFTw7/2ICxfrrbU0+VTjCyxlOfLZOUP3+UnA6phRU4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=WZt+gA0vQosFiBnmV4LD6KCvO3umOt8QaKKte9rWm+h7I4O5B6pmyJSw7oRow5lEYeVyPf8tAT3dnw7oLmuk1Mdxgg9suqzEK32jNyxKa/0C5dKgUwi/sSyaxKXyQuUsNjh/lzpulOx3x5Y8DBZS0IWRzzNmdUGhL+jmExtvCFd0H62nPPHw8r8bbpuOucX+r08P46p9T3tO4nH4KY5tvgjKARH3q/vDslZFomyjed1yfifimqilR0d5w7BIKEpRuFTOzvgBcC/XhD7BlTcm1K6bWkAgI4vjnprYsc4uO77eCX3c6rhzHprK8a8NAtVZUiFDUBg4YFZheVtGV2r+gA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=B601A8ig; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=f5Yux5kw; dkim-atps=neutral; spf=pass (client-ip=85.215.255.22; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p00-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=B601A8ig;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=f5Yux5kw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=85.215.255.22; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVWsP3fqpz2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 03:31:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1787765470; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M3uVrKwm+gOLOGVtN2a4TfEx+9puDg++eB/zrmUle1JWTHqKUgRi0E687322ars5V7
    hF4t/YCg1i9d1yw5hilLmYwjQJAP6AL5P/fIPU+zMurlkfLUdy/xbNrtmXSgFNvpiEbS
    7OlvJxmahdSCYfGgl4L4aIb4qCRdyIegzpuqSGH8WLZ3+CW8we5jrytcY1r1fWbI4JLd
    zdKAFh5HGfbhAa5d7YCBnG/ZB9g1+Iq5z6ynGMWYlw7gEbyFrOqcB60ptNQ23XkK9kcn
    yTpLdWlY5D4MCgIKKCn++GQET8pMzpQLGSjPce9LANLlVGjNcEaIsQVj58jQtMCy+Lc9
    aFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787765470;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=dHFTw7/2ICxfrrbU0+VTjCyxlOfLZOUP3+UnA6phRU4=;
    b=k5GBhtLUyheYntzWEaGdD9o5pjRx9nFut97x6tOaEDCnlxJY3wkfGUHsfahjga5lQ1
    L6EMeKGX+GgyJH31/Od3eEiYaL95HnXjZLZKkB9TcTXhrAXLDSQgDSrlC4rcOdGMZHk+
    AtL+jhwj7HZZ8caHRD5p1wwcRl5AQHFinn5fvSul//DP4E/9qJ0qmn1QCempP5lsHO5W
    WsrWoYUdfoZgpapdIqYAfv4ZHl7mT9JHJrxG3fAPA5L5uTumk+7YoM1ywjidUp5pxymd
    7doO8eWvt7aA3ATCvVSartPiOm4bHHv0SOgxmZMC9O5NLFF7ow/OizUDXQYJGXA/tLK7
    /nAQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787765470;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=dHFTw7/2ICxfrrbU0+VTjCyxlOfLZOUP3+UnA6phRU4=;
    b=B601A8igDepzqPixS05EksDPosIbskIL9pJ4LTfNf6Pqh7gEZnKBEA5WE3L53zSYuf
    Yn1eLV4BIF+YwJHV8hFACaFo0zwZlqSfOj5lXefqaI399y9LbMcVYzcnMSryNo4CURCf
    m5VuRnrOUcmKsx4tAz5sFtaPup1vDM6F6/W1AaV3SRr5G6iO5JjIJ20W0HZ21ShdFXZY
    tM/wjHTnSGPoRR5ypX3yhZ9a2uUJSjzCJzVsi4VI5yjZinIZg2VR2WtD37VwzYqZ2+Xo
    pGI5PAHFUd8kmmMZ95peOSS3RRYYH5ZCTs3lEISgtSjjt7IGbjqLtR6iT/ncd/Hxgbtr
    zDDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787765470;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=dHFTw7/2ICxfrrbU0+VTjCyxlOfLZOUP3+UnA6phRU4=;
    b=f5Yux5kwDcI8gN6SRMr8BAb0Ac8QUmB9+8Q870jTa2elraRXEqwsryg2ZnN/OQQy4K
    AaUyLjq8nSS6tiGO82CA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5qws3+VDnp3aohrb0r/qwpnIIHXHXKqUe5KakE="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ee2bee27QHVASgQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Aug 2026 19:31:10 +0200 (CEST)
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
Date: Wed, 26 Aug 2026 19:30:59 +0200
Message-Id: <A1B9BBC7-0CBA-45DC-8DA1-EEC6776CDA62@xenosoft.de>
References: <1fe9c172-c12c-4827-b9a5-2870c45e67af@suse.de>
Cc: rene@exactco.de, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Trevor Dickinson <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <1fe9c172-c12c-4827-b9a5-2870c45e67af@suse.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
X-Mailer: iPhone Mail (23G83)

On 26 August 2026 at 05:23 pm, Thomas Zimmermann <tzimmermann@suse.de> wrote=
:

=EF=BB=BFHi

Could be that we have to enable access to the ROM first. That's why it retur=
ns only 0xffff. Does the card display output when you switch on the computer=
?

Best regards
Thomas

- - -

Hello Thomas,

No, the card doesn=E2=80=99t display output when I switch on the computer.

Cheers,
Christian=


