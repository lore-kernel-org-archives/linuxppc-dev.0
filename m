Return-Path: <linuxppc-dev+bounces-29346-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59D6CC6B03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 06:14:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3kZm1rN4z3bqh;
	Tue, 13 Oct 2026 17:14:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791855356;
	cv=none; b=J/apEmx5RX2UYQFb+wDfQNlq+r5TK6wN2bVJ0GmqBJ8p+vadDUbGP+5s/beRRPD5ySBNUwlliqw18Wj/Wxns/i83fe8o3R6OFdqXqde+aPnUmo8e4rPFfIu1qmDanFvANhOBAiRSpEfQo02gaBbkXdHJAMuf94YdAZMIM00YbCG0hao7y9IeWNADW3VapyqzogBsgqEVbe6xnmXHCbvPpE37mAsplg5NdujYwVNW4HTH7zEeFRvLrXyLltwH+cPy/V5u6ESdHY77haiSYHXI0JkM025hZf9dCLbIIpZVRFe5yLuVzOJi+jP4GlA9GaOqm9qc0cZlWRPaNKyDE5Jrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791855356; c=relaxed/relaxed;
	bh=yocduj0ABMyh/bTv9hbcPrlJvMoW1kyYLcIfo6RegkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IH98EiJmmnakz7g/qOJxKGNoSh5Q/pi/B7nUXv6e8GKR1Ebvo3wWsBytMnwlur/F5gVt/V2/jA28Cqyd3Ymr2jpv54XVzZy5AvXkbqxo/4YK/f8KaoyhQ9JONre5Ba1BDBGWLvfXN9exu9jBIDMhUeoYuGTJr1OWD3VpP1B3DL25vQs1gfgt2DE9daOzL1OFm7Zuu15RtfnUqJ7AP3jNG/0zyeftO444uoVKXvT12ti7q2wxNDdbbrn/Kf4BUjcXYjeD5elofO7s95RBlywvjrIiLXQAVWbk/p8hmrPsPz9Tlpvebz13afgvmPuDN/AGHOjWZBiECP5x2inTKrUaHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=timdoug.com; dkim=pass (2048-bit key; unprotected) header.d=timdoug.com header.i=@timdoug.com header.a=rsa-sha256 header.s=fm2 header.b=YxX9qm0h; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=L9jaAj2y; dkim-atps=neutral; spf=pass (client-ip=103.168.172.147; helo=fout-a4-smtp.messagingengine.com; envelope-from=me@timdoug.com; receiver=lists.ozlabs.org) smtp.mailfrom=timdoug.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=timdoug.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=timdoug.com header.i=@timdoug.com header.a=rsa-sha256 header.s=fm2 header.b=YxX9qm0h;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=L9jaAj2y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=timdoug.com (client-ip=103.168.172.147; helo=fout-a4-smtp.messagingengine.com; envelope-from=me@timdoug.com; receiver=lists.ozlabs.org)
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3cNm125Vz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 12:35:50 +1100 (AEDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CA0D2EC0922
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 21:35:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 12 Oct 2026 21:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timdoug.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1791855346; x=1791941746; bh=yocduj0ABMyh/bTv9hbcP
	rlJvMoW1kyYLcIfo6RegkE=; b=YxX9qm0h1gyNDvweeV0CHnOxTbKTjjUtU6Foo
	2zaHLRoh81zK/ZOaR4nCxsQjdVcpVPSyTsWBCCLPt14oqqBAsxmUIZFhie824052
	p1ehC0AfVd8GNxjhOfaNXph23nCJ98GpfA7eHf9JzW/eTCExt8sI+nr4IuoPVoZe
	eN7AMrU54gmxqIwYXtH6JeIzzIHBVPEPojVMrzowx/oi6uRvAbr0Dyv+UFbLDQGe
	lXIYkWGWa77NA3i8wDDGK1q0/bYqPyvzDw2UV8Y6/b0dxrOBJAj8bnpFxDZ9dq0e
	g8ffDLKkhYnxxOTz+Gg3HL95nsdg6MwbOPe4Ta+jZ5x639RiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791855346; x=1791941746; bh=yocduj0ABMyh/bTv9hbcPrlJvMoW1kyYLcI
	fo6RegkE=; b=L9jaAj2y0nI0OWKSVDxKvoARZg7/bnnqa+LUOVkRqOKeAtEhXzY
	w/Q29FbPy4wMmDFJnrTcFUpvLokkrZ/Tgt8W2h4VK35XeVGFDnFMFUNUl0rg7z/u
	bHaKsOyqgJMMMymxpNw3e1BOkZHXwS8HzI7nfnpg26vun210at1iNa2J/rMqk7+O
	U6sX4vpnXFJuJ9n6BJ6+neFJ9etLzM7hxKsyNgR8UcPUu8qGguLEvds8RSy2sjLe
	n2PblY95PoJuP757NxEl9dfWbW0TvY/9kHswC6xfnjQK0VYSY20Rvnc11wrLOVwv
	7RbhSF65FH5ghappvA6Mf+9CwqZvuvaEwqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=timdoug.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791855346; d=timdoug.com;
	mf=PG1lQHRpbWRvdWcuY29tPg==;
	rt=PGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg==;
	s=fm2:rsa-sha256:VS+Yhw84tC8UZRC9fdXQePEK8dqA0Wmafs86aE///CfYNL2
	CoW2qMDqsjEqfNoujUuWa+pOg01vxG+y0d2CBR7S5KcfBtgwIul7S2sME+t/QuRs
	zFLYzVYdsROfxupMm0G0L6h1cOq4O+DBGRVnu38gvXqfy2NV1vlLkzw+KIMEF0k7
	UlyZneeXorh0ELpfNd7n6x/qQn0qwfi406MRDJT5ESonOQQV1WMSfVCMeVJS/uZ8
	P/2nnkepeM6EoE831XxKTOanBpbO8vMNgzyY6hb7VKv1wWHN8d8jqFzKqpwjWCJs
	Zr6SXI9KrZPTCsh5F3geKCJNm2oyZzADgVDLvzQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:8WelGVUf5dphIQ2F89IJTaWhXv1ZAojAwJqZh9CFkd0=:TCNbQGeKRAXh2LRLq1pF3WRun0kySjQuoswn8eVi6ZY=;
X-ME-Sender: <xms:8YrNaqKIlB6MxsRKi7XpVa_XPMMVxODrdU1PvTsRyt5V2UVOWFAhlQ>
    <xme:8YrNagY_0EuzN2WovgO-vo_lDi5cA_qI-0L9liozhIklzZ2qSM25fS5QWclGWQRme
    zYXLx2JD676wnTojLt0hpjmYnOblZ68ISrgf90Q-0y4oiJwW4Bd8Q>
X-ME-Received: <xmr:8YrNakB9IKVDSJeBp47CaeCrgjFFDaGvC8YeW7C6xMqDTk2rhvuCsztKPt6y>
X-ME-Proxy-Cause: dmFkZTF67q9b7fmY2tTOoiQhmTSVWZXwqMvJEdwkUZ8DSEmFTt29UUAIFfkcFFqhCEpEXv
    R3kqLflvBe6WUnJo1ku6LxFHkPzgFM/ILqkAHvJZ6eEux0LBThdrCGn+hFniXwQelhmL6B
    GapF9C+LeWGzk3PB8qlmDgM3xgCF8lgeK5JOTiLCio4o4RlNQEWrIONQsWbClWvBGYfwbw
    lpFfmrGR+yFLeFcp5UmxB6AvuOm8UKABeidGNPVWo1KZ7Q6Yxo9X1WAx0cwGgCXAfbP8EG
    OgRLVARpMopZ64aF9Xu2aEjuM2rGfBBHLx7+k5QNwhxQrosCFvKIx9TRg/pVf0qTumS2Y2
    +8OQw4nQX8C4bgS7V226SKYgqLCDBNISAzXMW+3Wt4MsHe4uA7yVxr+Lh0dHOdKX4GdDIm
    ZSAh8GPIY7i3ijleSoIuDAhnGzjm/OwSCyEdJ9Kbx5qoAi+s/z8PoLRoxwIKw8xpu96YN5
    6TQrnqgz7g07UeoDHd9sOoAMBqy+thh4g8BH+SP6Zh2PthQisXkVCwt62Gf/31+guT5c0o
    TwPXCrSZJx8LTNIjTtpk1Zgmve63e86YTgMmlt7T5YL7PZUD1yu1AboQwBT0WDDfFiSFLi
    TuI+PEEj1T3HV/9EEiRDD8nex5LO1twHV8yPjaPCZf27WXcZas8uidvfYdgg
X-ME-Proxy: <xmx:8YrNaianQW1TEM1EThVf1H1E4c9wNpd2zAsNFNJbcj8p8sZQGDaWFQ>
    <xmx:8YrNaklq81slHKomDexCgW_W2Tp9V4oCHCRpz7KyHvwIXVBlaYmGig>
    <xmx:8YrNavpBn95l-Ttu_riva2Tii27o9ATVHEFgGY8H2pjf9UWh7DY8Ig>
    <xmx:8YrNauDs3kUhIdPmGWucNT7hKsnEWnNBXNZANXWkU4DMJakHmP1FMA>
    <xmx:8orNanZppZXtrKeMQ2kmdyDT0W1j2GAdZg16aNsgPRGeR7yyqLmlas7D>
Feedback-ID: i12bc4175:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 21:35:45 -0400 (EDT)
From: Tim Douglas <me@timdoug.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	Tim Douglas <me@timdoug.com>
Subject: [PATCH 0/2] serial: pmac_zilog: two receive fixes
Date: Mon, 12 Oct 2026 21:35:39 -0400
Message-ID: <20261013013541.4535-1-me@timdoug.com>
X-Mailer: git-send-email 2.54.0
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches fix receive problems in pmac_zilog that I ran into
while bringing up the serial ports on a Performa 6200CD, a NuBus Power
Macintosh. The first stops data received on one port from being left in
its flip buffer while the other port is open. The second makes received
breaks visible; until now they arrived as plain NUL characters.

I tested both on the 6200, running 7.2.8 with an out-of-tree platform
port and a loopback plug on the printer port. Without the series, only 3
of 8 bytes written to ttyPZ1 came back while ttyPZ0 was open, and a
break sent with tcsendbreak() arrived as a NUL with no break counted.
With the series, all 8 bytes came back, the break was counted, and with
PARMRK set it read as FF 00 00.

The series also builds on v7.3-rc7 with pmac32_defconfig and W=1 without
warnings. I have not tested 68k Macs or macio Power Macs.

I found these bugs and wrote the patches with the help of Claude Opus
5.5. I have reviewed both patches and run the tests on the 6200 myself.

Tim Douglas (2):
  serial: pmac_zilog: push received data to the port that received it
  serial: pmac_zilog: report received breaks

 drivers/tty/serial/pmac_zilog.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.54.0 (Apple Git-157)


